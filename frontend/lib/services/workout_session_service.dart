import 'package:frontend/models/workout_with_exercise.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import '../models/exercise.dart';
import '../models/logged_set.dart';
import '../models/workout.dart';
import '../repository/workout_repository.dart';

class WorkoutSessionService {
  // Singleton pattern
  static final WorkoutSessionService _instance =
      WorkoutSessionService._internal();
  static WorkoutSessionService get instance => _instance;

  late final WorkoutRepository repository;

  final log = Logger();

  // Private constructor
  WorkoutSessionService._internal();

  // Initialize with repository
  void initialize(WorkoutRepository repo) {
    repository = repo;
    log.d(repository);
  }

  // Observable states using GetX
  final activeWorkout = Rxn<Workout>();
  final activeWorkoutExercises = <CustomWorkoutExercise>[].obs;
  final currentExerciseIndex = 0.obs;
  final currentSetIndex = 0.obs;
  final loggedSets = <LoggedSet>[].obs;

  final isWorkoutActive = false.obs;
  final isLoading = false.obs;

  final xExercise = <Exercise>[].obs;

  DateTime? _startTime;
  DateTime? _endTime;

  // Getters
  DateTime? get startTime => _startTime;
  DateTime? get endTime => _endTime;

  // Computed properties
  //this one refers to workoutExercises
  CustomWorkoutExercise? get currentExercise =>
      currentExerciseIndex.value < activeWorkoutExercises.length
          ? activeWorkoutExercises[currentExerciseIndex.value]
          : null;

  //get the current exercise
  Exercise? get exercise => xExercise[currentExerciseIndex.value];

  bool get hasMoreSets =>
      currentExercise != null &&
      currentSetIndex.value < currentExercise!.setCount - 1;

  bool get hasMoreExercises =>
      currentExerciseIndex.value < activeWorkoutExercises.length - 1;

  // Data operations
  Future<List<Workout>> fetchWorkouts() async {
    try {
      isLoading.value = true;
      return await repository.getWorkoutWithExercises();
    } catch (e) {
      log.d('Error fetching workouts: $e'); // Debug log
      return [];
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> loadWorkout(String workoutId) async {
    try {
      isLoading.value = true;

      final workoutDetails =
          await repository.getWorkoutWithExercisesFor(workoutId);

      xExercise.assignAll(workoutDetails.workoutExercises
          .map((workoutExercise) => workoutExercise.exercise)
          .cast<Exercise>()
          .toList());

      final workoutExercises = workoutDetails.workoutExercises
          .map((we) => CustomWorkoutExercise(
                id: we.id,
                workoutId: workoutDetails.id,
                exercise: we.exercise,
                exerciseId: we.exerciseId,
                restTimeSecond: we.restTimeSecond,
                setCount: we.setCount,
              ))
          .toList();

      final workout = Workout(
          id: workoutDetails.id.toString(),
          name: workoutDetails.name,
          description: workoutDetails.description,
          exerciseCount: workoutExercises.length);

      if (workoutExercises.isEmpty) {
        throw Exception('No exercises found');
      }

      startWorkoutSession(workout, workoutExercises);
      return true;
    } catch (e) {
      log.d('Error loading workout: $e'); // Debug log
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  // Session management
  void startWorkoutSession(
      Workout workout, List<CustomWorkoutExercise> exercises) {
    activeWorkout.value = workout;
    activeWorkoutExercises.assignAll(exercises);
    currentExerciseIndex.value = 0;
    currentSetIndex.value = 0;
    loggedSets.clear();
    isWorkoutActive.value = true;
    _startTime = DateTime.now();
  }

  void endWorkoutSession() {
    _endTime = DateTime.now();
    currentExerciseIndex.value = 0;
    currentSetIndex.value = 0;
    isWorkoutActive.value = false;
    log.d('Workout session ended');
    log.d('Workout session ended with logged sets: $loggedSets');
    log.d('Workout session ended with active workout: $activeWorkout');
  }

  void clearSessionData({bool save = true}) {
    if (save && loggedSets.isNotEmpty) {
      log.d('Saving logged sets: $loggedSets');
      repository.saveLoggedSets(
        workoutId: activeWorkout.value?.id ?? '',
        startWorkout: _startTime ?? DateTime.now(),
        endWorkout: _endTime ?? DateTime.now(),
        loggedSets: loggedSets,
      );
    }

    activeWorkout.value = null;
    activeWorkoutExercises.clear();
    loggedSets.clear();
    xExercise.clear();
    _startTime = null;
    _endTime = null;

    log.d('Session data cleared');
  }

  // Set logging and navigation
  void logSet(int reps, double weight) {
    if (currentExercise == null) return;

    final loggedSet = LoggedSet(
      workoutExerciseId: currentExercise!.id,
      setNumber: currentSetIndex.value + 1,
      rep: reps,
      weight: weight,
    );

    log.d(' now just logged set = $loggedSet');
    log.d('current exercise = $currentExercise');
    log.d('current exercise id = ${currentExercise!.id}');

    loggedSets.add(loggedSet);
  }

  void moveToNextSet() {
    if (!hasMoreSets) return;
    currentSetIndex.value++;

    log.d('move to new set ${currentSetIndex.value}');
  }

  void moveToNextExercise() {
    if (!hasMoreExercises) return;
    currentExerciseIndex.value++;
    log.d('now move to next workoutExercise =$currentExercise');
    currentSetIndex.value = 0;
  }
}
