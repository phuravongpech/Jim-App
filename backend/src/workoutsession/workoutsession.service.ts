import { Injectable, NotFoundException, InternalServerErrorException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { WorkoutSession } from '@src/typeorm/entities/workoutsession.entity';
import { GroupedLoggedSetDto, LoggedSetDto, WorkoutDto, WorkoutExerciseDto, WorkoutSessionDetailDto, WorkoutSessionDto } from './dto/get-workoutsession.dto';

@Injectable()
export class WorkoutSessionService {
  constructor(
    @InjectRepository(WorkoutSession)
    private readonly workoutSessionRepository: Repository<WorkoutSession>,
  ) { }

  async create(workoutSession: Partial<WorkoutSession>): Promise<WorkoutSession> {
    try {
      const newSession = this.workoutSessionRepository.create(workoutSession);
      return this.workoutSessionRepository.save(newSession);
    } catch (error) {
      console.error('Error creating workout session:', error);
      throw new InternalServerErrorException('Failed to create workout session');
    }
  }

  async findOne(sessionId: number): Promise<WorkoutSessionDetailDto> {
    const workoutSession = await this.workoutSessionRepository.findOne({
      where: { id: sessionId },
      relations: ['workout', 'loggedSets.workoutExercise.exercise'],
    });

    if (!workoutSession) {
      throw new NotFoundException(`Workout session with ID ${sessionId} not found`);
    }

    // Grouping logged sets by thier exercise
    const groupedLoggedSets: GroupedLoggedSetDto[] = Object.values(
      workoutSession.loggedSets.reduce((group, currentSet) => {
        const workoutExerciseId = currentSet.workoutExercise.id;

        // Using workoutExerciseId as a key
        // If group[workoutExerciseId] doesn't aleady exist, create a a group for it
        if (!group[workoutExerciseId]) {
          group[workoutExerciseId] = new GroupedLoggedSetDto(
            workoutExerciseId,
            currentSet.workoutExercise.exercise.name,
            []
          );
        }

        // Add logged set to the group
        group[workoutExerciseId].sets.push(
          new LoggedSetDto(
            currentSet.setNumber,
            currentSet.weight,
            currentSet.rep
          )
        );

        return group;

      }, {} as Record<number, GroupedLoggedSetDto>)
    );

    return new WorkoutSessionDetailDto(
      workoutSession.id,
      workoutSession.startWorkout,
      workoutSession.endWorkout,
      workoutSession.workout.name,
      groupedLoggedSets
    );
  }

  async findAll(): Promise<WorkoutSessionDto[]> {
    const workoutSessions = await this.workoutSessionRepository.find({
      relations: ['workout', 'workout.workoutExercises.exercise'],
    });

    return workoutSessions.map((workoutSession) => {
      const workoutDto = new WorkoutDto(
        workoutSession.workout.id,
        workoutSession.workout.name,
        workoutSession.workout.description,
        workoutSession.workout.workoutExercises.map((exercise) =>
          new WorkoutExerciseDto(
            exercise.exerciseId,
            exercise.exercise.name,
            exercise.restTimeSecond,
            exercise.setCount
          )
        )
      );

      return new WorkoutSessionDto(
        workoutSession.id,
        workoutSession.startWorkout,
        workoutSession.endWorkout,
        workoutDto.name,
        workoutDto.descriptions,
        workoutDto.workoutExercises
      );
    });
  }

  async update(sessionId: number, workoutSession: Partial<WorkoutSession>): Promise<WorkoutSession> {
    try {
      await this.workoutSessionRepository.update(sessionId, workoutSession);
      return this.workoutSessionRepository.findOneOrFail({ where: { id: sessionId } });
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