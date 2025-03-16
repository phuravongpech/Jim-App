import {
  ConflictException,
  Injectable,
  InternalServerErrorException,
  NotFoundException,
} from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { ActivityLog } from '@src/typeorm/entities/activitylog.entity';
import { WorkoutExercise } from '@src/typeorm/entities/workoutexercise.entity';
import { WorkoutSession } from '@src/typeorm/entities/workoutsession.entity';
import { Repository } from 'typeorm';
import { CreateWorkoutSessionDto } from './dto/create-workoutsession.dto';
import { Workout } from '@src/typeorm/entities/workout.entity';
import { UpdateWorkoutSessionDto } from './dto/update-workoutsession.dto';

@Injectable()
export class WorkoutSessionService {
  constructor(
    @InjectRepository(WorkoutSession)
    private readonly workoutSessionRepository: Repository<WorkoutSession>,
    @InjectRepository(Workout)
    private readonly workoutRepository: Repository<Workout>,
    @InjectRepository(ActivityLog)
    private readonly activityLogRepository: Repository<ActivityLog>,
    @InjectRepository(WorkoutExercise)
    private readonly workoutExerciseRepository: Repository<WorkoutExercise>,
  ) {}

  async create(
    createWorkoutSessionDto: CreateWorkoutSessionDto,
  ): Promise<WorkoutSession> {
    try {
      const workout = await this.workoutRepository.findOne({
        where: { id: createWorkoutSessionDto.workoutId },
      });
      if (!workout) {
        throw new NotFoundException(
          `Workout with ID ${createWorkoutSessionDto.workoutId} not found`,
        );
      }

      const workoutSession = this.workoutSessionRepository.create({
        ...createWorkoutSessionDto,
        workout: workout,
      });
      return this.workoutSessionRepository.save(workoutSession);
    } catch (e) {
      console.error(e);
      if (e.code === 'ER_DUP_ENTRY') {
        throw new ConflictException('Workout Session already exists');
      }
      throw new InternalServerErrorException(
        'Failed to create Workout Session',
      );
    }
  }
  async findAll(): Promise<WorkoutSession[]> {
    return this.workoutSessionRepository.find({ relations: ['workout'] });
  }
  async findOne(id: number): Promise<WorkoutSession> {
    const workoutSession = await this.workoutSessionRepository.findOne({
      where: { id },
      relations: ['workout'],
    });

    if (!workoutSession) {
      throw new NotFoundException(`Workout Session with ID ${id} not found`);
    }

    return workoutSession;
  }
  async update(
    id: number,
    updateWorkoutSessionDto: UpdateWorkoutSessionDto,
  ): Promise<WorkoutSession> {
    try {
      const updateData = {
        ...updateWorkoutSessionDto,
        workoutId: updateWorkoutSessionDto.workoutId
          ? { id: updateWorkoutSessionDto.workoutId }
          : undefined,
      };
      await this.workoutSessionRepository.update(id, updateData);
      return this.findOne(id);
    } catch (e) {
      console.error(e);
      throw new InternalServerErrorException(
        'Failed to update Workout Session',
      );
    }
  }

  async delete(id: number): Promise<void> {
    const result = await this.workoutSessionRepository.delete(id);
    if (result.affected === 0) {
      throw new NotFoundException(`Workout Session with ID ${id} not found`);
    }
  }

  async findWorkoutSessionWithActivities(sessionId: number) {
    try {
      const workoutSession = await this.workoutSessionRepository.findOne({
        where: { id: sessionId },
        relations: ['workout', 'activityLogs'],
      });
  
      if (!workoutSession) {
        throw new Error('Workout session not found');
      }
  
      console.log('Workout Session:', workoutSession);
  
      return {
        workoutSession,
      };
    } catch (error) {
      console.error('Error fetching workout session with activities:', error);
      throw error;
    }
  }
  
}
