import { Module } from '@nestjs/common';
import { ConfigModule, ConfigService } from '@nestjs/config';
import { AppConfig, DatabaseConfig } from './config';
import { TypeOrmModule } from '@nestjs/typeorm';
import { ExercisesModule } from './exercises/exercises.module';
import { WorkoutsModule } from './workouts/workouts.module';
import { LoggedSetModule } from './loggedset/loggedset.module';
import { WorkoutexerciseModule } from './workoutexercise/workoutexercise.module';
import { WorkoutsessionModule } from './workoutsession/workoutsession.module';

@Module({
  imports: [
    ConfigModule.forRoot({
      isGlobal: true,
      cache: true,
      load: [AppConfig, DatabaseConfig],
    }),
    TypeOrmModule.forRootAsync({
      imports: [ConfigModule],
      useFactory: (configService: ConfigService) => ({
        ...configService.get('database'),
      }),
      inject: [ConfigService],
    }),
    ExercisesModule,
    WorkoutsModule,
    WorkoutexerciseModule,
    LoggedSetModule,
    WorkoutsessionModule
  ]
})
export class AppModule {}
