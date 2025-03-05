import { Module } from '@nestjs/common';
import { WorkoutsService } from './workouts.service';
import { WorkoutsController } from './workouts.controller';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Workout } from '@src/typeorm/entities/workout.entity';
import { ExercisesService } from '@src/exercises/exercises.service';
import { Exercise } from '@src/typeorm/entities/exercise.entity';
import { WorkoutExercise } from '@src/typeorm/entities/workoutexercise.entity';
import { WorkoutExerciseService } from '@src/workoutexercise/workoutexercise.service';

@Module({
  imports: [TypeOrmModule.forFeature([Workout, Exercise, WorkoutExercise])],
  controllers: [WorkoutsController],
  providers: [WorkoutsService, ExercisesService, WorkoutExerciseService],
})
export class WorkoutsModule { }
