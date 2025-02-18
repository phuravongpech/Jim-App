import { Injectable, Logger } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { ResponsePayload, ResponseService } from '@src/common/services/response.service';
import { ActivityLog } from '@src/typeorm/entities/activitylog.entity';
import { Repository } from 'typeorm';
import { CreateActivityLogDto } from './dto/create-activitylog.dto';
import { UpdateActivityLogDto } from './dto/update-activitylog.dto';

@Injectable()
export class ActivitylogService {
    private readonly logger = new Logger(ActivitylogService.name);

    constructor(
        @InjectRepository(ActivityLog)
        private readonly activityLogRepository: Repository<ActivityLog>,
        private readonly responseService: ResponseService
    ) {}

    async create(createActivityLogDto: CreateActivityLogDto): Promise<ResponsePayload<ActivityLog>> {
        try {
            const activityLog = this.activityLogRepository.create(createActivityLogDto);
            const savedActivityLog = await this.activityLogRepository.save(activityLog);
            return this.responseService.created(savedActivityLog, 'Activity log created successfully');
        } catch (error) {
            this.logger.error('Error creating activity log', error);
            return this.responseService.error('Failed to create activity log', error.status || 500);
        }
    }

    async findAll(): Promise<ResponsePayload<ActivityLog[]>> { 
        try {
            const activityLogs = await this.activityLogRepository.find();
            return this.responseService.success(activityLogs, 'All activity logs fetched successfully');
          } catch (error) {
            this.logger.error('Error fetching activity logs', error);
            return this.responseService.error('Failed to fetch activity logs', error.status || 500);
          }
    }
    async findOne(id: number): Promise<ResponsePayload<ActivityLog | null>> {
        try {
            const activityLog = await this.activityLogRepository.findOne({ where: { id } });
      
            if (!activityLog) {
              return this.responseService.notFound('activity');
            }
      
            return this.responseService.success(activityLog, 'activity fetched successfully');
      
          } catch (error) {
            return this.responseService.error('Failed request activity', error.status || 500);
          }
    }
    async update(id: number, updateActivityLogDto: UpdateActivityLogDto): Promise<ResponsePayload<ActivityLog | null>> {
        try {
            const activityLog = await this.activityLogRepository.findOne({ where: { id } });

            if (!activityLog) {
                return this.responseService.notFound('Activity log');
            }

            Object.assign(activityLog, updateActivityLogDto);
            const updatedActivityLog = await this.activityLogRepository.save(activityLog);

            return this.responseService.success(updatedActivityLog, 'Activity log updated successfully');
        } catch (error) {
            this.logger.error('Error updating activity log', error);
            return this.responseService.error('Failed to update activity log', error.status || 500);
        }
    }
    async remove(id: number): Promise<ResponsePayload<ActivityLog | null>> {
        try {
            const activityLog = await this.activityLogRepository.findOne({ where: { id } });
      
            if (!activityLog) {
              return this.responseService.notFound('Activity log');
            }
      
            await this.activityLogRepository.remove(activityLog);
            return this.responseService.success(null, 'Activity log deleted successfully');
          } catch (error) {
            this.logger.error('Error deleting activity log', error);
            return this.responseService.error('Failed to delete activity log', error.status || 500);
          }
        }
}
