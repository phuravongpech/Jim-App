import { Injectable, HttpStatus } from '@nestjs/common';

export interface ResponsePayload<T> {
    statusCode: number;
    data: T | null;
    message: string;
    status: "success" | "error";
}

@Injectable()
export class ResponseService {
    success<T>(
        data: T,
        message = 'Operation successful',
        statusCode = HttpStatus.OK,
    ): ResponsePayload<T> {
        return {
            statusCode,
            data,
            message,
            status: 'success',
        };
    }

    error<T = null>(
        message = 'An error occurred',
        statusCode = HttpStatus.BAD_REQUEST,
        data: T | null = null,
    ): ResponsePayload<T> {
        return {
            statusCode,
            data,
            message,
            status: 'error',
        };
    }

    notFound(entity: string): ResponsePayload<null> {
        return this.error(
            `${entity} not found`,
            HttpStatus.NOT_FOUND,
        );
    }

    created<T>(
        data: T,
        message = 'Resource created successfully',
    ): ResponsePayload<T> {
        return this.success(data, message, HttpStatus.CREATED);
    }
}
