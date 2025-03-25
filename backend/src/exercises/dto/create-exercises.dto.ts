import { ApiProperty } from '@nestjs/swagger';
import { IsNotEmpty, IsString } from 'class-validator';

export class CreateExerciseDto {
  @ApiProperty({ description: 'The ID of the exercise' })
  @IsNotEmpty()
  @IsString()
  id: string;

  @ApiProperty({ description: 'URL of the GIF for the exercise' })
  @IsNotEmpty()
  @IsString()
  gifUrl: string;

  @ApiProperty({ description: 'The body part targeted by the exercise' })
  @IsNotEmpty()
  @IsString()
  bodyPart: string;

  @ApiProperty({ description: 'The target muscle group of the exercise' })
  @IsNotEmpty()
  @IsString()
  target: string;

  @ApiProperty({ description: 'The equipment required for the exercise' })
  @IsNotEmpty()
  @IsString()
  equipment: string;

  @ApiProperty({ description: 'The name of the exercise' })
  @IsNotEmpty()
  @IsString()
  name: string;

  @ApiProperty({ description: 'Instructions for performing the exercise' })
  @IsNotEmpty()
  @IsString({ each: true })
  instructions: string[];
}
