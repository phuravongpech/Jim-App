import { Injectable } from '@nestjs/common';
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
    return await this.workoutRepository.save(workout);
  }

  findAll() {
    return `This action returns all workouts`;
  }

  findOne(id: number) {
    return `This action returns a #${id} workout`;
  }

  remove(id: number) {
    return `This action removes a #${id} workout`;
  }
}
