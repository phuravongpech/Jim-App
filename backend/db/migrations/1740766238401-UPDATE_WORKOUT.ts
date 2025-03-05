import { MigrationInterface, QueryRunner } from "typeorm";

export class UPDATEWORKOUT1740766238401 implements MigrationInterface {
    name = 'UPDATEWORKOUT1740766238401'

    public async up(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`ALTER TABLE \`workout\` DROP COLUMN \`date\``);
        await queryRunner.query(`ALTER TABLE \`workout\` DROP COLUMN \`category\``);
        await queryRunner.query(`ALTER TABLE \`activity_log\` ADD \`createdAt\` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6)`);
        await queryRunner.query(`ALTER TABLE \`activity_log\` ADD \`updatedAt\` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6)`);
        await queryRunner.query(`ALTER TABLE \`workout\` ADD \`createdAt\` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6)`);
        await queryRunner.query(`ALTER TABLE \`workout\` ADD \`updatedAt\` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6)`);
        await queryRunner.query(`ALTER TABLE \`workout_exercise\` DROP FOREIGN KEY \`FK_a2ac7d92eeb9bd5fc2bb9896611\``);
        await queryRunner.query(`ALTER TABLE \`exercise\` CHANGE \`id\` \`id\` int NOT NULL`);
        await queryRunner.query(`ALTER TABLE \`exercise\` DROP PRIMARY KEY`);
        await queryRunner.query(`ALTER TABLE \`exercise\` DROP COLUMN \`id\``);
        await queryRunner.query(`ALTER TABLE \`exercise\` ADD \`id\` varchar(255) NOT NULL PRIMARY KEY`);
        await queryRunner.query(`ALTER TABLE \`activity_log\` DROP FOREIGN KEY \`FK_72f0a08d89bfbb0bbf30d4c18c6\``);
        await queryRunner.query(`ALTER TABLE \`activity_log\` CHANGE \`workoutExerciseId\` \`workoutExerciseId\` int NULL`);
        await queryRunner.query(`ALTER TABLE \`workout\` CHANGE \`description\` \`description\` varchar(255) NULL`);
        await queryRunner.query(`ALTER TABLE \`workout_exercise\` DROP FOREIGN KEY \`FK_35fe273716366d768fba9964813\``);
        await queryRunner.query(`ALTER TABLE \`workout_exercise\` CHANGE \`workoutId\` \`workoutId\` int NULL`);
        await queryRunner.query(`ALTER TABLE \`workout_exercise\` DROP COLUMN \`exerciseId\``);
        await queryRunner.query(`ALTER TABLE \`workout_exercise\` ADD \`exerciseId\` varchar(255) NULL`);
        await queryRunner.query(`ALTER TABLE \`activity_log\` ADD CONSTRAINT \`FK_72f0a08d89bfbb0bbf30d4c18c6\` FOREIGN KEY (\`workoutExerciseId\`) REFERENCES \`workout_exercise\`(\`id\`) ON DELETE CASCADE ON UPDATE NO ACTION`);
        await queryRunner.query(`ALTER TABLE \`workout_exercise\` ADD CONSTRAINT \`FK_35fe273716366d768fba9964813\` FOREIGN KEY (\`workoutId\`) REFERENCES \`workout\`(\`id\`) ON DELETE CASCADE ON UPDATE NO ACTION`);
        await queryRunner.query(`ALTER TABLE \`workout_exercise\` ADD CONSTRAINT \`FK_a2ac7d92eeb9bd5fc2bb9896611\` FOREIGN KEY (\`exerciseId\`) REFERENCES \`exercise\`(\`id\`) ON DELETE CASCADE ON UPDATE NO ACTION`);
    }

    public async down(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`ALTER TABLE \`workout_exercise\` DROP FOREIGN KEY \`FK_a2ac7d92eeb9bd5fc2bb9896611\``);
        await queryRunner.query(`ALTER TABLE \`workout_exercise\` DROP FOREIGN KEY \`FK_35fe273716366d768fba9964813\``);
        await queryRunner.query(`ALTER TABLE \`activity_log\` DROP FOREIGN KEY \`FK_72f0a08d89bfbb0bbf30d4c18c6\``);
        await queryRunner.query(`ALTER TABLE \`workout_exercise\` DROP COLUMN \`exerciseId\``);
        await queryRunner.query(`ALTER TABLE \`workout_exercise\` ADD \`exerciseId\` int NULL DEFAULT 'NULL'`);
        await queryRunner.query(`ALTER TABLE \`workout_exercise\` CHANGE \`workoutId\` \`workoutId\` int NULL DEFAULT 'NULL'`);
        await queryRunner.query(`ALTER TABLE \`workout_exercise\` ADD CONSTRAINT \`FK_35fe273716366d768fba9964813\` FOREIGN KEY (\`workoutId\`) REFERENCES \`workout\`(\`id\`) ON DELETE CASCADE ON UPDATE NO ACTION`);
        await queryRunner.query(`ALTER TABLE \`workout\` CHANGE \`description\` \`description\` varchar(255) NULL DEFAULT 'NULL'`);
        await queryRunner.query(`ALTER TABLE \`activity_log\` CHANGE \`workoutExerciseId\` \`workoutExerciseId\` int NULL DEFAULT 'NULL'`);
        await queryRunner.query(`ALTER TABLE \`activity_log\` ADD CONSTRAINT \`FK_72f0a08d89bfbb0bbf30d4c18c6\` FOREIGN KEY (\`workoutExerciseId\`) REFERENCES \`workout_exercise\`(\`id\`) ON DELETE CASCADE ON UPDATE NO ACTION`);
        await queryRunner.query(`ALTER TABLE \`exercise\` DROP COLUMN \`id\``);
        await queryRunner.query(`ALTER TABLE \`exercise\` ADD \`id\` int NOT NULL AUTO_INCREMENT`);
        await queryRunner.query(`ALTER TABLE \`exercise\` ADD PRIMARY KEY (\`id\`)`);
        await queryRunner.query(`ALTER TABLE \`exercise\` CHANGE \`id\` \`id\` int NOT NULL AUTO_INCREMENT`);
        await queryRunner.query(`ALTER TABLE \`workout_exercise\` ADD CONSTRAINT \`FK_a2ac7d92eeb9bd5fc2bb9896611\` FOREIGN KEY (\`exerciseId\`) REFERENCES \`exercise\`(\`id\`) ON DELETE CASCADE ON UPDATE NO ACTION`);
        await queryRunner.query(`ALTER TABLE \`workout\` DROP COLUMN \`updatedAt\``);
        await queryRunner.query(`ALTER TABLE \`workout\` DROP COLUMN \`createdAt\``);
        await queryRunner.query(`ALTER TABLE \`activity_log\` DROP COLUMN \`updatedAt\``);
        await queryRunner.query(`ALTER TABLE \`activity_log\` DROP COLUMN \`createdAt\``);
        await queryRunner.query(`ALTER TABLE \`workout\` ADD \`category\` varchar(255) NOT NULL`);
        await queryRunner.query(`ALTER TABLE \`workout\` ADD \`date\` datetime NOT NULL`);
    }

}
