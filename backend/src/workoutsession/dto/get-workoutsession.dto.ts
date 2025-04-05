/**
 * DTO for representing workout session
 */
export class WorkoutSessionDto {
    constructor(
        public id: number,
        public startWorkout: string,
        public endWorkout: string,
        public workoutName: string,
        public workoutDescription: string,
        public workoutExercises: WorkoutExerciseDto[]
    ) { }
}

/**
 * DTO for workout
 */
export class WorkoutDto {
    constructor(
        public id: number,
        public name: string,
        public descriptions: string,
        public workoutExercises: WorkoutExerciseDto[]
    ) { }
}

/**
 * DTO for workout's exercise
 */
export class WorkoutExerciseDto {
    constructor(
        public exerciseId: string,
        public exerciseName: string,
        public restTimeSecond: number,
        public setCount: number
    ) { }
}

/**
 * DTO for representing a workout session's detail.
 * Detail include workout name, time related data 
 * and exercises that group related logged sets together
 */
export class WorkoutSessionDetailDto {
    constructor(
        public id: number,
        public startWorkout: string,
        public endWorkout: string,
        public workoutName: string,
        public loggedSets: GroupedLoggedSetDto[]
    ) { }
}

/**
 * DTO for group of logged set that have the same exercise (WorkoutExercise).
 */
export class GroupedLoggedSetDto {
    constructor(
        public workoutExerciseId: number,
        public exerciseName: string,
        public sets: LoggedSetDto[]
    ) { }
}

/**
 * DTO for loggedSet
 */
export class LoggedSetDto {
    constructor(
        public setNumber: number,
        public weight: number,
        public rep: number
    ) { }
}
