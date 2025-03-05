import { Module } from '@nestjs/common';
import { ActivitylogController } from './activitylog.controller';
import { TypeOrmModule } from '@nestjs/typeorm';
import { ActivitylogService } from './activitylog.service';
import { ActivityLog } from '@src/typeorm/entities/activitylog.entity';
import { WorkoutExercise } from '@src/typeorm/entities/workoutexercise.entity';
import { WorkoutexerciseModule } from '@src/workoutexercise/workoutexercise.module';

@Module({
    imports: [TypeOrmModule.forFeature([ActivityLog, WorkoutExercise]), WorkoutexerciseModule],
    controllers: [ActivitylogController],
    providers: [ActivitylogService],
})
export class ActivitylogModule {}
