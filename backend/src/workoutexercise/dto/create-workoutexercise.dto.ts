import { IsNotEmpty, IsInt } from 'class-validator';

export class CreateWorkoutExerciseDto {
  @IsNotEmpty()
  @IsInt()
  workoutId: number;

  @IsNotEmpty()
  @IsInt()
  exerciseId: number;

  @IsInt()
  sets: number;

  @IsInt()
  reps: number;

  @IsInt()
  restTimeInSeconds: number;
}
