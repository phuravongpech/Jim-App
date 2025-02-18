import { Injectable, Logger } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { ResponsePayload, ResponseService } from '@src/common/services/response.service';
import { WorkoutExercise } from '@src/typeorm/entities/workoutexercise.entity';
import { Repository } from 'typeorm';
import { CreateWorkoutExerciseDto } from './dto/create-workoutexercise.dto';
import { UpdateWorkoutExerciseDto } from './dto/update-workoutexercise.dto';

@Injectable()
export class WorkoutExerciseService {
    private readonly logger = new Logger(WorkoutExerciseService.name);

    constructor(
        @InjectRepository(WorkoutExercise)
        private readonly workoutExerciseRepository: Repository<WorkoutExercise>,
        private readonly responseService: ResponseService
    ){}
    
    async create(createWorkoutExerciseDto: CreateWorkoutExerciseDto): Promise<ResponsePayload<WorkoutExercise>> {
        try {
          const workoutExercise = new WorkoutExercise();
          Object.assign(workoutExercise, createWorkoutExerciseDto);
          const savedWorkoutExercise = await this.workoutExerciseRepository.save(workoutExercise);
    
          return this.responseService.created(savedWorkoutExercise, 'Workout exercise created successfully');
        } catch (error) {
          this.logger.error('Error creating workout exercise', error);
          return this.responseService.error('Failed to create workout exercise', error.status || 500);
        }
    }

    async findAll(): Promise<ResponsePayload<WorkoutExercise[]>> {
        try {
          const workoutExercises = await this.workoutExerciseRepository.find();
          return this.responseService.success(workoutExercises, 'All workout exercises fetched successfully');
        } catch (error) {
          this.logger.error('Error fetching workout exercises', error);
          return this.responseService.error('Failed to fetch workout exercises', error.status || 500);
        }
    }

    async findByWorkoutId(workoutId: number): Promise<ResponsePayload<WorkoutExercise | null>> {
        try {
          const workoutExercises = await this.workoutExerciseRepository.findOne({ where: { id: workoutId } });
    
          if (!workoutExercises) {
            return this.responseService.notFound('Workout exercises for the given workout ID');
          }
    
          return this.responseService.success(workoutExercises, 'Workout exercises fetched successfully');
        } catch (error) {
          this.logger.error('Error fetching workout exercises by workout ID', error);
          return this.responseService.error('Failed to fetch workout exercises', error.status || 500);
        }
    }

    async update(id: number, updateWorkoutExerciseDto: UpdateWorkoutExerciseDto): Promise<ResponsePayload<WorkoutExercise | null>> {
        try {
            const workoutExercise = await this.workoutExerciseRepository.findOne({ where: { id } });

            if (!workoutExercise) {
                return this.responseService.notFound('Workout exercise');
            }

            Object.assign(workoutExercise, updateWorkoutExerciseDto);
            const updatedWorkoutExercise = await this.workoutExerciseRepository.save(workoutExercise);

            return this.responseService.success(updatedWorkoutExercise, 'Workout exercise updated successfully');
        } catch (error) {
            this.logger.error('Error updating workout exercise', error);
            return this.responseService.error('Failed to update workout exercise', error.status || 500);
        }
    }

    async remove(id: number): Promise<ResponsePayload<WorkoutExercise | null>> {
        try {
          const workoutExercise = await this.workoutExerciseRepository.findOne({ where: { id } });
    
          if (!workoutExercise) {
            return this.responseService.notFound('Workout exercise');
          }
    
          await this.workoutExerciseRepository.remove(workoutExercise);
          return this.responseService.success(null, 'Workout exercise deleted successfully');
        } catch (error) {
          this.logger.error('Error deleting workout exercise', error);
          return this.responseService.error('Failed to delete workout exercise', error.status || 500);
        }
      }
}
