import { Injectable, NotFoundException } from '@nestjs/common';
import { CreateWorkoutDto } from './dto/create-workout.dto';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Workout } from '../typeorm/entities/workout.entity';
import { ResponseService, ResponsePayload } from '../common/services/response.service';
import { UpdateWorkoutDto } from './dto/update-workout.dto';

@Injectable()
export class WorkoutsService {
  constructor(
    @InjectRepository(Workout)
    private readonly workoutRepository: Repository<Workout>,
    private readonly responseService: ResponseService,
  ) { }

  async create(createWorkoutDto: CreateWorkoutDto): Promise<ResponsePayload<Workout>> {
    try {
      const workout = this.workoutRepository.create(createWorkoutDto);
      const savedWorkout = await this.workoutRepository.save(workout);

      return this.responseService.created(savedWorkout, 'Workout created successfully');

    } catch (error) {
      return this.responseService.error('Failed to create workout', error.status || 500);
    }
  }

  async findAll(): Promise<ResponsePayload<Workout[]>> {
    try {
      const workouts = await this.workoutRepository.find();

      return this.responseService.success(workouts, 'All workouts fetched successfully');

    } catch (error) {
      return this.responseService.error('Failed request all workouts', error.status || 500);
    }
  }

  async findOne(id: number): Promise<ResponsePayload<Workout | null>> {
    try {
      const workout = await this.workoutRepository.findOne({ where: { id } });

      if (!workout) {
        return this.responseService.notFound('Workout');
      }

      return this.responseService.success(workout, 'Workout fetched successfully');

    } catch (error) {
      return this.responseService.error('Failed request all workouts', error.status || 500);
    }
  }

  async update(id: number, updateWorkoutDto: UpdateWorkoutDto): Promise<ResponsePayload<Workout | null>> {
          try {
              const workout = await this.workoutRepository.findOne({ where: { id } });
  
              if (!workout) {
                  return this.responseService.notFound('Workout exercise');
              }
  
              Object.assign(workout, updateWorkoutDto);
              const updatedWorkout = await this.workoutRepository.save(workout);
  
              return this.responseService.success(updatedWorkout, 'Workout updated successfully');
          } catch (error) {
              return this.responseService.error('Failed to update workout', error.status || 500);
          }
      }

  async remove(id: number): Promise<ResponsePayload<Workout | null>> {
    try {
      const workout = await this.workoutRepository.findOne({ where: { id } });

      if (!workout) {
        return this.responseService.notFound('Workout');
      }

      await this.workoutRepository.remove(workout);

      return this.responseService.success(null, 'Workout deleted successfully');

    } catch (error) {
      return this.responseService.error('Failed to delete workout', error.status || 500);
    }
  }
}
