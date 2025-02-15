import { ActivityLog } from "src/typeorm/entities/activitylog.entity";
import { Exercise } from "src/typeorm/entities/exercise.entity";
import { Workout } from "src/typeorm/entities/workout.enity";
import { Column, Entity, JoinColumn, ManyToOne, OneToMany, PrimaryColumn } from "typeorm";

@Entity('workoutexercise')
export class WorkoutExercise{
    @PrimaryColumn()
    id:number;

    @ManyToOne(()=> Workout, (workout) => workout.workoutExercises , { onDelete: 'CASCADE' })
    @JoinColumn({ name: "workoutId" })
    workout: Workout;

    @ManyToOne(()=> Exercise, (exercise) => exercise.workoutExercises , { onDelete: 'CASCADE' })
    @JoinColumn({ name: "exerciseId" })
    exercise: Exercise;

    @Column({ type: 'int' })
    restTimeSecond: number;

    @Column({ type: 'int' })
    setCount: number;

    @OneToMany(() => ActivityLog, (activityLog) => activityLog.workoutExercise)
    activityLogs: ActivityLog[];
}