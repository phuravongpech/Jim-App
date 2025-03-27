import { ApiProperty } from "@nestjs/swagger";
import { IsInt, IsOptional } from "class-validator";

export class UpdateLoggedSetDto {
  @ApiProperty({ description: 'The weight used', required: false })
  @IsOptional()
  @IsInt()
  weight?: number;

  @ApiProperty({ description: 'The number of repetitions', required: false })
  @IsOptional()
  @IsInt()
  rep?: number;

  @ApiProperty({ description: 'The set number', required: false })
  @IsOptional()
  @IsInt()
  setNumber?: number;
}