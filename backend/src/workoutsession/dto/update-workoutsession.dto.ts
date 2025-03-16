import { ApiProperty } from '@nestjs/swagger';
import { IsNumber, IsOptional, IsString } from 'class-validator';

export class UpdateWorkoutSessionDto {
  @ApiProperty({ description: 'Workout  ID' })
  @IsOptional()
  @IsNumber()
  workoutId?: number;

  @ApiProperty({ description: 'Start Work Out Time Session' })
  @IsOptional()
  @IsString()
  startWorkout?: string;

  @ApiProperty({ description: 'End Workout Out Time Session' })
  @IsOptional()
  @IsString()
  endWorkout?: string;

  @ApiProperty({ description: 'Duration of Workout Session' })
  @IsOptional()
  @IsString()
  duration?: string;
}
