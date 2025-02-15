import { Entity, PrimaryColumn, Column, OneToMany } from 'typeorm';
import { WorkoutExercise } from 'src/typeorm/entities/workoutexercises.entity';

@Entity('exercises')
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
    
    @Column()
    instruction: string;

    @OneToMany(()=> WorkoutExercise, workoutExercise => workoutExercise.exercise)
    workoutExercises: WorkoutExercise[];
}