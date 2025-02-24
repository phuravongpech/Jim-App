import {
  Body,
  ClassSerializerInterceptor,
  Controller,
  Delete,
  Get,
  HttpException,
  HttpStatus,
  Param,
  Patch,
  Post,
  UseInterceptors,
  ValidationPipe,
} from '@nestjs/common';
import { ExercisesService } from './exercises.service';
import { CreateExerciseDto } from './dto/create-exercises.dto';
import { ApiOperation, ApiResponse, ApiTags } from '@nestjs/swagger';
import { Exercise } from '@src/typeorm/entities/exercise.entity';
import { UpdateExerciseDto } from './dto/update-exercises.dto';

@ApiTags('Exercises')
@UseInterceptors(ClassSerializerInterceptor)
//defince route exercises
@Controller('exercises')
export class ExercisesController {
  constructor(private readonly exerciseService: ExercisesService) { }

  @Get('api')
  async getAllExercise() {
    try {
      //call service to fetch data
      return await this.exerciseService.fetchAllExercisesFromApi();
    } catch (error) {
      throw new HttpException(
        'Failed to fetch exercises',
        HttpStatus.INTERNAL_SERVER_ERROR,
      );
    }
  }

  @Post()
  @ApiOperation({ summary: 'Create a new exercise' })
  @ApiResponse({ status: 201, description: 'Created Exercise', type: Exercise })
  @ApiResponse({
    status: 400,
    description: 'Invalid or missing data',
    type: Exercise,
  })
  @ApiResponse({ status: 409, description: 'Duplicate data', type: Exercise })
  async create(
    @Body(new ValidationPipe()) createExerciseDto: CreateExerciseDto,
  ): Promise<Exercise | null> {
    const createdExercise =
      await this.exerciseService.create(createExerciseDto);
    if (createdExercise === null) {
      return null;
    }
    return createdExercise;
  }

  @Get()
  @ApiOperation({ summary: 'Find all Exercises' })
  @ApiResponse({
    status: 200,
    description: 'List of Exercises',
    type: [Exercise],
  })
  @ApiResponse({
    status: 204,
    description: 'List of Exercises is not found',
    type: [Exercise],
  })
  @ApiResponse({ status: 400, description: 'Invalid query', type: [Exercise] })
  async findAll(): Promise<Exercise[]> {
    return this.exerciseService.findAll();
  }

  @Get(':id')
  @ApiOperation({ summary: 'Find a exercise by ID' })
  @ApiResponse({ status: 200, description: 'Found Exercise', type: Exercise })
  @ApiResponse({
    status: 404,
    description: 'Can not found Exercise with this ID',
    type: Exercise,
  })
  @ApiResponse({ status: 400, description: 'Invalid format' })
  async findOne(@Param('id') id: string): Promise<Exercise> {
    return this.exerciseService.findOne(id);
  }

  @Patch(':id')
  @ApiOperation({ summary: 'Update a exercise' })
  @ApiResponse({ status: 200, description: 'Updated exercise', type: Exercise })
  @ApiResponse({ status: 400, description: 'Invalid request', type: Exercise })
  @ApiResponse({
    status: 404,
    description: 'Exercise does not exist',
    type: Exercise,
  })
  @ApiResponse({ status: 409, description: 'Conflict', type: Exercise })
  async update(
    @Param('id') id: string,
    @Body(new ValidationPipe()) updateexerciseDto: UpdateExerciseDto,
  ): Promise<Exercise> {
    return this.exerciseService.update(id, updateexerciseDto);
  }

  @Delete(':id')
  @ApiOperation({ summary: 'Delete a exercise' })
  @ApiResponse({ status: 200, description: 'Exercise deleted', type: Exercise })
  @ApiResponse({
    status: 204,
    description: 'Exercise deleted, no response body',
    type: Exercise,
  })
  @ApiResponse({
    status: 404,
    description: 'Exercise does not exist',
    type: Exercise,
  })
  @ApiResponse({ status: 204, description: 'exercise deleted', type: Exercise })
  async delete(@Param('id') id: string): Promise<void> {
    return this.exerciseService.delete(id);
  }
}
