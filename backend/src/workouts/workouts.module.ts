import { Module } from '@nestjs/common';
import { WorkoutsService } from './workouts.service';
import { WorkoutsController } from './workouts.controller';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Workout } from '@src/typeorm/entities/workout.entity';
import { ExercisesService } from '@src/exercises/exercises.service';
import { Exercise } from '@src/typeorm/entities/exercise.entity';

@Module({
  imports: [TypeOrmModule.forFeature([Workout, Exercise])],
  controllers: [WorkoutsController],
  providers: [WorkoutsService, ExercisesService],
})
export class WorkoutsModule { }
