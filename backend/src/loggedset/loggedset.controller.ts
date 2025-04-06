import { Body, Controller, Delete, Get, Param, Patch, Post, ValidationPipe } from '@nestjs/common';
import { LoggedSetService } from './loggedset.service';
import { CreateWorkoutSessionWithSetsDto } from './dto/create-loggedset.dto';
import { ApiOperation, ApiResponse, ApiTags } from '@nestjs/swagger';
import { LoggedSet } from '@src/typeorm/entities/loggedset.entity';

@ApiTags('LoggedSet')
@Controller('LoggedSets')
export class LoggedSetController {
  constructor(private readonly loggedSetService: LoggedSetService) { }
  @Post()
  @ApiOperation({ summary: 'Create one or multiple LoggedSets' })
  @ApiResponse({
    status: 201,
    description: 'Created LoggedSet(s)',
    type: LoggedSet,
    isArray: true,
  })
  @ApiResponse({
    status: 400,
    description: 'Invalid or missing data',
    type: LoggedSet,
    isArray: true,
  })
  @ApiResponse({
    status: 409,
    description: 'Duplicate data',
    type: LoggedSet,
    isArray: true,
  })
  async create(
    @Body(new ValidationPipe({ transform: true, whitelist: true }))
    createWorkoutSessionWithSetsDto: CreateWorkoutSessionWithSetsDto,
  ): Promise<LoggedSet[]> {
    return this.loggedSetService.create(createWorkoutSessionWithSetsDto);
  }

  @Get()
  @ApiOperation({ summary: 'Find all LoggedSet' })
  @ApiResponse({
    status: 200,
    description: 'List of LoggedSet',
    type: [LoggedSet],
  })
  @ApiResponse({
    status: 204,
    description: 'List of LoggedSet is not found',
    type: [LoggedSet],
  })
  @ApiResponse({
    status: 400,
    description: 'Invalid query',
    type: [LoggedSet],
  })
  async findAll(): Promise<LoggedSet[]> {
    return this.loggedSetService.findAll();
  }

  @Get(':id')
  @ApiOperation({ summary: 'Find a LoggedSet by ID' })
  @ApiResponse({
    status: 200,
    description: 'Found LoggedSet',
    type: LoggedSet,
  })
  @ApiResponse({
    status: 404,
    description: 'Can not found LoggedSet with this ID',
    type: LoggedSet,
  })
  @ApiResponse({
    status: 400,
    description: 'Invalid format',
    type: LoggedSet,
  })
  async findOne(@Param('id') id: number): Promise<LoggedSet> {
    return this.loggedSetService.findOne(id);
  }

  @Delete(':id')
  @ApiOperation({ summary: 'Delete a LoggedSet' })
  @ApiResponse({ status: 204, description: 'LoggedSet deleted' })
  @ApiResponse({
    status: 200,
    description: 'LoggedSet deleted',
    type: LoggedSet,
  })
  @ApiResponse({
    status: 204,
    description: 'LoggedSet deleted, no response body',
    type: LoggedSet,
  })
  @ApiResponse({
    status: 404,
    description: 'LoggedSet does not exist',
    type: LoggedSet,
  })
  async delete(@Param('id') id: number): Promise<void> {
    return this.loggedSetService.delete(id);
  }
}
