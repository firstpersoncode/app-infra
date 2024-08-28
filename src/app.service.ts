import { Injectable } from '@nestjs/common';

@Injectable()
export class AppService {
  getHello(): string {
    return `BUILD_ENV ${process.env.BUILD_ENV}`;
  }
}
