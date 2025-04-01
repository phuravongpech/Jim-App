import { ApiProperty } from "@nestjs/swagger";
import { IsInt, IsNotEmpty, IsNumber } from "class-validator";

export class CreateLoggedSetDto {
  @ApiProperty({ description: 'The ID of the workout exercise' })
  @IsNotEmpty()
  @IsNumber()
  workoutExerciseId: number;

  @ApiProperty({ description: 'The ID of the workout session' })
  @IsNotEmpty()
  @IsNumber()
  workoutSessionId: number;

  @ApiProperty({ description: 'The weight used' })
  @IsNotEmpty()
  @IsInt()
  weight: number;

  @ApiProperty({ description: 'The number of repetitions' })
  @IsNotEmpty()
  @IsInt()
  rep: number;

  @ApiProperty({ description: 'The set number' })
  @IsNotEmpty()
  @IsInt()
  setNumber: number;
}