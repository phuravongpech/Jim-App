import { ApiProperty } from '@nestjs/swagger';
import { IsNotEmpty, IsOptional, IsString } from 'class-validator';

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
  @IsString({ each: true })
  exercises: string[];
}
