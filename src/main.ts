import { NestFactory } from '@nestjs/core';
import { AppModule } from './infrastructure/config/app.module';

async function bootstrap() {
  const app = await NestFactory.create(AppModule);
  await app.listen(3334);
}
bootstrap();
