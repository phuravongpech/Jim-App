import {
  Entity,
  PrimaryGeneratedColumn,
  Column,
  ManyToOne,
  JoinColumn,
  CreateDateColumn,
  OneToMany,
} from 'typeorm';
import { Workout } from './workout.entity';
import { LoggedSet } from './loggedset.entity';

@Entity('workout_session')
export class WorkoutSession {
  @PrimaryGeneratedColumn()
  id: number;

  @Column({ type: 'int', nullable: true })
  workoutId: number

  @Column()
  startWorkout: string;

  @Column()
  endWorkout: string;

  @Column()
  duration: string;

  @CreateDateColumn()
  createdAt: Date;

  @ManyToOne(() => Workout, (workout) => workout.workoutSessions, { onDelete: 'SET NULL' })
  @JoinColumn({ name: 'workoutId' })
  workout: Workout;

  @OneToMany(() => LoggedSet, (loggedSet) => loggedSet.workoutSession)
  loggedSets: LoggedSet[];
}
