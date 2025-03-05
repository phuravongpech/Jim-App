import { ApiProperty } from '@nestjs/swagger';
import { Exercise } from '@src/typeorm/entities/exercise.entity';
import { WorkoutExercise } from '@src/typeorm/entities/workoutexercise.entity';
import { Type } from 'class-transformer';
import { ArrayNotEmpty, IsOptional, IsString, Validate, ValidateNested } from 'class-validator';

export class UpdateWorkoutDto {
  @ApiProperty({ description: 'The name of the workout', required: false })
  @IsOptional()
  @IsString()
  name?: string;

  @ApiProperty({ description: 'A description of the workout', required: false })
  @IsOptional()
  @IsString()
  description?: string;

  @ApiProperty({ description: 'The category of the workout', required: false })
  @IsOptional()
  @IsString()
  category?: string;

  @ApiProperty({ description: 'List of exercises in the workout', required: false})
  @IsOptional()
  @ArrayNotEmpty()
  @ValidateNested({ each : true })
  @Type(() => Exercise)
  exercises?: Exercise[];

  @ApiProperty({ description: 'List of details for each exercise', required: false})
  @IsOptional()
  @ArrayNotEmpty()
  @ValidateNested({ each : true})
  @Type(() => WorkoutExercise)
  workoutExercises?: WorkoutExercise[];
}
