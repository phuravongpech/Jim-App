import {
  Entity,
  PrimaryGeneratedColumn,
  Column,
  ManyToOne,
  JoinColumn,
  CreateDateColumn,
  UpdateDateColumn,
  OneToMany,
} from 'typeorm';
import { Workout } from './workout.entity';
import { ActivityLog } from './activitylog.entity';

@Entity('workout_session')
export class WorkoutSession {
  @PrimaryGeneratedColumn()
  id: number;

  @Column()
  startWorkout: string;

  @Column()
  endWorkout: string;

  @Column()
  duration: string;

  @CreateDateColumn()
  createdAt: Date;

  @UpdateDateColumn()
  updatedAt: Date;

  @ManyToOne(() => Workout, (workout) => workout.workoutSessions, {
    onDelete: 'CASCADE',
  })
  @JoinColumn({ name: 'workoutId' })
  workout: Workout;

  @OneToMany(() => ActivityLog, (activityLog) => activityLog.workoutSession, {
    cascade: true,
  })
  activityLogs: ActivityLog[];
}
