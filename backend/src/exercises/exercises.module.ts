import { Module } from '@nestjs/common';
import { ConfigModule } from '@nestjs/config';
import { ExercisesController } from './exercises.controller';
import { ExercisesService } from './exercises.service';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Exercise } from '@src/typeorm/entities/exercise.entity';

@Module({
  imports: [
    //load env variable form .env
    ConfigModule.forRoot(),
    TypeOrmModule.forFeature([Exercise]),
  ],
  controllers: [ExercisesController],
  providers: [ExercisesService],
})
export class ExercisesModule {}
