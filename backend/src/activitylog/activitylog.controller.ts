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
import { ActivitylogService } from './activitylog.service';
import { CreateActivityLogDto } from './dto/create-activitylog.dto';
import { UpdateActivityLogDto } from './dto/update-activitylog.dto';
import { ApiOperation, ApiResponse, ApiTags } from '@nestjs/swagger';
import { ActivityLog } from '@src/typeorm/entities/activitylog.entity';

@ApiTags('Activitylog')
@Controller('activitylogs')
export class ActivitylogController {
  constructor(private readonly activitylogService: ActivitylogService) {}
  @Post()
  @ApiOperation({ summary: 'Create a new Activity Log' })
  @ApiResponse({
    status: 201,
    description: 'Created Activity Log',
    type: ActivityLog,
  })
  @ApiResponse({
    status: 400,
    description: 'Invalid or missing data',
    type: ActivityLog,
  })
  @ApiResponse({
    status: 409,
    description: 'Duplicate data',
    type: ActivityLog,
  })
  async create(
    @Body(new ValidationPipe()) CreateActivityLogDto: CreateActivityLogDto,
  ): Promise<ActivityLog> {
    return this.activitylogService.create(CreateActivityLogDto);
  }

  @Get()
  @ApiOperation({ summary: 'Find all Activity Log' })
  @ApiResponse({
    status: 200,
    description: 'List of Activity Log',
    type: [ActivityLog],
  })
  @ApiResponse({
    status: 204,
    description: 'List of Activity Log is not found',
    type: [ActivityLog],
  })
  @ApiResponse({
    status: 400,
    description: 'Invalid query',
    type: [ActivityLog],
  })
  async findAll(): Promise<ActivityLog[]> {
    return this.activitylogService.findAll();
  }

  @Get(':id')
  @ApiOperation({ summary: 'Find a Activity Log by ID' })
  @ApiResponse({
    status: 200,
    description: 'Found Activity Log',
    type: ActivityLog,
  })
  @ApiResponse({
    status: 404,
    description: 'Can not found Activity Log with this ID',
    type: ActivityLog,
  })
  @ApiResponse({
    status: 400,
    description: 'Invalid format',
    type: ActivityLog,
  })
  async findOne(@Param('id') id: number): Promise<ActivityLog> {
    return this.activitylogService.findOne(id);
  }

  @Patch(':id')
  @ApiOperation({ summary: 'Update a Activity Log' })
  @ApiResponse({
    status: 200,
    description: 'Updated Activity Log',
    type: ActivityLog,
  })
  @ApiResponse({
    status: 400,
    description: 'Invalid request',
    type: ActivityLog,
  })
  @ApiResponse({
    status: 404,
    description: 'Activity Log does not exist',
    type: ActivityLog,
  })
  @ApiResponse({ status: 409, description: 'Conflict', type: ActivityLog })
  async update(
    @Param('id') id: number,
    @Body(new ValidationPipe()) updateActivityLogDto: UpdateActivityLogDto,
  ): Promise<ActivityLog> {
    return this.activitylogService.update(id, updateActivityLogDto);
  }

  @Delete(':id')
  @ApiOperation({ summary: 'Delete a Activity Log' })
  @ApiResponse({ status: 204, description: 'Activity Log deleted' })
  @ApiResponse({
    status: 200,
    description: 'Activity Log deleted',
    type: ActivityLog,
  })
  @ApiResponse({
    status: 204,
    description: 'Activity Log deleted, no response body',
    type: ActivityLog,
  })
  @ApiResponse({
    status: 404,
    description: 'Activity Log does not exist',
    type: ActivityLog,
  })
  async delete(@Param('id') id: number): Promise<void> {
    return this.activitylogService.delete(id);
  }
}
