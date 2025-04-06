import { Body, Controller, Post, ValidationPipe } from '@nestjs/common';
import { ApiOperation, ApiResponse, ApiTags } from '@nestjs/swagger';
import { WorkoutExerciseService } from './workoutexercise.service';
import { CreateWorkoutExerciseDto } from './dto/create-workoutexercise.dto';
import { WorkoutExercise } from '@src/typeorm/entities/workoutexercise.entity';

@ApiTags('Workoutexercise')
@Controller('workoutexercise')
export class WorkoutexerciseController {
  constructor(
    private readonly workoutExerciseService: WorkoutExerciseService,
  ) { }

  @Post()
  @ApiOperation({ summary: 'Create a new workout exercise' })
  @ApiResponse({
    status: 201,
    description: 'Created Workout Exercise',
    type: WorkoutExercise,
  })
  @ApiResponse({
    status: 400,
    description: 'Invalid or missing data',
    type: WorkoutExercise,
  })
  @ApiResponse({
    status: 409,
    description: 'Duplicate data',
    type: WorkoutExercise,
  })
  async create(
    @Body(new ValidationPipe())
    createWorkoutExerciseDto: CreateWorkoutExerciseDto,
  ): Promise<WorkoutExercise> {
    return this.workoutExerciseService.create(createWorkoutExerciseDto);
  }
}
