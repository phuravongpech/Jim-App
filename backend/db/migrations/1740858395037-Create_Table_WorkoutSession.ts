import { MigrationInterface, QueryRunner } from "typeorm";

export class CreateTableWorkoutSession1740858395037 implements MigrationInterface {
    name = 'CreateTableWorkoutSession1740858395037'

    public async up(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`CREATE TABLE \`workout_session\` (\`id\` int NOT NULL AUTO_INCREMENT, \`startWorkout\` varchar(255) NOT NULL, \`endWorkout\` varchar(255) NOT NULL, \`duration\` varchar(255) NOT NULL, \`createdAt\` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6), \`updatedAt\` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6), \`workoutId\` int NULL, PRIMARY KEY (\`id\`)) ENGINE=InnoDB`);
        await queryRunner.query(`ALTER TABLE \`activity_log\` ADD \`workoutSessionId\` int NULL`);
        await queryRunner.query(`ALTER TABLE \`activity_log\` DROP FOREIGN KEY \`FK_72f0a08d89bfbb0bbf30d4c18c6\``);
        await queryRunner.query(`ALTER TABLE \`activity_log\` CHANGE \`workoutExerciseId\` \`workoutExerciseId\` int NULL`);
        await queryRunner.query(`ALTER TABLE \`workout_exercise\` DROP FOREIGN KEY \`FK_35fe273716366d768fba9964813\``);
        await queryRunner.query(`ALTER TABLE \`workout_exercise\` DROP FOREIGN KEY \`FK_a2ac7d92eeb9bd5fc2bb9896611\``);
        await queryRunner.query(`ALTER TABLE \`workout_exercise\` CHANGE \`workoutId\` \`workoutId\` int NULL`);
        await queryRunner.query(`ALTER TABLE \`workout_exercise\` CHANGE \`exerciseId\` \`exerciseId\` varchar(255) NULL`);
        await queryRunner.query(`ALTER TABLE \`workout\` CHANGE \`description\` \`description\` varchar(255) NULL`);
        await queryRunner.query(`ALTER TABLE \`activity_log\` ADD CONSTRAINT \`FK_72f0a08d89bfbb0bbf30d4c18c6\` FOREIGN KEY (\`workoutExerciseId\`) REFERENCES \`workout_exercise\`(\`id\`) ON DELETE CASCADE ON UPDATE NO ACTION`);
        await queryRunner.query(`ALTER TABLE \`activity_log\` ADD CONSTRAINT \`FK_5b794df2c17825877f610b0bf24\` FOREIGN KEY (\`workoutSessionId\`) REFERENCES \`workout_session\`(\`id\`) ON DELETE CASCADE ON UPDATE NO ACTION`);
        await queryRunner.query(`ALTER TABLE \`workout_exercise\` ADD CONSTRAINT \`FK_35fe273716366d768fba9964813\` FOREIGN KEY (\`workoutId\`) REFERENCES \`workout\`(\`id\`) ON DELETE CASCADE ON UPDATE NO ACTION`);
        await queryRunner.query(`ALTER TABLE \`workout_exercise\` ADD CONSTRAINT \`FK_a2ac7d92eeb9bd5fc2bb9896611\` FOREIGN KEY (\`exerciseId\`) REFERENCES \`exercise\`(\`id\`) ON DELETE CASCADE ON UPDATE NO ACTION`);
        await queryRunner.query(`ALTER TABLE \`workout_session\` ADD CONSTRAINT \`FK_4233e722a30320ee5747a1f9fc5\` FOREIGN KEY (\`workoutId\`) REFERENCES \`workout\`(\`id\`) ON DELETE CASCADE ON UPDATE NO ACTION`);
    }

    public async down(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`ALTER TABLE \`workout_session\` DROP FOREIGN KEY \`FK_4233e722a30320ee5747a1f9fc5\``);
        await queryRunner.query(`ALTER TABLE \`workout_exercise\` DROP FOREIGN KEY \`FK_a2ac7d92eeb9bd5fc2bb9896611\``);
        await queryRunner.query(`ALTER TABLE \`workout_exercise\` DROP FOREIGN KEY \`FK_35fe273716366d768fba9964813\``);
        await queryRunner.query(`ALTER TABLE \`activity_log\` DROP FOREIGN KEY \`FK_5b794df2c17825877f610b0bf24\``);
        await queryRunner.query(`ALTER TABLE \`activity_log\` DROP FOREIGN KEY \`FK_72f0a08d89bfbb0bbf30d4c18c6\``);
        await queryRunner.query(`ALTER TABLE \`workout\` CHANGE \`description\` \`description\` varchar(255) NULL DEFAULT 'NULL'`);
        await queryRunner.query(`ALTER TABLE \`workout_exercise\` CHANGE \`exerciseId\` \`exerciseId\` varchar(255) NULL DEFAULT 'NULL'`);
        await queryRunner.query(`ALTER TABLE \`workout_exercise\` CHANGE \`workoutId\` \`workoutId\` int NULL DEFAULT 'NULL'`);
        await queryRunner.query(`ALTER TABLE \`workout_exercise\` ADD CONSTRAINT \`FK_a2ac7d92eeb9bd5fc2bb9896611\` FOREIGN KEY (\`exerciseId\`) REFERENCES \`exercise\`(\`id\`) ON DELETE CASCADE ON UPDATE NO ACTION`);
        await queryRunner.query(`ALTER TABLE \`workout_exercise\` ADD CONSTRAINT \`FK_35fe273716366d768fba9964813\` FOREIGN KEY (\`workoutId\`) REFERENCES \`workout\`(\`id\`) ON DELETE CASCADE ON UPDATE NO ACTION`);
        await queryRunner.query(`ALTER TABLE \`activity_log\` CHANGE \`workoutExerciseId\` \`workoutExerciseId\` int NULL DEFAULT 'NULL'`);
        await queryRunner.query(`ALTER TABLE \`activity_log\` ADD CONSTRAINT \`FK_72f0a08d89bfbb0bbf30d4c18c6\` FOREIGN KEY (\`workoutExerciseId\`) REFERENCES \`workout_exercise\`(\`id\`) ON DELETE CASCADE ON UPDATE NO ACTION`);
        await queryRunner.query(`ALTER TABLE \`activity_log\` DROP COLUMN \`workoutSessionId\``);
        await queryRunner.query(`DROP TABLE \`workout_session\``);
    }

}
