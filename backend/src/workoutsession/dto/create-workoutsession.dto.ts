import { IsNotEmpty, IsDate, IsNumber, IsOptional } from 'class-validator';
import { ApiProperty } from '@nestjs/swagger';

export class CreateWorkoutSessionDto {
  @ApiProperty({ description: 'Workout ID' })
  @IsNotEmpty()
  @IsNumber()
  workoutId: number;

  @ApiProperty({ description: 'Start time of the workout session' })
  @IsNotEmpty()
  startWorkout: string;

  @ApiProperty({
    description: 'End time of the workout session',
    required: false,
  })
  @IsOptional()
  endWorkout?: string;

  @ApiProperty({
    description: 'Duration of the workout session in seconds',
    required: false,
  })
  @IsOptional()
  @IsNumber()
  duration?: string;
}
