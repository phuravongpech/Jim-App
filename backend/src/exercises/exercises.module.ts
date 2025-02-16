import { Module } from '@nestjs/common';
import { ConfigModule } from '@nestjs/config';
import { ExercisesController } from './exercises.controller';
import { ExercisesService } from './exercises.service';

@Module({
    imports: [
      //load env variable form .env
        ConfigModule.forRoot(),
      ],
      controllers: [ExercisesController],
      providers: [ExercisesService],
})
export class ExercisesModule {}
