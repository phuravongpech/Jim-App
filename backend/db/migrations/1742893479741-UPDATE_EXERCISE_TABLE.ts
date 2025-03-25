import { MigrationInterface, QueryRunner } from "typeorm";

export class UPDATEEXERCISETABLE1742893479741 implements MigrationInterface {
    name = 'UPDATEEXERCISETABLE1742893479741'

    public async up(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`ALTER TABLE \`exercise\` CHANGE \`instruction\` \`instructions\` json NOT NULL`);
    }

    public async down(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`ALTER TABLE \`exercise\` CHANGE \`instructions\` \`instruction\` json NOT NULL`);
    }

}
