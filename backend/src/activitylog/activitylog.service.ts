import { ConflictException, Injectable, InternalServerErrorException, Logger, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { ActivityLog } from '@src/typeorm/entities/activitylog.entity';
import { Repository } from 'typeorm';
import { CreateActivityLogDto } from './dto/create-activitylog.dto';
import { UpdateActivityLogDto } from './dto/update-activitylog.dto';
import { WorkoutExercise } from '@src/typeorm/entities/workoutexercise.entity';

@Injectable()
export class ActivitylogService {
  constructor(
    @InjectRepository(ActivityLog)
    private readonly activityLogRepository: Repository<ActivityLog>,
    @InjectRepository(WorkoutExercise)
    private workoutExerciseRepository: Repository<WorkoutExercise>,
  ) { }

  async create(createActivityLogDto: CreateActivityLogDto):Promise<ActivityLog>{
    try{
      const workoutExercise = await this.workoutExerciseRepository.findOne({
        where: { id: createActivityLogDto.workoutExerciseId },
      });

      if (!workoutExercise) {
        throw new NotFoundException(`Activity Log with ID ${createActivityLogDto.workoutExerciseId} not found`);
      }
      const activityLog = this.activityLogRepository.create({
        ...createActivityLogDto,
        workoutExercise: workoutExercise,
      });

      return this.activityLogRepository.save(activityLog);
    }
    catch(e){
      console.error(e);
      if(e.code === 'ER_DUP_ENTRY'){
        throw new ConflictException('Activity Log with this name already exist');
      }
      throw new InternalServerErrorException('Failed to Activity Log');
    }
  }

  async findAll(): Promise<ActivityLog[]>{
    return this.activityLogRepository.find();
  }

  async findOne(id: number): Promise<ActivityLog>{
    const activityLog = await this.activityLogRepository.findOne({ where: { id }});
    if(!activityLog){
      throw new NotFoundException(`Activity Log with ID ${id} Not Found`);
    }
    return activityLog;
  }

  async update(id:number, updateActivityLogDto: UpdateActivityLogDto): Promise<ActivityLog>{
    try{
      const result = await this.activityLogRepository.update(id, updateActivityLogDto);
      if(result.affected === 0){
        throw new NotFoundException(`Activity Log with ID ${id} not found`);
      }
      return this.findOne(id);
    }
    catch(e){
      console.error(e);
      throw new InternalServerErrorException('Failed to update Activity Log');
    }
  }

  async delete(id: number): Promise<void>{
    const result = await this.activityLogRepository.delete(id);
    if(result.affected === 0){
      throw new NotFoundException(`Activity Log with ID ${id} not found`);
    }
  }
}
