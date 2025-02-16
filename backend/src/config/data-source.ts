import { DataSource } from 'typeorm';
import { join, resolve } from 'path';
import * as dotenv from 'dotenv';
import { Exercise } from '../typeorm/entities/exercise.entity';
import { Workout } from '../typeorm/entities/workout.entity';
import { WorkoutExercise } from '../typeorm/entities/workoutexercise.entity';
import { ActivityLog } from '../typeorm/entities/activitylog.entity';


dotenv.config();

const AppDataSource = new DataSource({
    type: 'mysql',
    host: process.env.DB_HOST || 'localhost',
    port: parseInt(process.env.DB_PORT || '3306', 10),
    username: process.env.DB_USERNAME || 'root',
    password: process.env.DB_PASSWORD || '',
    database: process.env.DB_DATABASE || 'jim',
    entities: [Exercise, Workout, WorkoutExercise, ActivityLog], //join all entities
    migrations: [resolve(__dirname, '../migrations/*{.ts,.js}')], 
    synchronize: false, //when production turn to false
    logging: true,
    migrationsRun:false
  });

export default AppDataSource;