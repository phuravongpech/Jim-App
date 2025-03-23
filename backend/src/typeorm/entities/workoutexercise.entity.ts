import { Entity, Column, ManyToOne, OneToMany, JoinColumn, PrimaryGeneratedColumn } from 'typeorm';
import { Exercise } from './exercise.entity';
import { ActivityLog } from './activitylog.entity';
import { Workout } from './workout.entity';

@Entity('workout_exercise')
export class WorkoutExercise {
    @PrimaryGeneratedColumn()
    id: number;

    @ManyToOne(() => Workout, (workout) => workout.workoutExercises, { onDelete: 'CASCADE' })
    @JoinColumn({ name: "workoutId" })
    workout: Workout;

    @Column({ type: 'int' })
    workoutId: number;

    @ManyToOne(() => Exercise, (exercise) => exercise.workoutExercises, { onDelete: 'CASCADE' })
    @JoinColumn({ name: "exerciseId" })
    exercise: Exercise;

    @Column({ type: 'int' })
    exerciseId: string;

    @Column({ type: 'int' })
    restTimeSecond: number;

    @Column({ type: 'int' })
    setCount: number;

    @OneToMany(() => ActivityLog, (activityLog) => activityLog.workoutExerciseId)
    activityLogs: ActivityLog[];
}
