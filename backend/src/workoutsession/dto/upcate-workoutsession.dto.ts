import { IsDate, IsNumber, IsOptional } from 'class-validator';
import { ApiProperty } from '@nestjs/swagger';

export class UpdateWorkoutSessionDto {
  @ApiProperty({
    description: 'Start time of the workout session',
    required: false,
  })
  @IsOptional()
  startWorkout?: string;

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
  duration?: string;
}
