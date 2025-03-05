import { ApiProperty } from '@nestjs/swagger';
import { IsInt, IsNumber, IsOptional } from 'class-validator';

export class UpdateWorkoutExerciseDto {
  @ApiProperty({ description: 'The rest time in seconds', required: false })
  @IsOptional()
  @IsInt()
  restTimeSecond?: number;

  @ApiProperty({ description: 'The number of sets', required: false })
  @IsOptional()
  @IsInt()
  setCount?: number;
}
