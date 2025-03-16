import { ActivityLog } from '@src/typeorm/entities/activitylog.entity';
import { Exercise } from '@src/typeorm/entities/exercise.entity';
import { Workout } from '@src/typeorm/entities/workout.entity';
import { WorkoutExercise } from '@src/typeorm/entities/workoutexercise.entity';
import { WorkoutSession } from '@src/typeorm/entities/workoutsession.entity';
import { MigrationInterface, QueryRunner } from 'typeorm';

export class SeedMultipleWorkouts1740900280771 implements MigrationInterface {
  public async up(queryRunner: QueryRunner): Promise<void> {
    try {
      const workoutRepository = queryRunner.manager.getRepository(Workout);
      const exerciseRepository = queryRunner.manager.getRepository(Exercise);
      const workoutExerciseRepository =
        queryRunner.manager.getRepository(WorkoutExercise);
      const activityLogRepository =
        queryRunner.manager.getRepository(ActivityLog);
      const workoutSessionRepository =
        queryRunner.manager.getRepository(WorkoutSession);

      const allExercisesData = [
        {
          bodyPart: 'waist',
          equipment: 'body weight',
          gifUrl: 'https://v2.exercisedb.io/image/UdCC1yOenRx9NO',
          id: '0001',
          name: '3/4 sit-up',
          target: 'abs',
          instruction: 'Repeat for the desired number of repetitions.',
        },
        {
          bodyPart: 'waist',
          equipment: 'body weight',
          gifUrl: 'https://v2.exercisedb.io/image/QtY7QxpPrLiTEx',
          id: '0002',
          name: '45° side bend',
          target: 'abs',
          instruction:
            'Continue alternating sides for the desired number of repetitions.',
        },
        {
          bodyPart: 'waist',
          equipment: 'body weight',
          gifUrl: 'https://v2.exercisedb.io/image/mgx2a0-dcAEqAt',
          id: '0003',
          name: 'air bike',
          target: 'abs',
          instruction:
            'Continue alternating sides in a pedaling motion for the desired number of repetitions.',
        },
        {
          bodyPart: 'upper legs',
          equipment: 'assisted',
          gifUrl: 'https://v2.exercisedb.io/image/ix4kYFuaq-WE8p',
          id: '0016',
          name: 'assisted prone hamstring',
          target: 'hamstrings',
          instruction: 'Repeat for the desired number of repetitions.',
        },
      ];

      // Save all exercises first
      const createdExercises: Exercise[] = [];
      for (const exerciseData of allExercisesData) {
        const exercise = exerciseRepository.create(exerciseData);
        const savedExercise = await exerciseRepository.save(exercise);
        createdExercises.push(savedExercise);
      }

      const workoutsData = [
        {
          name: 'Abs Crusher',
          description: 'Intense ab workout',
          exerciseIds: ['0001', '0002', '0003'],
          workoutExercises: [
            { id: '0001', restTimeSecond: 30, setCount: 3 },
            { id: '0002', restTimeSecond: 30, setCount: 3 },
            { id: '0003', restTimeSecond: 45, setCount: 3 },
          ],
        },
        {
          name: 'Hamstring Helper',
          description: 'Focus on hamstrings',
          exerciseIds: ['0016'],
          workoutExercises: [{ id: '0016', restTimeSecond: 60, setCount: 4 }],
        },
        {
          name: 'Core Strength',
          description: 'Build core stability',
          exerciseIds: ['0001', '0003'],
          workoutExercises: [
            { id: '0001', restTimeSecond: 45, setCount: 4 },
            { id: '0003', restTimeSecond: 60, setCount: 3 },
          ],
        },
        {
          name: 'Waist Toner',
          description: 'Sculpt your waistline',
          exerciseIds: ['0002', '0003'],
          workoutExercises: [
            { id: '0002', restTimeSecond: 30, setCount: 4 },
            { id: '0003', restTimeSecond: 45, setCount: 4 },
          ],
        },
        {
          name: 'Leg Day Lite',
          description: 'Light leg workout',
          exerciseIds: ['0016'],
          workoutExercises: [{ id: '0016', restTimeSecond: 45, setCount: 3 }],
        },
        {
          name: 'Ab Blast',
          description: 'Quick ab blast',
          exerciseIds: ['0001', '0002'],
          workoutExercises: [
            { id: '0001', restTimeSecond: 30, setCount: 3 },
            { id: '0002', restTimeSecond: 30, setCount: 3 },
          ],
        },
        {
          name: 'Hamstring Focus',
          description: 'Dedicated hamstring workout',
          exerciseIds: ['0016'],
          workoutExercises: [{ id: '0016', restTimeSecond: 60, setCount: 5 }],
        },
        {
          name: 'Core Circuit',
          description: 'Circuit for core strength',
          exerciseIds: ['0001', '0003', '0002'],
          workoutExercises: [
            { id: '0001', restTimeSecond: 30, setCount: 3 },
            { id: '0003', restTimeSecond: 30, setCount: 3 },
            { id: '0002', restTimeSecond: 30, setCount: 3 },
          ],
        },
        {
          name: 'Waist Workout',
          description: 'Target your waist',
          exerciseIds: ['0002', '0003'],
          workoutExercises: [
            { id: '0002', restTimeSecond: 45, setCount: 3 },
            { id: '0003', restTimeSecond: 45, setCount: 3 },
          ],
        },
        {
          name: 'Leg Strength',
          description: 'Strengthen your legs',
          exerciseIds: ['0016'],
          workoutExercises: [{ id: '0016', restTimeSecond: 60, setCount: 4 }],
        },
      ];

      for (const workoutData of workoutsData) {
        const workout = workoutRepository.create({
          name: workoutData.name,
          description: workoutData.description,
        });
        const savedWorkout = await workoutRepository.save(workout);

        const workoutSession = workoutSessionRepository.create({
          workout: savedWorkout,
          startWorkout: new Date().toISOString(),
          endWorkout: new Date(Date.now() + 3600000).toISOString(),
          duration: '1 hour',
        });
        const savedWorkoutSession =
          await workoutSessionRepository.save(workoutSession);

        for (const workoutExerciseData of workoutData.workoutExercises) {
          const exercise = createdExercises.find(
            (ex) => ex.id === workoutExerciseData.id,
          );
          if (exercise) {
            const workoutExercise = workoutExerciseRepository.create({
              workout: savedWorkout.id,
              exercise: exercise,
              restTimeSecond: workoutExerciseData.restTimeSecond,
              setCount: workoutExerciseData.setCount,
            });
            const savedWorkoutExercise =
              await workoutExerciseRepository.save(workoutExercise);

            const activityLogsData = [];
            for (let i = 1; i <= workoutExerciseData.setCount; i++) {
              activityLogsData.push({
                workoutExerciseId: savedWorkoutExercise,
                workoutSessionId: savedWorkoutSession,
                weight: 15,
                rep: 10,
                setNumber: i,
              });
            }

            for (const activityLogData of activityLogsData) {
              const activityLog = activityLogRepository.create(activityLogData);
              await activityLogRepository.save(activityLog);
            }
          } else {
            console.warn(
              `Exercise with id ${workoutExerciseData.id} not found.`,
            );
          }
        }
      }
    } catch (error) {
      console.error('Error during data insertion:', error);
    }
  }

  public async down(queryRunner: QueryRunner): Promise<void> {
    const workoutRepository = queryRunner.manager.getRepository(Workout);
    for (const workout of await workoutRepository.find()) {
      await queryRunner.query(`DELETE FROM "workout" WHERE id = ${workout.id}`);
    }
  }
}
