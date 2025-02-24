import { Entity, Column, OneToMany, PrimaryGeneratedColumn, CreateDateColumn} from "typeorm";
import { WorkoutExercise } from './workoutexercise.entity';

@Entity('workout')
export class Workout{
    @PrimaryGeneratedColumn()
    id: number;

    @Column()
    name: string;
    
    @Column({ nullable: true })
    description: string;

    @CreateDateColumn()
    createdAt: Date;
    
    @CreateDateColumn()
    updatedAt: Date;

    @OneToMany(() => WorkoutExercise, workoutExercise => workoutExercise.workout, { cascade: true })
    workoutExercises: WorkoutExercise[];
}
