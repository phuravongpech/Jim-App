import { IsArray, IsString, ValidateNested } from "class-validator";
import { Type } from "class-transformer";
import { CreateWorkoutExerciseDto } from "@src/workoutexercise/dto/create-workoutexercise.dto";

export class CreateWorkoutDto {

    @IsString()
    name: string;

    @IsString()
    description: string;

    @IsString()
    category: string;

    @IsArray()
    @ValidateNested({ each: true })
    @Type(() => CreateWorkoutExerciseDto)
    exercises: CreateWorkoutExerciseDto[];
}
