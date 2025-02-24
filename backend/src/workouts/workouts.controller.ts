import { Controller, Get, Post, Body, Param, Delete, Patch, UseInterceptors, ClassSerializerInterceptor, ValidationPipe } from '@nestjs/common';
import { WorkoutsService } from './workouts.service';
import { ApiOperation, ApiResponse, ApiTags } from '@nestjs/swagger';
import { Workout } from '@src/typeorm/entities/workout.entity';
import { CreateWorkoutDto } from './dto/create-workout.dto';
import { UpdateWorkoutDto } from './dto/update-workout.dto';

@ApiTags('Workouts')
@Controller('workouts')
@UseInterceptors(ClassSerializerInterceptor)
export class WorkoutsController {
  constructor(private readonly workoutsService: WorkoutsService) {}

  @Post()
  @ApiOperation({ summary : 'Create a new workout'})
  @ApiResponse({ status: 201, description : 'Created Workout', type:Workout})
  @ApiResponse({ status: 400, description : 'Invalid or missing data', type: Workout})
  @ApiResponse({ status: 409, description : 'Duplicate data', type: Workout})
  async create(@Body(new ValidationPipe()) CreateWorkoutDto: CreateWorkoutDto): Promise<Workout>{
    return this.workoutsService.create(CreateWorkoutDto);
  }

  @Get()
  @ApiOperation({ summary : 'Find all work outs'})
  @ApiResponse({ status : 200, description: 'List of work outs', type:[Workout]})
  @ApiResponse({ status : 204, description: 'List of workout is not found', type:[Workout]})
  @ApiResponse({ status : 400, description: 'Invalid query', type:[Workout]})
  async findAll(): Promise<Workout[]>{
    return this.workoutsService.findAll();
  }

  @Get(':id')
  @ApiOperation({ summary : 'Find a workout by ID'})
  @ApiResponse({ status : 200, description: 'Found Wokrout', type:Workout})
  @ApiResponse({ status : 404, description: 'Can not found workout with this ID',type:Workout})
  @ApiResponse({ status : 400, description: 'Invalid format',type:Workout})
  async findOne(@Param('id') id: number): Promise<Workout>{
    return this.workoutsService.findOne(id);
  }

  @Patch(':id')
  @ApiOperation({ summary : 'Update a workout'})
  @ApiResponse({ status : 200, description : 'Updated workout sucessfully', type:Workout})
  @ApiResponse({ status : 400, description : 'Invalid request', type:Workout})
  @ApiResponse({ status : 404, description : 'Workout does not exist', type:Workout})
  @ApiResponse({ status : 409, description : 'Conflict', type:Workout})
  async update(@Param('id') id: number, @Body(new ValidationPipe()) updateWorkoutDto: UpdateWorkoutDto): Promise<Workout>{
    return this.workoutsService.update(id, updateWorkoutDto);
  }

  @Delete(':id')
  @ApiOperation({ summary: 'Delete a workout' })
  @ApiResponse({status: 200, description: 'Workout deleted',type:Workout})
  @ApiResponse({status: 204, description: 'Workout deleted, no response body',type:Workout})
  @ApiResponse({status: 404, description: 'Workout does not exist',type:Workout})
  async delete(@Param('id') id: number): Promise <void>{
    return this.workoutsService.delete(id);
  }
}
