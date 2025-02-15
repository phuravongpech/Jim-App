import { Entity, Column, ManyToOne, PrimaryColumn } from 'typeorm';
import { WorkoutExercise } from 'src/typeorm/entities/workoutexercises.entity';

@Entity()
export class ActivityLog {
  @PrimaryColumn()
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