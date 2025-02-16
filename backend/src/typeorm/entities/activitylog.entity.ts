import { Entity, Column, ManyToOne, PrimaryGeneratedColumn } from 'typeorm';
import { WorkoutExercise } from './workoutexercise.entity';

@Entity('activity_log')
export class ActivityLog {
  @PrimaryGeneratedColumn()
  id: number;

  @ManyToOne(() => WorkoutExercise, { onDelete: 'CASCADE' })
  workoutExercise: WorkoutExercise;

  @Column({ type: 'int' })
  weight: number;

  @Column({ type: 'int' })
  rep: number;

  @Column({ type: 'int' })
  setNumber: number;
}