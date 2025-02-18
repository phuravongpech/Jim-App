import { Body, Controller, Delete, Get, Param, Post } from '@nestjs/common';
import { ActivitylogService } from './activitylog.service';
import { CreateActivityLogDto } from './dto/create-activitylog.dto';

@Controller('activitylog')
export class ActivitylogController {
    constructor(private readonly activitylogService: ActivitylogService) {}
    
      @Post()
      create(@Body() createActivityLogDto: CreateActivityLogDto) {
        return this.activitylogService.create(createActivityLogDto);
      }
    
      @Get()
      findAll() {
        return this.activitylogService.findAll();
      }
    
      @Get(':id')
      findOne(@Param('id') id: string) {
        return this.activitylogService.findOne(+id);
      }
    
      @Delete(':id')
      remove(@Param('id') id: string) {
        return this.activitylogService.remove(+id);
      }
}
