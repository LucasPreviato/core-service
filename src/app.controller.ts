import { Controller, Get, HttpStatus } from '@nestjs/common';
import { AppService } from './app.service';
import { timeStamp } from 'console';

@Controller()
export class AppController {
  constructor(private readonly appService: AppService) {}

  @Get('/health')
  healthCheck() {
    return {
      service: 'core-service',
      status: HttpStatus.OK || 200,
      timeStamp: new Date().toISOString(),
    };
  }
}
