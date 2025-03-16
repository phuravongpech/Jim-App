import {
  Entity,
  Column,
  ManyToOne,
  PrimaryGeneratedColumn,
  JoinColumn,
  CreateDateColumn,
  UpdateDateColumn,
} from 'typeorm';
import { WorkoutExercise } from './workoutexercise.entity';
import { WorkoutSession } from './workoutsession.entity';

@Entity('activity_log')
export class ActivityLog {
  @PrimaryGeneratedColumn()
  id: number;

  @Column({ type: 'int' })
  weight: number;

  @Column({ type: 'int' })
  rep: number;

  @Column({ type: 'int' })
  setNumber: number;

  @CreateDateColumn()
  createdAt: Date;

  @UpdateDateColumn()
  updatedAt: Date;

  @ManyToOne(
    () => WorkoutExercise,
    (workoutExercise) => workoutExercise.activityLogs,
    { onDelete: 'CASCADE' },
  )
  @JoinColumn({ name: 'workoutExerciseId' })
  workoutExercise: WorkoutExercise;

  @ManyToOne(
    () => WorkoutSession,
    (workoutSession) => workoutSession.activityLogs,
    { onDelete: 'CASCADE' },
  )
  @JoinColumn({ name: 'workoutSessionId' })
  workoutSession: WorkoutSession;
}
