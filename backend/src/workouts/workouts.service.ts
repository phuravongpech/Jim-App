import {
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

@Injectable()
export class WorkoutsService {
  constructor(
    @InjectRepository(Workout)
    private workoutRepository: Repository<Workout>,
    private readonly exerciseService: ExercisesService,
  ) { }

  async create(createWorkoutDto: CreateWorkoutDto): Promise<Workout> {
    try {
      const { exercises, ...workoutDetails } = createWorkoutDto;
      
      for (const exercise of exercises) {
        await this.exerciseService.create(exercise);
      }

      const workout = this.workoutRepository.create(workoutDetails);

      return this.workoutRepository.save(workout);
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
    try {
      const result = await this.workoutRepository.update(id, updateWorkoutDto);
      if (result.affected === 0) {
        throw new NotFoundException(`Workout with ID ${id} not found`);
      }
      return this.findOne(id);
    } catch (e) {
      console.error(e);
      throw new InternalServerErrorException('Failed to update workout');
    }
  }

  async delete(id: number): Promise<void> {
    const result = await this.workoutRepository.delete(id);
    if (result.affected === 0) {
      throw new NotFoundException(`Workout with ID ${id} not found`);
    }
  }
}
