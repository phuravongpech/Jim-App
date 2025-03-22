import { ApiProperty } from '@nestjs/swagger';
import { IsOptional, IsString } from 'class-validator';

export class UpdateExerciseDto {
  @ApiProperty({
    description: 'URL of the GIF for the exercise',
    required: false,
  })
  @IsOptional()
  @IsString()
  gifUrl?: string;

  @ApiProperty({
    description: 'The body part targeted by the exercise',
    required: false,
  })
  @IsOptional()
  @IsString()
  bodyPart?: string;

  @ApiProperty({
    description: 'The target muscle group of the exercise',
    required: false,
  })
  @IsOptional()
  @IsString()
  target?: string;

  @ApiProperty({
    description: 'The equipment required for the exercise',
    required: false,
  })
  @IsOptional()
  @IsString()
  equipment?: string;

  @ApiProperty({ description: 'The name of the exercise', required: false })
  @IsOptional()
  @IsString()
  name?: string;

  @ApiProperty({
    description: 'Instructions for performing the exercise',
    required: false,
  })
  @IsOptional()
  @IsString({ each: true })
  instruction?: string[];
}
