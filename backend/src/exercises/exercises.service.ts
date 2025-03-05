import {
  ConflictException,
  Injectable,
  InternalServerErrorException,
  Logger,
  NotFoundException,
} from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import { InjectRepository } from '@nestjs/typeorm';
import { Exercise } from '@src/typeorm/entities/exercise.entity';
import axios from 'axios';
import { Repository } from 'typeorm';
import { CreateExerciseDto } from './dto/create-exercises.dto';
import { UpdateExerciseDto } from './dto/update-exercises.dto';

@Injectable()
export class ExercisesService {
  //Create to store Base URL endpoint
  private readonly apiUrl = 'https://exercisedb.p.rapidapi.com/exercises';
  //logger for track error
  private readonly logger = new Logger(ExercisesService.name);

  constructor(
    private readonly configService: ConfigService,
    @InjectRepository(Exercise)
    private exerciseRepository: Repository<Exercise>,
  ) {}
  //get api header from env
  private getApiOptions() {
    return {
      headers: {
        'X-RapidAPI-KEY': this.configService.get<string>('EXERCISE_DB_API_KEY'),
        'X-RapidAPI-Host': this.configService.get<string>(
          'EXERCISE_DB_API_HOST',
        ),
      },
    };
  }
  // fetch all exercise
  async fetchAllExercisesFromApi(): Promise<any> {
    try {
      const response = await axios.get(this.apiUrl, this.getApiOptions());
      return response.data;
    } catch (error) {
      this.logger.error('Error fetching exercises :', error);
      throw error;
    }
  }

  async create(createExerciseDto: CreateExerciseDto): Promise<Exercise | null> {
    try {
      //create ingore handle for if it duplicate data just ignore that data
      const result = await this.exerciseRepository
        .createQueryBuilder()
        .insert()
        .values(createExerciseDto)
        .orIgnore()
        .execute();
      if (result.identifiers.length > 0) {
        return this.exerciseRepository.findOne({
          where: { id: createExerciseDto.id },
        });
      } else {
        return null;
      }
    } catch (e) {
      console.error(e);
      if (e.code === 'ER_DUP_ENTRY') {
        throw new ConflictException('Exercise with this name already exist');
      }
      throw new InternalServerErrorException('Failed to Create Exercise');
    }
  }

  async findAll(): Promise<Exercise[]> {
    return this.exerciseRepository.find();
  }

  async findOne(id: string): Promise<Exercise> {
    const exercise = await this.exerciseRepository.findOne({ where: { id } });
    if (!exercise) {
      throw new NotFoundException(`Exercise with ID ${id} Not Found`);
    }
    return exercise;
  }

  async update(
    id: string,
    updateExerciseDto: UpdateExerciseDto,
  ): Promise<Exercise> {
    try {
      const result = await this.exerciseRepository.update(
        id,
        updateExerciseDto,
      );
      if (result.affected === 0) {
        throw new NotFoundException(`Exercise with ID ${id} not found`);
      }
      return this.findOne(id);
    } catch (e) {
      console.error(e);
      throw new InternalServerErrorException('Failed to update Exercise');
    }
  }

  async delete(id: string): Promise<void> {
    const result = await this.exerciseRepository.delete(id);
    if (result.affected === 0) {
      throw new NotFoundException(`Exercise with ID ${id} not found`);
    }
  }
}
