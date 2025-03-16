import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { ActivityLog } from '@src/typeorm/entities/activitylog.entity';
import { Workout } from '@src/typeorm/entities/workout.entity';
import { WorkoutExercise } from '@src/typeorm/entities/workoutexercise.entity';
import { WorkoutSession } from '@src/typeorm/entities/workoutsession.entity';
import { WorkoutSessionService } from './workoutsession.service';
import { WorkoutSessionController } from './workoutsession.controller';

@Module({
  imports: [TypeOrmModule.forFeature([WorkoutSession, Workout, ActivityLog, WorkoutExercise])],
  providers: [WorkoutSessionService],
  controllers: [WorkoutSessionController],
})
export class WorkoutSessionModule {}
