import { Entity, Column, OneToMany, PrimaryColumn } from 'typeorm';
import { WorkoutExercise } from './workoutexercise.entity';

@Entity('exercise')
export class Exercise {
    @PrimaryColumn()
    id: string;

    @Column()
    gifUrl: string;
    
    @Column()
    bodyPart: string;

    @Column()
    target: string;
    
    @Column()
    equipment: string;
    
    @Column()
    name: string;
    
    @Column('text')
    instruction: string;

    @OneToMany(()=> WorkoutExercise, workoutExercise => workoutExercise.exercise)
    workoutExercises: WorkoutExercise[];
}