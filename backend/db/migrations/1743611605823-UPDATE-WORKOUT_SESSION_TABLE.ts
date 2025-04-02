import { MigrationInterface, QueryRunner } from "typeorm";

export class UPDATEWORKOUTSESSIONTABLE1743611605823 implements MigrationInterface {
    name = 'UPDATEWORKOUTSESSIONTABLE1743611605823'

    public async up(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`ALTER TABLE \`workout_session\` DROP COLUMN \`startWorkout\``);
    }

    public async down(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`ALTER TABLE \`workout_session\` ADD \`startWorkout\` varchar(255) NOT NULL`);
    }

}
