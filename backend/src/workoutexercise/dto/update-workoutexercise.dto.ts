import { IsNumber, IsOptional } from "class-validator";

export class UpdateWorkoutExerciseDto {
    
    @IsOptional()
    @IsNumber()
    restTimeSecond?: number;

    @IsOptional()
    @IsNumber()
    set_count?: number;
}