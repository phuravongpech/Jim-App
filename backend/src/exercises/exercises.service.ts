import { Injectable, Logger } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import axios from 'axios';

@Injectable()
export class ExercisesService {
    //Create to store Base URL endpoint
    private readonly apiUrl = 'https://exercisedb.p.rapidapi.com/exercises';
    //logger for track error
    private readonly logger = new Logger(ExercisesService.name);

    constructor(
        private readonly configService: ConfigService
    ){}
    //get api header from env
    private getApiOptions (){
        return {
            headers:{
                'X-RapidAPI-KEY': this.configService.get<string>('EXERCISE_DB_API_KEY'),
                'X-RapidAPI-Host': this.configService.get<string>('EXERCISE_DB_API_HOST'),
            },
        };
    };
    // fetch all exercise
    async fetchAllExercisesFromApi(): Promise<any>{
        try{
            const response = await axios.get(this.apiUrl, this.getApiOptions());
            return response.data;
        }
        catch(error){
            this.logger.error('Error fetching exercises :', error);
            throw error;
        }
    }

}
