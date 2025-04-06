import {
  Entity,
  Column,
  ManyToOne,
  OneToMany,
  JoinColumn,
  PrimaryGeneratedColumn,
} from 'typeorm';
import { Exercise } from './exercise.entity';
import { LoggedSet } from './loggedset.entity';
import { Workout } from './workout.entity';

@Entity('workout_exercise')
export class WorkoutExercise {
  @PrimaryGeneratedColumn()
  id: number;

  @Column({ type: 'int' })
  workoutId: number;

  @Column({ type: 'string' })
  exerciseId: string;

  @Column({ type: 'int' })
  restTimeSecond: number;

  @Column({ type: 'int' })
  setCount: number;
  @ManyToOne(() => Workout, (workout) => workout.workoutExercises, {
    onDelete: 'CASCADE',
  })
  @JoinColumn({ name: 'workoutId' })
  workout: Workout;

  @ManyToOne(() => Exercise, (exercise) => exercise.workoutExercises, {
    onDelete: 'CASCADE',
  })
  @JoinColumn({ name: 'exerciseId' })
  exercise: Exercise;

  @OneToMany(() => LoggedSet, (loggedSet) => loggedSet.workoutExerciseId)
  loggedSet: LoggedSet[];
}
