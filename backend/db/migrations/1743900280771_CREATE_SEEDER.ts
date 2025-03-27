 import { Exercise } from '@src/typeorm/entities/exercise.entity';
import { LoggedSet } from '@src/typeorm/entities/loggedset.entity';
 import { Workout } from '@src/typeorm/entities/workout.entity';
 import { WorkoutExercise } from '@src/typeorm/entities/workoutexercise.entity';
import { WorkoutSession } from '@src/typeorm/entities/workoutsession.entity';
 import { MigrationInterface, QueryRunner } from 'typeorm';
 
 export class SeedDatabase1743900280771 implements MigrationInterface {
   name = 'SeedDatabase1743900280771';
 
   public async up(queryRunner: QueryRunner): Promise<void> {
     try {
       const workoutRepository = queryRunner.manager.getRepository(Workout);
       const exerciseRepository = queryRunner.manager.getRepository(Exercise);
       const workoutExerciseRepository =
         queryRunner.manager.getRepository(WorkoutExercise);
       const loggedSetRepository =
         queryRunner.manager.getRepository(LoggedSet);
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
           instructions: [
             'Lie flat on your back with your knees bent and feet flat on the ground.',
             'Place your hands behind your head with your elbows pointing outwards.',
             'Engaging your abs, slowly lift your upper body off the ground, curling forward until your torso is at a 45-degree angle.',
             'Pause for a moment at the top, then slowly lower your upper body back down to the starting position.',
             'Repeat for the desired number of repetitions.',
           ],
         },
         {
           bodyPart: 'waist',
           equipment: 'body weight',
           gifUrl: 'https://v2.exercisedb.io/image/QtY7QxpPrLiTEx',
           id: '0002',
           name: '45° side bend',
           target: 'abs',
           instructions: [
             'Stand with your feet shoulder-width apart and your arms extended straight down by your sides.',
             'Keeping your back straight and your core engaged, slowly bend your torso to one side, lowering your hand towards your knee.',
             'Pause for a moment at the bottom, then slowly return to the starting position.',
             'Repeat on the other side.',
             'Continue alternating sides for the desired number of repetitions.',
           ],
         },
         {
           bodyPart: 'waist',
           equipment: 'body weight',
           gifUrl: 'https://v2.exercisedb.io/image/mgx2a0-dcAEqAt',
           id: '0003',
           name: 'air bike',
           target: 'abs',
           instructions: [
             'Lie flat on your back with your hands placed behind your head.',
             'Lift your legs off the ground and bend your knees at a 90-degree angle.',
             'Bring your right elbow towards your left knee while simultaneously straightening your right leg.',
             'Return to the starting position and repeat the movement on the opposite side, bringing your left elbow towards your right knee while straightening your left leg.',
             'Continue alternating sides in a pedaling motion for the desired number of repetitions.',
           ],
         },
         {
           bodyPart: 'upper legs',
           equipment: 'assisted',
           gifUrl: 'https://v2.exercisedb.io/image/ix4kYFuaq-WE8p',
           id: '0016',
           name: 'assisted prone hamstring',
           target: 'hamstrings',
           instructions: [
             'Lie flat on your back with your knees bent and feet flat on the ground.',
             'Extend your arms straight out to the sides, parallel to the ground.',
             'Engaging your abs, lift your shoulders off the ground and reach your right hand towards your right heel.',
             'Return to the starting position and repeat on the left side, reaching your left hand towards your left heel.',
             'Continue alternating sides for the desired number of repetitions.',
           ],
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
                 workoutId: savedWorkout.id,
               exerciseId: exercise.id,
               restTimeSecond: workoutExerciseData.restTimeSecond,
               setCount: workoutExerciseData.setCount,
             });
             const savedWorkoutExercise =
               await workoutExerciseRepository.save(workoutExercise);
 
             const loggedSetsData = [];
             for (let i = 1; i <= workoutExerciseData.setCount; i++) {
               loggedSetsData.push({
                 workoutExerciseId: savedWorkoutExercise,
                 workoutSession: savedWorkoutSession,
                 weight: 15,
                 rep: 10,
                 setNumber: i,
               });
             }
 
             for (const loggedSetData of loggedSetsData) {
               const loggedSet = loggedSetRepository.create(loggedSetData);
               await loggedSetRepository.save(loggedSet);
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