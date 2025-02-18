import { IsNumber } from "class-validator";

export class CreateActivityLogDto {
    @IsNumber()
    workout_exercise_id: number; 

    @IsNumber()
    weight: number;

    @IsNumber()
    rep: number;

    @IsNumber()
    setNumber: number;
}