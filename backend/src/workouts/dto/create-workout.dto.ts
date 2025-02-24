import { ApiProperty } from '@nestjs/swagger';
import { Exercise } from '@src/typeorm/entities/exercise.entity';
import { Type } from 'class-transformer';
import { ArrayNotEmpty, IsNotEmpty, IsOptional, IsString, ValidateNested } from 'class-validator';

export class CreateWorkoutDto {
  @ApiProperty({ description: 'The name of the workout' })
  @IsNotEmpty()
  @IsString()
  name: string;

  @ApiProperty({ description: 'A description of the workout', required: false })
  @IsOptional()
  @IsString()
  description?: string;

  @ApiProperty({ description: 'List of exercises in the workout' })
  @IsNotEmpty()
  @ArrayNotEmpty()
  @ValidateNested({ each: true })
  @Type(() => Exercise)
  exercises: Exercise[];
}
