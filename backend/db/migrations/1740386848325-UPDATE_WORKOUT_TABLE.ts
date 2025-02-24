import { MigrationInterface, QueryRunner } from "typeorm";

export class UPDATEWORKOUTTABLE1740386848325 implements MigrationInterface {
    name = 'UPDATEWORKOUTTABLE1740386848325'

    public async up(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`ALTER TABLE \`workout\` ADD \`createdAt\` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6)`);
        await queryRunner.query(`ALTER TABLE \`workout\` ADD \`updatedAt\` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6)`);
    }

    public async down(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`ALTER TABLE \`workout\` DROP COLUMN \`updatedAt\``);
        await queryRunner.query(`ALTER TABLE \`workout\` DROP COLUMN \`createdAt\``);
    }

}
