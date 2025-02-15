import { Entity, Column,PrimaryColumn, OneToMany } from "typeorm";
import { WorkoutExercise } from "src/typeorm/entities/workoutexercises.entity";

@Entity()
export class Workout{
    @PrimaryColumn()
    id: number;

    @Column()
    name: string;
    
    @Column({ nullable: true })
    description: string;
    
    @Column()
    date: Date;
    
    @Column()
    category: string;
    
    @OneToMany(() => WorkoutExercise, workoutExercise => workoutExercise.workout, { cascade: true })
    workoutExercises: WorkoutExercise[];

}