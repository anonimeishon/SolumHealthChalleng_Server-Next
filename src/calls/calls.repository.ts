import { Injectable } from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';
import { Prisma } from '@prisma/client';

@Injectable()
export class CallsRepository {
  constructor(private readonly prisma: PrismaService) {}

  async findAll(params: {
    withTranscript?: boolean;
    from?: Date;
    to?: Date;
    companyId?: number;
  }) {
    const { withTranscript, from, to, companyId } = params;
    let filters: Prisma.CallFindManyArgs = {
      include: {
        company: true,
        human_evaluations: true,
        llm_evaluations: true,
      },
    };
    if (withTranscript) {
      filters = { where: { transcript: { not: { equals: null } } } };
    }
    if (from && to) {
      filters.where = {
        ...filters.where,
        start_date: {
          gte: from,
          lte: to,
        },
      };
    } else if (from) {
      filters.where = {
        ...filters.where,
        start_date: {
          gte: from,
        },
      };
    } else if (to) {
      filters.where = {
        ...filters.where,
        start_date: {
          lte: to,
        },
      };
    }
    if (params.companyId) {
      filters.where = {
        ...filters.where,
        company_id: companyId,
      };
    }
    return this.prisma.call.findMany(filters);
  }

  async findOne(id: number) {
    return this.prisma.call.findUnique({
      where: { id },
      include: {
        company: true,
        agent: true,
        human_evaluations: true,
        llm_evaluations: true,
      },
    });
  }

  async remove(id: number) {
    return this.prisma.call.delete({ where: { id } });
  }

  async updateTranscript(id: number, transcript: string) {
    return this.prisma.call.update({
      where: { id },
      data: {
        transcript,
        transcription_status: 'FINISHED',
      },
      include: {
        company: true,
        agent: true,
        human_evaluations: true,
        llm_evaluations: true,
      },
    });
  }

  async updateTranscriptionStatus(
    id: number,
    status: 'NOT_STARTED' | 'PENDING' | 'FINISHED' | 'FAILED',
  ) {
    return this.prisma.call.update({
      where: { id },
      data: { transcription_status: status },
      include: {
        company: true,
        agent: true,
        human_evaluations: true,
        llm_evaluations: true,
      },
    });
  }

  // Implement other CRUD methods as needed
}
