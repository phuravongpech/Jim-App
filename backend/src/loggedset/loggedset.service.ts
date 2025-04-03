import { ConflictException, Injectable, InternalServerErrorException, Logger, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { LoggedSet } from '@src/typeorm/entities/loggedset.entity';
import { In, Repository } from 'typeorm';
import { CreateLoggedSetDto, CreateWorkoutSessionWithSetsDto } from './dto/create-loggedset.dto';
import { UpdateLoggedSetDto } from './dto/update-loggedset.dto';
import { WorkoutExercise } from '@src/typeorm/entities/workoutexercise.entity';
import { WorkoutSession } from '@src/typeorm/entities/workoutsession.entity';

@Injectable()
export class LoggedSetService {
  constructor(
    @InjectRepository(LoggedSet)
    private readonly loggedSetRepository: Repository<LoggedSet>,
    @InjectRepository(WorkoutExercise)
    private workoutExerciseRepository: Repository<WorkoutExercise>,
    @InjectRepository(WorkoutSession)
    private workoutSessionRepository: Repository<WorkoutSession>,
  ) { }

  async create(createWorkoutSessionWithSetsDto: CreateWorkoutSessionWithSetsDto): Promise<LoggedSet[]> {
    try {
      const { workoutId, startWorkout: startTime, endWorkout: endTime, loggedSets } = createWorkoutSessionWithSetsDto;

      // Extract unique workoutExerciseIds from the DTOs
      const uniqueWorkoutExerciseIds = [
        ...new Set(loggedSets.map(dto => dto.workoutExerciseId))
      ];

      // Fetch only unique workout exercises from the database
      const workoutExercises = await this.workoutExerciseRepository.findBy({
        id: In(uniqueWorkoutExerciseIds),
      });

      // Validate that all required workoutExerciseIds exist
      const foundExerciseIds = new Set(workoutExercises.map(we => we.id));
      const missingIds = uniqueWorkoutExerciseIds.filter(id => !foundExerciseIds.has(id));

      if (missingIds.length > 0) {
        throw new NotFoundException(`Workout Exercises not found for IDs: ${missingIds.join(', ')}`);
      }

      const workoutSession = this.workoutSessionRepository.create({
        workoutId: workoutId,
        startWorkout: startTime,
        endWorkout: endTime,
      });

      const workoutSessionId = (await this.workoutSessionRepository.save(workoutSession)).id;

      // Attach workoutSessionId to each logged set
      const loggedSetsWithSession = loggedSets.map(set => ({
        ...set,
        workoutSessionId: workoutSessionId, // Add the session ID
      }));

      // Save logged sets with workoutSessionId
      const loggedSet = this.loggedSetRepository.create(loggedSetsWithSession);
      return this.loggedSetRepository.save(loggedSet);

    } catch (e) {
      console.error(e);

      if (e.code === 'ER_DUP_ENTRY') {
        throw new ConflictException('Logged Set with this name already exist');
      }
      throw new InternalServerErrorException('Failed to Logged Set');
    }
  }

  async findAll(): Promise<LoggedSet[]> {
    return this.loggedSetRepository.find();
  }

  async findOne(id: number): Promise<LoggedSet> {
    const LoggedSet = await this.loggedSetRepository.findOne({ where: { id } });
    if (!LoggedSet) {
      throw new NotFoundException(`Logged Set with ID ${id} Not Found`);
    }
    return LoggedSet;
  }

  async update(id: number, updateLoggedSetDto: UpdateLoggedSetDto): Promise<LoggedSet> {
    try {
      const result = await this.loggedSetRepository.update(id, updateLoggedSetDto);
      if (result.affected === 0) {
        throw new NotFoundException(`Logged Set with ID ${id} not found`);
      }
      return this.findOne(id);
    }
    catch (e) {
      console.error(e);
      throw new InternalServerErrorException('Failed to update Logged Set');
    }
  }

  async delete(id: number): Promise<void> {
    const result = await this.loggedSetRepository.delete(id);
    if (result.affected === 0) {
      throw new NotFoundException(`Logged Set with ID ${id} not found`);
    }
  }
}
