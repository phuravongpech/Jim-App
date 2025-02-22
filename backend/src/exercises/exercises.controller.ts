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
  constructor(private readonly exerciseService: ExercisesService) {}

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
  async findAll(): Promise<Exercise[]> {
    return this.exerciseService.findAll();
  }

  @Get(':id')
  @ApiOperation({ summary: 'Find a exercise by ID' })
  @ApiResponse({ status: 200, description: 'Found Exercise', type: Exercise })
  async findOne(@Param('id') id: string): Promise<Exercise> {
    return this.exerciseService.findOne(id);
  }

  @Patch(':id')
  @ApiOperation({ summary: 'Update a exercise' })
  @ApiResponse({ status: 200, description: 'Updated exercise', type: Exercise })
  async update(
    @Param('id') id: string,
    @Body(new ValidationPipe()) updateexerciseDto: UpdateExerciseDto,
  ): Promise<Exercise> {
    return this.exerciseService.update(id, updateexerciseDto);
  }

  @Delete(':id')
  @ApiOperation({ summary: 'Delete a exercise' })
  @ApiResponse({ status: 204, description: 'exercise deleted' })
  async delete(@Param('id') id: string): Promise<void> {
    return this.exerciseService.delete(id);
  }
}
