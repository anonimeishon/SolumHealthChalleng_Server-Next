import { Injectable } from '@nestjs/common';
import { PrismaService } from '../../prisma/prisma.service';
import {
  Company,
  Agent,
  User,
  Call,
  HumanEvaluation,
  LlmEvaluation,
  Prisma,
} from '@prisma/client';

@Injectable()
export class CompanyRepository {
  constructor(private readonly prisma: PrismaService) {}

  async findOrCreate(name: string): Promise<Company> {
    let company = await this.prisma.company.findUnique({
      where: { name },
    });
    if (!company) {
      company = await this.prisma.company.create({
        data: { name },
      });
    }
    return company;
  }
}

@Injectable()
export class AgentRepository {
  constructor(private readonly prisma: PrismaService) {}

  async findOrCreate(
    external_id: string,
    name: string,
    companyId: number,
  ): Promise<Agent> {
    let agent = await this.prisma.agent.findUnique({
      where: { external_id },
    });
    if (!agent) {
      agent = await this.prisma.agent.create({
        data: {
          external_id,
          name,
          company_id: companyId,
        },
      });
    }
    return agent;
  }
}

@Injectable()
export class UserRepository {
  constructor(private readonly prisma: PrismaService) {}

  async findOrCreate(
    email: string,
    name?: string,
    role?: string,
  ): Promise<User> {
    let user = await this.prisma.user.findUnique({
      where: { email },
    });
    if (!user) {
      user = await this.prisma.user.create({
        data: {
          email,
          name: name || 'Unknown QA User',
          role: role || 'QA_Agent', // Default role if not provided
        },
      });
    }
    return user;
  }
}

@Injectable()
export class CallRepository {
  constructor(private readonly prisma: PrismaService) {}

  async findOrCreate(data: Prisma.CallUncheckedCreateInput): Promise<Call> {
    let call = await this.prisma.call.findUnique({
      where: { external_id: data.external_id },
    });
    if (!call) {
      call = await this.prisma.call.create({
        data,
      });
    }
    return call;
  }
}

@Injectable()
export class HumanEvaluationRepository {
  constructor(private readonly prisma: PrismaService) {}

  async create(
    data: Prisma.HumanEvaluationUncheckedCreateInput,
  ): Promise<HumanEvaluation> {
    return await this.prisma.humanEvaluation.create({
      data,
    });
  }
}

@Injectable()
export class LlmEvaluationRepository {
  constructor(private readonly prisma: PrismaService) {}

  async create(
    data: Prisma.LlmEvaluationUncheckedCreateInput,
  ): Promise<LlmEvaluation> {
    return await this.prisma.llmEvaluation.create({
      data,
    });
  }
}
