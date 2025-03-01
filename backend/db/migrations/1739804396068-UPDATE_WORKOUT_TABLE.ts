import { MigrationInterface, QueryRunner } from "typeorm";

export class UPDATEWORKOUTTABLE1739804396068 implements MigrationInterface {
    name = 'UPDATEWORKOUTTABLE1739804396068'

    public async up(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`ALTER TABLE \`workout\` CHANGE \`date\` \`createdAt\` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6)`);
    }

    public async down(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`ALTER TABLE \`workout\` CHANGE \`createdAt\` \`date\` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6)`);
    }

}
