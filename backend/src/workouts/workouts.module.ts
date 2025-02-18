import { Module } from '@nestjs/common';
import { WorkoutsService } from './workouts.service';
import { WorkoutsController } from './workouts.controller';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Workout } from '@src/typeorm/entities/workout.entity';
import { ResponseService } from '../common/services/response.service';
import { WorkoutExercise } from '@src/typeorm/entities/workoutexercise.entity';
import { WorkoutExerciseService } from '@src/workoutexercise/workoutexercise.service';

@Module({
  imports: [TypeOrmModule.forFeature([Workout, WorkoutExercise])],
  controllers: [WorkoutsController],
  providers: [WorkoutsService, ResponseService, WorkoutExerciseService],
})
export class WorkoutsModule {}
