import { Injectable } from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';
import { Prisma } from '@prisma/client';

@Injectable()
export class CallsRepository {
  constructor(private readonly prisma: PrismaService) {}

  async findAll(params: { withTranscript?: boolean; from?: Date; to?: Date }) {
    const { withTranscript, from, to } = params;
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
    return this.prisma.call.findMany(filters);
  }

  async findOne(id: number) {
    return this.prisma.call.findUnique({ where: { id } });
  }

  async remove(id: number) {
    return this.prisma.call.delete({ where: { id } });
  }
  // Implement other CRUD methods as needed
}
