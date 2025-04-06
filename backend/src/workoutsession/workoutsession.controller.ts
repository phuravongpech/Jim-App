import { Controller, Get, Param } from '@nestjs/common';
import { ApiTags, ApiOperation, ApiParam, ApiBody, ApiResponse } from '@nestjs/swagger';
import { WorkoutSessionService } from './workoutsession.service';

@ApiTags('workout-sessions')
@Controller('workout-sessions')
export class WorkoutSessionController {
  constructor(private readonly workoutSessionService: WorkoutSessionService) {}

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
}
