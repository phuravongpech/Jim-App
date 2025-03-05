import {
  ConflictException,
  Injectable,
  InternalServerErrorException,
  NotFoundException,
} from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { CreateWorkoutExerciseDto } from './dto/create-workoutexercise.dto';
import { WorkoutExercise } from '@src/typeorm/entities/workoutexercise.entity';
import { UpdateWorkoutExerciseDto } from './dto/update-workoutexercise.dto';

@Injectable()
export class WorkoutExerciseService {
  constructor(
    @InjectRepository(WorkoutExercise)
    private readonly workoutExerciseRepository: Repository<WorkoutExercise>,
  ) { }

  async create(createWorkoutExerciseDto: CreateWorkoutExerciseDto): Promise<WorkoutExercise> {
    try {
      const workoutExercise = this.workoutExerciseRepository.create(
        createWorkoutExerciseDto,
      );
      return this.workoutExerciseRepository.save(workoutExercise);
    } catch (e) {
      console.error(e);
      if (e.code === 'ER_DUP_ENTRY') {
        throw new ConflictException(
          'Workout Exercise with this name already exist',
        );
      }
      throw new InternalServerErrorException(
        'Failed to Create workoutExercise',
      );
    }
  }

  async findAll(): Promise<WorkoutExercise[]> {
    return this.workoutExerciseRepository.find();
  }

  async findOne(id: number): Promise<WorkoutExercise> {
    const workoutExercise = await this.workoutExerciseRepository.findOne({
      where: { id },
    });
    if (!workoutExercise) {
      throw new NotFoundException(`Workout Exercise with ID ${id} Not Found`);
    }
    return workoutExercise;
  }

  async update(
    id: number,
    updateWorkoutExerciseDto: UpdateWorkoutExerciseDto,
  ): Promise<WorkoutExercise> {
    try {
      const result = await this.workoutExerciseRepository.update(
        id,
        updateWorkoutExerciseDto,
      );
      if (result.affected === 0) {
        throw new NotFoundException(`Workout Exercise with ID ${id} not found`);
      }
      return this.findOne(id);
    } catch (e) {
      console.error(e);
      throw new InternalServerErrorException(
        'Failed to update Workout Exercise',
      );
    }
  }

  async delete(id: number): Promise<void> {
    const result = await this.workoutExerciseRepository.delete(id);
    if (result.affected === 0) {
      throw new NotFoundException(`Workout Exercise with ID ${id} not found`);
    }
  }
}
