import {
  Body,
  Controller,
  Delete,
  Get,
  Param,
  Patch,
  Post,
  ValidationPipe,
} from '@nestjs/common';
import { ApiOperation, ApiResponse, ApiTags } from '@nestjs/swagger';
import { WorkoutExerciseService } from './workoutexercise.service';
import { CreateWorkoutExerciseDto } from './dto/create-workoutexercise.dto';
import { WorkoutExercise } from '@src/typeorm/entities/workoutexercise.entity';
import { UpdateWorkoutExerciseDto } from './dto/update-workoutexercise.dto';

@ApiTags('Workoutexercise')
@Controller('workoutexercise')
export class WorkoutexerciseController {
  constructor(
    private readonly workoutExerciseService: WorkoutExerciseService,
  ) {}

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

  @Get()
  @ApiOperation({ summary: 'Find all work outs exercise' })
  @ApiResponse({
    status: 200,
    description: 'List of work outs exercise',
    type: [WorkoutExercise],
  })
  @ApiResponse({
    status: 204,
    description: 'List of workout exercise is not found',
    type: [WorkoutExercise],
  })
  @ApiResponse({
    status: 400,
    description: 'Invalid query',
    type: [WorkoutExercise],
  })
  @ApiResponse({
    status: 200,
    description: 'List of work outs exercise',
    type: [WorkoutExercise],
  })
  async findAll(): Promise<WorkoutExercise[]> {
    return this.workoutExerciseService.findAll();
  }

  @Get(':id')
  @ApiOperation({ summary: 'Find a workout exercise by ID' })
  @ApiResponse({
    status: 200,
    description: 'Found Wokrout Exercise',
    type: WorkoutExercise,
  })
  @ApiResponse({
    status: 400,
    description: 'Invalid request',
    type: WorkoutExercise,
  })
  @ApiResponse({
    status: 404,
    description: 'Workout Exercise does not exist',
    type: WorkoutExercise,
  })
  @ApiResponse({ status: 409, description: 'Conflict', type: WorkoutExercise })
  async findOne(@Param('id') id: number): Promise<WorkoutExercise> {
    return this.workoutExerciseService.findOne(id);
  }

  @Patch(':id')
  @ApiOperation({ summary: 'Update a workout exercise' })
  @ApiResponse({
    status: 200,
    description: 'Updated workout exercise',
    type: WorkoutExercise,
  })
  @ApiResponse({
    status: 400,
    description: 'Invalid request',
    type: WorkoutExercise,
  })
  @ApiResponse({
    status: 404,
    description: 'Workout Exercise does not exist',
    type: WorkoutExercise,
  })
  @ApiResponse({ status: 409, description: 'Conflict', type: WorkoutExercise })
  async update(
    @Param('id') id: number,
    @Body(new ValidationPipe()) updateWorkoutDto: UpdateWorkoutExerciseDto,
  ): Promise<WorkoutExercise> {
    return this.workoutExerciseService.update(id, updateWorkoutDto);
  }

  @Delete(':id')
  @ApiOperation({ summary: 'Delete a workout exercise' })
  @ApiResponse({ status: 204, description: 'Workout Exercise deleted' })
  @ApiResponse({
    status: 200,
    description: 'Workout Exercise deleted',
    type: WorkoutExercise,
  })
  @ApiResponse({
    status: 204,
    description: 'Workout Exercise deleted, no response body',
    type: WorkoutExercise,
  })
  @ApiResponse({
    status: 404,
    description: 'Workout Exercise does not exist',
    type: WorkoutExercise,
  })
  async delete(@Param('id') id: number): Promise<void> {
    return this.workoutExerciseService.delete(id);
  }
}
