import { Module } from '@nestjs/common';
import { LoggedSetController } from './loggedset.controller';
import { TypeOrmModule } from '@nestjs/typeorm';
import { LoggedSetService } from './loggedset.service';
import { LoggedSet } from '@src/typeorm/entities/loggedset.entity';
import { WorkoutExercise } from '@src/typeorm/entities/workoutexercise.entity';
import { WorkoutexerciseModule } from '@src/workoutexercise/workoutexercise.module';

@Module({
    imports: [TypeOrmModule.forFeature([LoggedSet, WorkoutExercise]), WorkoutexerciseModule],
    controllers: [LoggedSetController],
    providers: [LoggedSetService],
})
export class LoggedSetModule {}
