import { Module } from '@nestjs/common';
import { ActivitylogController } from './activitylog.controller';
import { TypeOrmModule } from '@nestjs/typeorm';
import { ActivitylogService } from './activitylog.service';
import { ActivityLog } from '@src/typeorm/entities/activitylog.entity';

@Module({
    imports: [TypeOrmModule.forFeature([ActivityLog])],
    controllers: [ActivitylogController],
    providers: [ActivitylogService],
})
export class ActivitylogModule {}
