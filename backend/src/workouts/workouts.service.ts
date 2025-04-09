import {
  BadRequestException,
  ConflictException,
  Injectable,
  InternalServerErrorException,
  NotFoundException,
} from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Workout } from '../typeorm/entities/workout.entity';
import { Repository } from 'typeorm';
import { CreateWorkoutDto } from './dto/create-workout.dto';
import { UpdateWorkoutDto } from './dto/update-workout.dto';
import { ExercisesService } from '@src/exercises/exercises.service';
import { WorkoutExerciseService } from '@src/workoutexercise/workoutexercise.service';

@Injectable()
export class WorkoutsService {
  constructor(
    @InjectRepository(Workout)
    private workoutRepository: Repository<Workout>,
    private readonly exerciseService: ExercisesService,
    private readonly workoutExerciseService: WorkoutExerciseService,
  ) { }

  async create(createWorkoutDto: CreateWorkoutDto): Promise<Workout> {
    try {
      const { exercises, workoutExercises, ...workoutDetails } =
        createWorkoutDto;

      // Saving workout first regardless of exercise saving status
      const workout = this.workoutRepository.create(workoutDetails);
      const savedWorkout = await this.workoutRepository.save(workout);

      // Save workoutId for relationship creation
      const workoutId = savedWorkout.id;

      // Process exercises saving concurrently
      // (only new exercises get saved because of create method machanism in exerciseService)
      const exerciseResults = await Promise.allSettled(
        exercises.map((exercise) => this.exerciseService.create(exercise)),
      );

      // Log errors for each exercise that failed to be saved.
      // Note: Null return also mean that the system succeed the task, becuase it found already exist exercise
      // Check the create method of exerciseSercice for more info
      exerciseResults.forEach((result, index) => {
        if (result.status === 'rejected') {
          console.warn(
            `Exercise creation failed: ${exercises[index].name}`,
            result.reason,
          );
        }
      });

      // Similar to the top, relationship are created concurrently
      const relationshipResults = await Promise.allSettled(
        workoutExercises.map((workoutExercise) => {
          this.workoutExerciseService.create({
            workoutId: workoutId,
            exerciseId: String(workoutExercise.id),
            restTimeSecond: workoutExercise.restTimeSecond,
            setCount: workoutExercise.setCount,
          });
        }),
      );

      relationshipResults.forEach((result, index) => {
        if (result.status === 'rejected') {
          console.warn(
            `Exercise and Workout relationship creation failed: ${workoutExercises[index].id}`,
            result.reason,
          );
        }
      });

      return savedWorkout;
    } catch (e) {
      console.error(e);
      if (e.code === 'ER_DUP_ENTRY') {
        throw new ConflictException('Workout with this name already exist');
      }
      throw new InternalServerErrorException('Failed to Create workout');
    }
  }

  async findAll(): Promise<Workout[]> {
    return this.workoutRepository.find();
  }

  async findOne(id: number): Promise<Workout> {
    const workout = await this.workoutRepository.findOne({ where: { id } });
    if (!workout) {
      throw new NotFoundException(`Workout with ID ${id} Not Found`);
    }
    return workout;
  }

  async update(
    id: number,
    updateWorkoutDto: UpdateWorkoutDto,
  ): Promise<Workout> {

    // Check if the workout exists
    const existingWorkout = await this.workoutRepository.findOne({ where: { id } });
    if (!existingWorkout) {
      throw new NotFoundException(`Workout with ID ${id} not found`);
    }
    
    try {
      const { exercises, workoutExercises, ...workoutDetails } = updateWorkoutDto;

      // Check if exercises and workoutExercises are provided
      if (!exercises || exercises.length === 0) {
        throw new BadRequestException('No exercises provided for the workout');
      }
      if (!workoutExercises || workoutExercises.length === 0) {
        throw new BadRequestException('No workout exercises provided for the workout');
      }

      // Update workout details first
      await this.workoutRepository.update(id, workoutDetails);
      const updatedWorkout = await this.findOne(id); // Ensure workout exists

      // Delete existing workout-exercise relationships
      // We can update the existing workout-exercise relationships
      // This will be more efficient, but for simplicity, we will delete and reattach them
      await this.workoutExerciseService.deleteByWorkoutId(id);

      // Process exercises saving concurrently
      // (only new exercises get saved because of create method machanism in exerciseService)
      const exerciseResults = await Promise.allSettled(
        (exercises).map((exercise) => this.exerciseService.create(exercise))
      );

      const exerciseIds = exerciseResults
        .map((result) => (result.status === 'fulfilled' && result.value ? result.value.id : null))
        .filter((id) => id !== null);

      exerciseResults.forEach((result, index) => {
        if (result.status === 'rejected') {
          console.warn(
            `Exercise creation failed: ${exercises[index].name}`,
            result.reason
          );
        }
      });

      // Process workout-exercise relationships concurrently (reattaching)
      const relationshipResults = await Promise.allSettled(
        workoutExercises.map((workoutExercise, index) => {
          if (!exerciseIds[index]) return Promise.resolve(); // Skip failed exercises
          return this.workoutExerciseService.create({
            workoutId: id,
            exerciseId: String(exerciseIds[index]),
            restTimeSecond: workoutExercise.restTimeSecond,
            setCount: workoutExercise.setCount,
          });
        })
      );

      relationshipResults.forEach((result, index) => {
        if (result.status === 'rejected') {
          console.warn(
            `WorkoutExercise relationship creation failed: ${workoutExercises[index].id}`,
            result.reason
          );
        }
      });

      return updatedWorkout;
    } catch (e) {
      console.error(e);
      if (e.code === 'ER_DUP_ENTRY') {
        throw new ConflictException('Workout with this name already exists');
      }
      throw new InternalServerErrorException('Failed to update workout');
    }
  }

  async delete(id: number): Promise<{ message: string }> {
    const result = await this.workoutRepository.softDelete(id);
    if (result.affected === 0) {
      throw new NotFoundException(`Workout with ID ${id} not found`);
    }
    return { message: `Workout with ID ${id} deleted successfully` };
  }

  async findWithExercises(): Promise<any> {
    const workouts = await this.workoutRepository.find({
      relations: ['workoutExercises', 'workoutExercises.exercise']
    });

    const formattedWorkout = workouts.map(workout => ({
      id: workout.id,
      name: workout.name,
      description: workout.description,
      createdAt: workout.createdAt,
      updatedAt: workout.updatedAt,
      exerciseCount: workout.workoutExercises.length,
    }));

    return formattedWorkout;
  }

  async findOneWithExercises(id: number): Promise<Workout> {
    const workout = await this.workoutRepository.findOne({
      where: { id },
      relations: ['workoutExercises', 'workoutExercises.exercise'],
    });
    if (!workout) {
      throw new NotFoundException(`Workout with ID ${id} Not Found`);
    }
    return workout;
  }
}
