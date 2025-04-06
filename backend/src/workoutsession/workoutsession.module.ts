import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { LoggedSet } from '@src/typeorm/entities/loggedset.entity';
import { Workout } from '@src/typeorm/entities/workout.entity';
import { WorkoutSession } from '@src/typeorm/entities/workoutsession.entity';
import { WorkoutSessionController } from './workoutsession.controller';
import { WorkoutSessionService } from './workoutsession.service';

@Module({
    imports: [TypeOrmModule.forFeature([WorkoutSession,LoggedSet,Workout])],
    controllers: [WorkoutSessionController],
    providers:[WorkoutSessionService]

})
export class WorkoutsessionModule {}
