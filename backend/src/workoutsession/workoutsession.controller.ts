import {
    Controller,
    Get,
    Post,
    Body,
    Param,
    Delete,
    Patch,
    UseInterceptors,
    ClassSerializerInterceptor,
    ValidationPipe,
  } from '@nestjs/common';
import { ApiOperation, ApiResponse, ApiTags } from '@nestjs/swagger';
import { WorkoutSessionService } from './workoutsession.service';
import { WorkoutSession } from '@src/typeorm/entities/workoutsession.entity';
import { CreateWorkoutSessionDto } from './dto/create-workoutsession.dto';
import { UpdateWorkoutSessionDto } from './dto/update-workoutsession.dto';
  
  @ApiTags('Workout Sessions')
  @Controller('workout-sessions')
  @UseInterceptors(ClassSerializerInterceptor)
  export class WorkoutSessionController {
    constructor(private readonly workoutSessionService: WorkoutSessionService) {}
  
    @Post()
    @ApiOperation({ summary: 'Create a new workout session' })
    @ApiResponse({ status: 201, description: 'Created Workout Session', type: WorkoutSession })
    @ApiResponse({ status: 400, description: 'Invalid or missing data', type: WorkoutSession })
    @ApiResponse({ status: 409, description: 'Duplicate data', type: WorkoutSession })
    async create(@Body(new ValidationPipe()) createWorkoutSessionDto: CreateWorkoutSessionDto): Promise<WorkoutSession> {
      return this.workoutSessionService.create(createWorkoutSessionDto);
    }
  
    @Get()
    @ApiOperation({ summary: 'Find all workout sessions' })
    @ApiResponse({ status: 200, description: 'List of workout sessions', type: [WorkoutSession] })
    @ApiResponse({ status: 204, description: 'List of workout sessions is not found', type: [WorkoutSession] })
    @ApiResponse({ status: 400, description: 'Invalid query', type: [WorkoutSession] })
    async findAll(): Promise<WorkoutSession[]> {
      return this.workoutSessionService.findAll();
    }
  
    @Get(':id')
    @ApiOperation({ summary: 'Find a workout session by ID' })
    @ApiResponse({ status: 200, description: 'Found Workout Session', type: WorkoutSession })
    @ApiResponse({ status: 404, description: 'Cannot find workout session with this ID', type: WorkoutSession })
    @ApiResponse({ status: 400, description: 'Invalid format', type: WorkoutSession })
    async findOne(@Param('id') id: number): Promise<WorkoutSession> {
      return this.workoutSessionService.findOne(id);
    }
  
    @Patch(':id')
    @ApiOperation({ summary: 'Update a workout session' })
    @ApiResponse({ status: 200, description: 'Updated workout session successfully', type: WorkoutSession })
    @ApiResponse({ status: 400, description: 'Invalid request', type: WorkoutSession })
    @ApiResponse({ status: 404, description: 'Workout session does not exist', type: WorkoutSession })
    @ApiResponse({ status: 409, description: 'Conflict', type: WorkoutSession })
    async update(@Param('id') id: number, @Body(new ValidationPipe()) updateWorkoutSessionDto: UpdateWorkoutSessionDto): Promise<WorkoutSession> {
      return this.workoutSessionService.update(id, updateWorkoutSessionDto);
    }
  
    @Delete(':id')
    @ApiOperation({ summary: 'Delete a workout session' })
    @ApiResponse({ status: 200, description: 'Workout session deleted', type: WorkoutSession })
    @ApiResponse({ status: 204, description: 'Workout session deleted, no response body', type: WorkoutSession })
    @ApiResponse({ status: 404, description: 'Workout session does not exist', type: WorkoutSession })
    async delete(@Param('id') id: number): Promise<void> {
      return this.workoutSessionService.delete(id);
    }
  
    @Get(':id/exercises')
    @ApiOperation({ summary: 'Get exercises and activity logs for a workout session' })
    @ApiResponse({ status: 200, description: 'Exercises and activity logs for the workout session', type: Object })
    @ApiResponse({ status: 404, description: 'Workout session does not exist', type: Object })
    async getSessionExercisesWithActivityLogs(@Param('id') id: number) {
      return this.workoutSessionService.findWorkoutSessionWithActivities(id);
    }
  }