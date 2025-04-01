import { Injectable, NotFoundException, InternalServerErrorException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { WorkoutSession } from '@src/typeorm/entities/workoutsession.entity';

@Injectable()
export class WorkoutSessionService {
  constructor(
    @InjectRepository(WorkoutSession)
    private readonly workoutSessionRepository: Repository<WorkoutSession>,
  ) {}

  async create(workoutSession: Partial<WorkoutSession>): Promise<WorkoutSession> {
    try {
      const newSession = this.workoutSessionRepository.create(workoutSession);
      return this.workoutSessionRepository.save(newSession);
    } catch (error) {
      console.error('Error creating workout session:', error);
      throw new InternalServerErrorException('Failed to create workout session');
    }
  }

  async findOne(sessionId: number): Promise<WorkoutSession> {
    const workoutSession = await this.workoutSessionRepository.findOne({
      where: { id: sessionId },
      relations: ['workout'],
    });

    if (!workoutSession) {
      throw new NotFoundException(`Workout session with ID ${sessionId} not found`);
    }

    return workoutSession;
  }

  async findAll(): Promise<WorkoutSession[]> {
    return this.workoutSessionRepository.find();
  }

  async update(sessionId: number, workoutSession: Partial<WorkoutSession>): Promise<WorkoutSession> {
    try {
      await this.workoutSessionRepository.update(sessionId, workoutSession);
      return this.findOne(sessionId);
    } catch (error) {
      console.error('Error updating workout session:', error);
      throw new InternalServerErrorException('Failed to update workout session');
    }
  }

  async delete(sessionId: number): Promise<void> {
    const result = await this.workoutSessionRepository.delete(sessionId);
    if (result.affected === 0) {
      throw new NotFoundException(`Workout session with ID ${sessionId} not found`);
    }
  }

  async findWorkoutSessionWithLoggedSet(sessionId: number) {
    try {
      // fetch the WorkoutSession first, along with the related Workout and LoggedSets
      const workoutSession = await this.workoutSessionRepository.findOne({
        where: { id: sessionId },
        relations: ['workout', 'loggedSets'],
      });
  
      if (!workoutSession) {
        throw new Error('Workout session not found');
      }
  
      //workoutSession contains both the Workout and related LoggedSets
      console.log('Workout Session:', workoutSession);
  
      return {
        workoutSession,
      };
    } catch (error) {
      console.error('Error fetching workout session with LoggedSet:', error);
      throw error;
    }
  }
}