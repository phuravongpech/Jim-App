import {
  Entity,
  Column,
  ManyToOne,
  PrimaryGeneratedColumn,
  JoinColumn,
} from 'typeorm';
import { WorkoutExercise } from './workoutexercise.entity';
import { WorkoutSession } from './workoutsession.entity';

@Entity('logged_set')
export class LoggedSet {
  @PrimaryGeneratedColumn()
  id: number;

  @Column({ type: 'int' })
  weight: number;

  @Column({ type: 'int' })
  rep: number;

  @Column({ type: 'int' })
  setNumber: number;

  @ManyToOne(() => WorkoutExercise, { onDelete: 'CASCADE' })
  @JoinColumn({ name: 'workoutExerciseId' })
  workoutExercise: WorkoutExercise;

  @Column({ type: 'int', nullable: true })
  workoutExerciseId: number;

  @ManyToOne(() => WorkoutSession, (workoutSession) => workoutSession.loggedSets)
  @JoinColumn({ name: 'workoutSessionId' })
  workoutSession: WorkoutSession;

  @Column({ type: 'int' })
  workoutSessionId: number;
}
