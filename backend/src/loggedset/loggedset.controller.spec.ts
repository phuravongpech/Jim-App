import { Test, TestingModule } from '@nestjs/testing';
import { LoggedSetController } from './loggedset.controller';

describe('LoggedSetController', () => {
  let controller: LoggedSetController;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      controllers: [LoggedSetController],
    }).compile();

    controller = module.get<LoggedSetController>(LoggedSetController);
  });

  it('should be defined', () => {
    expect(controller).toBeDefined();
  });
});
