import { Entity, Column, OneToMany, PrimaryGeneratedColumn } from 'typeorm';
import { WorkoutExercise } from './workoutexercise.entity';

@Entity('exercise')
export class Exercise {
    @PrimaryGeneratedColumn()
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