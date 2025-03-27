import { Test, TestingModule } from '@nestjs/testing';
import { LoggedSetService } from './loggedset.service';

describe('LoggedSetService', () => {
  let service: LoggedSetService;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [LoggedSetService],
    }).compile();

    service = module.get<LoggedSetService>(LoggedSetService);
  });

  it('should be defined', () => {
    expect(service).toBeDefined();
  });
});
