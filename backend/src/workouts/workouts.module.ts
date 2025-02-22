import { Module } from '@nestjs/common';
import { WorkoutsService } from './workouts.service';
import { WorkoutsController } from './workouts.controller';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Workout } from '@src/typeorm/entities/workout.entity';
import { WorkoutExercise } from '@src/typeorm/entities/workoutexercise.entity';

@Module({
  imports: [TypeOrmModule.forFeature([Workout])], 
  controllers: [WorkoutsController],
  providers: [WorkoutsService],
  exports: [TypeOrmModule.forFeature([WorkoutExercise])]
})
export class WorkoutsModule {}
