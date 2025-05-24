import { Injectable, NotFoundException } from '@nestjs/common';
import { CompaniesRepository } from './companies.repository';
import {
  CreateCompanyDto,
  UpdateCompanyDto,
  CompanyDto,
} from './dto/company.dto';

@Injectable()
export class CompaniesService {
  constructor(private readonly companiesRepository: CompaniesRepository) {}

  async getAllCompanies(): Promise<CompanyDto[]> {
    const companies = await this.companiesRepository.findAll();
    return companies.map((company) => ({
      id: company.id,
      name: company.name,
      agentCount: company._count.agents,
      callCount: company._count.calls,
    }));
  }

  async getCompanyById(id: number): Promise<CompanyDto | null> {
    const company = await this.companiesRepository.findOne(id);
    if (!company) {
      throw new NotFoundException(`Company with ID ${id} not found`);
    }

    return {
      id: company.id,
      name: company.name,
      agentCount: company._count.agents,
      callCount: company._count.calls,
    };
  }

  async createCompany(createCompanyDto: CreateCompanyDto): Promise<CompanyDto> {
    const company = await this.companiesRepository.create(createCompanyDto);
    return {
      id: company.id,
      name: company.name,
      agentCount: company._count.agents,
      callCount: company._count.calls,
    };
  }

  async updateCompany(
    id: number,
    updateCompanyDto: UpdateCompanyDto,
  ): Promise<CompanyDto | null> {
    try {
      const company = await this.companiesRepository.update(
        id,
        updateCompanyDto,
      );
      return {
        id: company.id,
        name: company.name,
        agentCount: company._count.agents,
        callCount: company._count.calls,
      };
    } catch (error) {
      throw new NotFoundException(`Company with ID ${id} not found`);
    }
  }

  async deleteCompany(id: number): Promise<void> {
    try {
      await this.companiesRepository.remove(id);
    } catch (error) {
      throw new NotFoundException(`Company with ID ${id} not found`);
    }
  }
}
