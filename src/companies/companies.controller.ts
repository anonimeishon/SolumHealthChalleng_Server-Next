import {
  Controller,
  Get,
  Post,
  Body,
  Param,
  Delete,
  Patch,
  ParseIntPipe,
  HttpCode,
  HttpStatus,
} from '@nestjs/common';
import { CompaniesService } from './companies.service';
import {
  CreateCompanyDto,
  UpdateCompanyDto,
  CompanyDto,
} from './dto/company.dto';
import {
  ApiTags,
  ApiOperation,
  ApiResponse,
  ApiParam,
  ApiBody,
} from '@nestjs/swagger';

@ApiTags('companies')
@Controller('companies')
export class CompaniesController {
  constructor(private readonly companiesService: CompaniesService) {}

  @Post()
  @HttpCode(HttpStatus.CREATED)
  @ApiOperation({ summary: 'Create a new company' })
  @ApiBody({ type: CreateCompanyDto })
  @ApiResponse({
    status: HttpStatus.CREATED,
    description: 'The company has been successfully created.',
    type: CompanyDto,
  })
  @ApiResponse({
    status: HttpStatus.BAD_REQUEST,
    description: 'Invalid input data.',
  })
  async create(
    @Body() createCompanyDto: CreateCompanyDto,
  ): Promise<CompanyDto> {
    return this.companiesService.createCompany(createCompanyDto);
  }

  @Get()
  @ApiOperation({ summary: 'Get all companies' })
  @ApiResponse({
    status: HttpStatus.OK,
    description: 'Retrieved all companies successfully.',
    type: [CompanyDto],
  })
  async findAll(): Promise<CompanyDto[]> {
    return this.companiesService.getAllCompanies();
  }

  @Get(':id')
  @ApiOperation({ summary: 'Get a company by ID' })
  @ApiParam({ name: 'id', description: 'The ID of the company', type: Number })
  @ApiResponse({
    status: HttpStatus.OK,
    description: 'Retrieved company successfully.',
    type: CompanyDto,
  })
  @ApiResponse({
    status: HttpStatus.NOT_FOUND,
    description: 'Company not found.',
  })
  async findOne(
    @Param('id', ParseIntPipe) id: number,
  ): Promise<CompanyDto | null> {
    return this.companiesService.getCompanyById(id);
  }

  @Patch(':id')
  @ApiOperation({ summary: 'Update a company by ID' })
  @ApiParam({ name: 'id', description: 'The ID of the company', type: Number })
  @ApiBody({ type: UpdateCompanyDto })
  @ApiResponse({
    status: HttpStatus.OK,
    description: 'The company has been successfully updated.',
    type: CompanyDto,
  })
  @ApiResponse({
    status: HttpStatus.NOT_FOUND,
    description: 'Company not found.',
  })
  @ApiResponse({
    status: HttpStatus.BAD_REQUEST,
    description: 'Invalid input data.',
  })
  async update(
    @Param('id', ParseIntPipe) id: number,
    @Body() updateCompanyDto: UpdateCompanyDto,
  ): Promise<CompanyDto | null> {
    return this.companiesService.updateCompany(id, updateCompanyDto);
  }

  @Delete(':id')
  @HttpCode(HttpStatus.NO_CONTENT)
  @ApiOperation({ summary: 'Delete a company by ID' })
  @ApiParam({ name: 'id', description: 'The ID of the company', type: Number })
  @ApiResponse({
    status: HttpStatus.NO_CONTENT,
    description: 'The company has been successfully deleted.',
  })
  @ApiResponse({
    status: HttpStatus.NOT_FOUND,
    description: 'Company not found.',
  })
  async remove(@Param('id', ParseIntPipe) id: number): Promise<void> {
    await this.companiesService.deleteCompany(id);
  }
}
