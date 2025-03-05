import { Test, TestingModule } from '@nestjs/testing';
import { WorkoutexerciseController } from './workoutexercise.controller';

describe('WorkoutexerciseController', () => {
  let controller: WorkoutexerciseController;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      controllers: [WorkoutexerciseController],
    }).compile();

    controller = module.get<WorkoutexerciseController>(WorkoutexerciseController);
  });

  it('should be defined', () => {
    expect(controller).toBeDefined();
  });
});
