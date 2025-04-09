import {
  Entity,
  Column,
  OneToMany,
  PrimaryGeneratedColumn,
  CreateDateColumn,
  UpdateDateColumn,
  DeleteDateColumn,
} from 'typeorm';
import { WorkoutExercise } from './workoutexercise.entity';
import { WorkoutSession } from './workoutsession.entity';

@Entity('workout')
export class Workout {
  @PrimaryGeneratedColumn()
  id: number;

  @Column()
  name: string;

  @Column({ nullable: true })
  description: string;

  @CreateDateColumn()
  createdAt: Date;

  @UpdateDateColumn()
  updatedAt: Date;

  @DeleteDateColumn()
  deletedAt: Date;

  @OneToMany(() => WorkoutExercise, (workoutExercise) => workoutExercise.workout,
    { cascade: true, onDelete: 'CASCADE' }
  )
  workoutExercises: WorkoutExercise[];

  @OneToMany(() => WorkoutSession, (workoutSession) => workoutSession.workout,
    { cascade: true, onDelete: 'CASCADE' }
  )
  workoutSessions: WorkoutSession[];
}
