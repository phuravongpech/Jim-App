import { ApiProperty } from "@nestjs/swagger";
import { Type } from "class-transformer";
import { IsInt, IsNotEmpty, IsNumber, ValidateNested } from "class-validator";

export class CreateWorkoutSessionWithSetsDto {
  @ApiProperty({ description: 'Workout ID' })
  @IsNotEmpty()
  @IsNumber()
  workoutId: number;
  
  @ApiProperty({ description: 'Start time of the workout session' })
  @IsNotEmpty()
  startWorkout: string;

  @ApiProperty({ description: 'End time of the workout session'})
  @IsNotEmpty()
  endWorkout: string;

  @ApiProperty({ description: 'Logged sets for this session' })
  @IsNotEmpty()
  @ValidateNested({ each: true })
  @Type(() => CreateLoggedSetDto)
  loggedSets: CreateLoggedSetDto[];
}

export class CreateLoggedSetDto {
  @ApiProperty({ description: 'The ID of the workout exercise' })
  @IsNotEmpty()
  @IsNumber()
  workoutExerciseId: number;

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
