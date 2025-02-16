import { Controller, Get, HttpException, HttpStatus, Param } from '@nestjs/common';
import { ExercisesService } from './exercises.service';

//defince route exercises
@Controller('exercises')
export class ExercisesController {
    constructor(private readonly exerciseService: ExercisesService){}

    @Get()
    async getAllExercise(){
        try{
            //call service to fetch data
            return await this.exerciseService.fetchAllExercisesFromApi();
        }
        catch (error) {
            throw new HttpException('Failed to fetch exercises', HttpStatus.INTERNAL_SERVER_ERROR)
        }
    }
}
