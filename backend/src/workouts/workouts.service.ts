import { Injectable, NotFoundException } from '@nestjs/common';
import { CreateWorkoutDto } from './dto/create-workout.dto';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Workout } from '../typeorm/entities/workout.entity';

@Injectable()
export class WorkoutsService {
  constructor(
    @InjectRepository(Workout)
    private readonly workoutRepository: Repository<Workout>,
  ) { }

  async create(createWorkoutDto: CreateWorkoutDto): Promise<Workout> {
    const workout = this.workoutRepository.create(createWorkoutDto);
    return this.workoutRepository.save(workout);
  }

  async findAll(): Promise<Workout[]> {
    const workouts = this.workoutRepository.find();
    return workouts;
  }

  async findOne(id: number): Promise<Workout | null> {
    const workout = this.workoutRepository.findOne({
      where: { id }
    });

    if (!workout) {
      throw new NotFoundException(`Workout with ID ${id} not found`);
    }

    return workout;
  }

  remove(id: number) {
    return `This action removes a #${id} workout`;
  }
}
