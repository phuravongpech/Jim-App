import { ApiProperty } from '@nestjs/swagger';
import { IsInt, IsNotEmpty, IsNumber, IsString } from 'class-validator';

export class CreateWorkoutExerciseDto {
  @ApiProperty({ description: 'The ID of the workout' })
  @IsNotEmpty()
  @IsNumber()
  workoutId: number;

  @ApiProperty({ description: 'The ID of the exercise' })
  @IsNotEmpty()
  @IsString()
  exerciseId: number;

  @ApiProperty({ description: 'The rest time in seconds' })
  @IsNotEmpty()
  @IsInt()
  restTimeSecond: number;

  @ApiProperty({ description: 'The number of sets' })
  @IsNotEmpty()
  @IsInt()
  setCount: number;
}
