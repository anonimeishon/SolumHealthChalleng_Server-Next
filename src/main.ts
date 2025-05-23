import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import { ValidationPipe } from '@nestjs/common';
import { SwaggerModule, DocumentBuilder } from '@nestjs/swagger'; // Import Swagger

async function bootstrap() {
  const app = await NestFactory.create(AppModule);

  app.useGlobalPipes(new ValidationPipe());

  // Swagger Setup
  const config = new DocumentBuilder()
    .setTitle('Solum Health API')
    .setDescription('API documentation for Solum Health services')
    .setVersion('1.0')
    .addTag('users') // Add tags for your controllers, e.g., 'users'
    // .addBearerAuth() // If you use Bearer token authentication
    .build();
  const document = SwaggerModule.createDocument(app, config);
  SwaggerModule.setup('api', app, document); // Serve Swagger UI at /api

  await app.listen(process.env.PORT ?? 8080);
  console.log(`Application is running on: ${await app.getUrl()}`);
}
void bootstrap();
