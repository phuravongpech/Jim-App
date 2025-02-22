import { ApiProperty } from '@nestjs/swagger';
import { IsOptional, IsString } from 'class-validator';

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
}
