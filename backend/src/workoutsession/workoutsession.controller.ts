import { Controller, Get, Post, Body, Param, Put, Delete } from '@nestjs/common';
import { ApiTags, ApiOperation, ApiParam, ApiBody, ApiResponse } from '@nestjs/swagger';
import { WorkoutSessionService } from './workoutsession.service';
import { WorkoutSession } from '@src/typeorm/entities/workoutsession.entity';

@ApiTags('workout-sessions')
@Controller('workout-sessions')
export class WorkoutSessionController {
  constructor(private readonly workoutSessionService: WorkoutSessionService) {}

  @Post()
  @ApiOperation({ summary: 'Create a new workout session' })
  @ApiBody({ type: WorkoutSession })
  @ApiResponse({ status: 201, description: 'Workout session created successfully' })
  async create(@Body() workoutSession: Partial<WorkoutSession>) {
    return this.workoutSessionService.create(workoutSession);
  }

  @Get(':sessionId')
  @ApiOperation({ summary: 'Get details of a workout session' })
  @ApiParam({ name: 'sessionId', type: 'number', description: 'Workout session ID' })
  @ApiResponse({ status: 200, description: 'Workout session details' })
  async findOne(@Param('sessionId') sessionId: number) {
    return this.workoutSessionService.findOne(sessionId);
  }

  @Get()
  @ApiOperation({ summary: 'Get all workout sessions' })
  @ApiResponse({ status: 200, description: 'List of workout sessions' })
  async findAll() {
    return this.workoutSessionService.findAll();
  }

  @Put(':sessionId')
  @ApiOperation({ summary: 'Update a workout session' })
  @ApiParam({ name: 'sessionId', type: 'number', description: 'Workout session ID' })
  @ApiBody({ type: WorkoutSession })
  @ApiResponse({ status: 200, description: 'Workout session updated successfully' })
  async update(@Param('sessionId') sessionId: number, @Body() workoutSession: Partial<WorkoutSession>) {
    return this.workoutSessionService.update(sessionId, workoutSession);
  }

  @Delete(':sessionId')
  @ApiOperation({ summary: 'Delete a workout session' })
  @ApiParam({ name: 'sessionId', type: 'number', description: 'Workout session ID' })
  @ApiResponse({ status: 204, description: 'Workout session deleted successfully' })
  async delete(@Param('sessionId') sessionId: number) {
    await this.workoutSessionService.delete(sessionId);
  }

  @Get(':sessionId/exercises')
  @ApiOperation({ summary: 'Get exercises and activity logs for a workout session' })
  @ApiParam({ name: 'sessionId', type: 'number', description: 'Workout session ID' })
  @ApiResponse({ status: 200, description: 'Exercises and activity logs for the workout session' })
  async getSessionExercisesWithActivityLogs(@Param('sessionId') sessionId: number) {
    return this.workoutSessionService.findWorkoutSessionWithLoggedSet(sessionId);
  }
}