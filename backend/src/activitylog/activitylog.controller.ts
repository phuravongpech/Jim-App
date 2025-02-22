import { Body, Controller, Delete, Get, Param, Patch, Post, ValidationPipe } from '@nestjs/common';
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
    @ApiOperation({ summary : 'Create a new Activity Log'})
    @ApiResponse({ status: 201, description : 'Created Workout', type:ActivityLog})
    async create(@Body(new ValidationPipe()) CreateActivityLogDto: CreateActivityLogDto): Promise<ActivityLog>{
      return this.activitylogService.create(CreateActivityLogDto);
    }
  
    @Get()
    @ApiOperation({ summary : 'Find all Activity Log'})
    @ApiResponse({ status : 200, description: 'List of work outs', type:[ActivityLog]})
    async findAll(): Promise<ActivityLog[]>{
      return this.activitylogService.findAll();
    }
  
    @Get(':id')
    @ApiOperation({ summary : 'Find a Activity Log by ID'})
    @ApiResponse({ status : 200, description: 'Found Activity Log', type:ActivityLog})
    async findOne(@Param('id') id: number): Promise<ActivityLog>{
      return this.activitylogService.findOne(id);
    }
  
    @Patch(':id')
    @ApiOperation({ summary : 'Update a Activity Log'})
    @ApiResponse({ status : 200, description : 'Updated Activity Log', type:ActivityLog})
    async update(@Param('id') id: number, @Body(new ValidationPipe()) updateActivityLogDto: UpdateActivityLogDto): Promise<ActivityLog>{
      return this.activitylogService.update(id, updateActivityLogDto);
    }
  
    @Delete(':id')
    @ApiOperation({ summary: 'Delete a Activity Log' })
    @ApiResponse({status: 204, description: 'Activity Log deleted'})
    async delete(@Param('id') id: number): Promise <void>{
      return this.activitylogService.delete(id);
    }
}
