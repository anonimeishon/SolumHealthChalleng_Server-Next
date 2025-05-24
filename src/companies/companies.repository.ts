import { Injectable } from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';
import { Prisma } from '../generated/prisma/client';

@Injectable()
export class CompaniesRepository {
  constructor(private readonly prisma: PrismaService) {}

  async findAll() {
    return this.prisma.company.findMany({
      include: {
        _count: {
          select: {
            agents: true,
            calls: true,
          },
        },
      },
      orderBy: {
        name: 'asc',
      },
    });
  }

  async findOne(id: number) {
    return this.prisma.company.findUnique({
      where: { id },
      include: {
        _count: {
          select: {
            agents: true,
            calls: true,
          },
        },
      },
    });
  }

  async create(data: Prisma.CompanyCreateInput) {
    return this.prisma.company.create({
      data,
      include: {
        _count: {
          select: {
            agents: true,
            calls: true,
          },
        },
      },
    });
  }

  async update(id: number, data: Prisma.CompanyUpdateInput) {
    return this.prisma.company.update({
      where: { id },
      data,
      include: {
        _count: {
          select: {
            agents: true,
            calls: true,
          },
        },
      },
    });
  }

  async remove(id: number) {
    return this.prisma.company.delete({
      where: { id },
    });
  }
}
