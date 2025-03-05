import { Entity, Column, OneToMany, PrimaryGeneratedColumn, CreateDateColumn, UpdateDateColumn} from "typeorm";
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
    
    @UpdateDateColumn()
    updatedAt: Date;

    @OneToMany(() => WorkoutExercise, workoutExercise => workoutExercise.workoutId, { cascade: true })
    workoutExercises: WorkoutExercise[];
}
