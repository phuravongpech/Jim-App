import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { WorkoutExercise } from '@src/typeorm/entities/workoutexercise.entity';
import { WorkoutExerciseService } from './workoutexercise.service';
import { WorkoutexerciseController } from './workoutexercise.controller';

@Module({
    imports: [TypeOrmModule.forFeature([WorkoutExercise])],
    providers: [WorkoutExerciseService],
    controllers: [WorkoutexerciseController]
})
export class WorkoutexerciseModule {}
