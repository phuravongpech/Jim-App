import { ClassSerializerInterceptor, Controller, Get, Param, UseInterceptors } from '@nestjs/common';
import { ExercisesService } from './exercises.service';
import { ApiOperation, ApiResponse, ApiTags } from '@nestjs/swagger';
import { Exercise } from '@src/typeorm/entities/exercise.entity';

@ApiTags('Exercises')
@UseInterceptors(ClassSerializerInterceptor)
//defince route exercises
@Controller('exercises')
export class ExercisesController {
  constructor(private readonly exerciseService: ExercisesService) { }

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
}
