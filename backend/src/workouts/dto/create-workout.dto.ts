import { IsString } from "class-validator";

export class CreateWorkoutDto {

    @IsString()
    name: string;

    @IsString()
    description: string;

    @IsString()
    category: string;
}
