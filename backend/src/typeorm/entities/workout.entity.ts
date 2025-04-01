import {
  Entity,
  Column,
  OneToMany,
  PrimaryGeneratedColumn,
  CreateDateColumn,
  UpdateDateColumn,
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

  @OneToMany(
    () => WorkoutExercise,
    (workoutExercise) => workoutExercise.workout,
    { cascade: true },
  )
  workoutExercises: WorkoutExercise[];

  @OneToMany(() => WorkoutSession, (workoutSession) => workoutSession.workout)
  workoutSessions: WorkoutSession[];
}
