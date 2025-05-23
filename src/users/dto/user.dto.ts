import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';
import { IsEmail, IsNotEmpty, IsString, IsOptional } from 'class-validator';

export class CreateUserDto {
  @ApiProperty({
    example: 'John Doe',
    description: 'The name of the user',
  })
  @IsNotEmpty()
  @IsString()
  name!: string;

  @ApiProperty({
    example: 'john.doe@example.com',
    description: 'The email of the user',
  })
  @IsNotEmpty()
  @IsEmail()
  email!: string;

  @ApiProperty({
    example: 'Admin',
    description: 'The role of the user',
  })
  @IsNotEmpty()
  @IsString()
  role!: string;
}

export class UpdateUserDto {
  @ApiPropertyOptional({
    example: 'John Doe',
    description: 'The name of the user',
  })
  @IsOptional()
  @IsString()
  name?: string;

  @ApiPropertyOptional({
    example: 'john.doe@example.com',
    description: 'The email of the user',
  })
  @IsOptional()
  @IsEmail()
  email?: string;

  @ApiPropertyOptional({
    example: 'Admin',
    description: 'The role of the user',
  })
  @IsOptional()
  @IsString()
  role?: string;
}

export class UserDto {
  @ApiProperty({ example: 1, description: 'The unique identifier of the user' })
  id!: number;

  @ApiProperty({
    example: 'John Doe',
    description: 'The name of the user',
  })
  name!: string;

  @ApiProperty({
    example: 'john.doe@example.com',
    description: 'The email of the user',
  })
  email!: string;

  @ApiProperty({
    example: 'Admin',
    description: 'The role of the user',
  })
  role!: string;

  // @ApiProperty({ description: 'Timestamp of user creation' })
  // createdAt!: Date;

  // @ApiProperty({ description: 'Timestamp of last user update' })
  // updatedAt!: Date;
}
