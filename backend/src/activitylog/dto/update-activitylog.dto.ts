import { IsNumber, IsOptional } from "class-validator";

export class UpdateActivityLogDto {
    @IsOptional()
    @IsNumber()
    weight?: number;

    @IsOptional()
    @IsNumber()
    rep?: number;

    @IsOptional()
    @IsNumber()
    setNumber?: number;
}