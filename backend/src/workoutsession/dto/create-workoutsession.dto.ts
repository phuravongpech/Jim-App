import { ApiProperty } from '@nestjs/swagger';
import { IsNotEmpty, IsNumber, IsString } from 'class-validator';

export class CreateWorkoutSessionDto {
  @ApiProperty({ description: 'Workout  ID' })
  @IsNotEmpty()
  @IsNumber()
  workoutId: number;

  @ApiProperty({ description: 'Start Work Out Time Session' })
  @IsNotEmpty()
  @IsString()
  startWorkout: string;

  @ApiProperty({ description: 'End Workout Out Time Session' })
  @IsNotEmpty()
  @IsString()
  endWorkout: string;

  @ApiProperty({ description: 'Duration of Workout Session' })
  @IsNotEmpty()
  @IsString()
  duration: string;
}
