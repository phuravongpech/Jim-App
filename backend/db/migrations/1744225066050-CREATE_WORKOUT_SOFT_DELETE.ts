import { MigrationInterface, QueryRunner } from "typeorm";

export class CREATEWORKOUTSOFTDELETE1744225066050 implements MigrationInterface {
    name = 'CREATEWORKOUTSOFTDELETE1744225066050'

    public async up(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`ALTER TABLE \`workout_session\` DROP FOREIGN KEY \`FK_4233e722a30320ee5747a1f9fc5\``);
        await queryRunner.query(`ALTER TABLE \`logged_set\` DROP FOREIGN KEY \`FK_dc905d6547c8d0780266d45c468\``);
        await queryRunner.query(`ALTER TABLE \`workout_exercise\` DROP FOREIGN KEY \`FK_a2ac7d92eeb9bd5fc2bb9896611\``);
        await queryRunner.query(`ALTER TABLE \`workout\` ADD \`deletedAt\` datetime(6) NULL`);
        await queryRunner.query(`ALTER TABLE \`workout_session\` ADD CONSTRAINT \`FK_4233e722a30320ee5747a1f9fc5\` FOREIGN KEY (\`workoutId\`) REFERENCES \`workout\`(\`id\`) ON DELETE NO ACTION ON UPDATE NO ACTION`);
        await queryRunner.query(`ALTER TABLE \`logged_set\` ADD CONSTRAINT \`FK_dc905d6547c8d0780266d45c468\` FOREIGN KEY (\`workoutExerciseId\`) REFERENCES \`workout_exercise\`(\`id\`) ON DELETE CASCADE ON UPDATE NO ACTION`);
        await queryRunner.query(`ALTER TABLE \`workout_exercise\` ADD CONSTRAINT \`FK_a2ac7d92eeb9bd5fc2bb9896611\` FOREIGN KEY (\`exerciseId\`) REFERENCES \`exercise\`(\`id\`) ON DELETE NO ACTION ON UPDATE NO ACTION`);
    }

    public async down(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`ALTER TABLE \`workout_exercise\` DROP FOREIGN KEY \`FK_a2ac7d92eeb9bd5fc2bb9896611\``);
        await queryRunner.query(`ALTER TABLE \`logged_set\` DROP FOREIGN KEY \`FK_dc905d6547c8d0780266d45c468\``);
        await queryRunner.query(`ALTER TABLE \`workout_session\` DROP FOREIGN KEY \`FK_4233e722a30320ee5747a1f9fc5\``);
        await queryRunner.query(`ALTER TABLE \`workout\` DROP COLUMN \`deletedAt\``);
        await queryRunner.query(`ALTER TABLE \`workout_exercise\` ADD CONSTRAINT \`FK_a2ac7d92eeb9bd5fc2bb9896611\` FOREIGN KEY (\`exerciseId\`) REFERENCES \`exercise\`(\`id\`) ON DELETE CASCADE ON UPDATE NO ACTION`);
        await queryRunner.query(`ALTER TABLE \`logged_set\` ADD CONSTRAINT \`FK_dc905d6547c8d0780266d45c468\` FOREIGN KEY (\`workoutExerciseId\`) REFERENCES \`workout_exercise\`(\`id\`) ON DELETE SET NULL ON UPDATE NO ACTION`);
        await queryRunner.query(`ALTER TABLE \`workout_session\` ADD CONSTRAINT \`FK_4233e722a30320ee5747a1f9fc5\` FOREIGN KEY (\`workoutId\`) REFERENCES \`workout\`(\`id\`) ON DELETE SET NULL ON UPDATE NO ACTION`);
    }

}
