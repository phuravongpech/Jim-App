import {
  ConflictException,
  Injectable,
  InternalServerErrorException,
} from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { CreateWorkoutExerciseDto } from './dto/create-workoutexercise.dto';
import { WorkoutExercise } from '@src/typeorm/entities/workoutexercise.entity';

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

  async deleteByWorkoutId(workoutId: number): Promise<void> {
    try {
      const result = await this.workoutExerciseRepository.delete({ workoutId });
  
      if (result.affected === 0) {
        console.warn(`No WorkoutExercise entries found for workoutId ${workoutId}`);
      }
    } catch (e) {
      console.error(e);
      throw new InternalServerErrorException(
        `Failed to delete Workout Exercises for workoutId ${workoutId}`,
      );
    }
  }
}
