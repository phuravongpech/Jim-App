import { MigrationInterface, QueryRunner } from "typeorm";

export class CREATEWorkOutSession1743070742079 implements MigrationInterface {
    name = 'CREATEWorkOutSession1743070742079'

    public async up(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`ALTER TABLE \`logged_set\` DROP FOREIGN KEY \`FK_72f0a08d89bfbb0bbf30d4c18c6\``);
        await queryRunner.query(`CREATE TABLE \`workout_session\` (\`id\` int NOT NULL AUTO_INCREMENT, \`startWorkout\` varchar(255) NOT NULL, \`endWorkout\` varchar(255) NOT NULL, \`duration\` varchar(255) NOT NULL, \`createdAt\` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6), \`workoutId\` int NULL, PRIMARY KEY (\`id\`)) ENGINE=InnoDB`);
        await queryRunner.query(`ALTER TABLE \`logged_set\` ADD \`workoutSessionId\` int NULL`);
        await queryRunner.query(`ALTER TABLE \`logged_set\` CHANGE \`workoutExerciseId\` \`workoutExerciseId\` int NULL`);
        await queryRunner.query(`ALTER TABLE \`workout\` CHANGE \`description\` \`description\` varchar(255) NULL`);
        await queryRunner.query(`ALTER TABLE \`logged_set\` ADD CONSTRAINT \`FK_dc905d6547c8d0780266d45c468\` FOREIGN KEY (\`workoutExerciseId\`) REFERENCES \`workout_exercise\`(\`id\`) ON DELETE CASCADE ON UPDATE NO ACTION`);
        await queryRunner.query(`ALTER TABLE \`logged_set\` ADD CONSTRAINT \`FK_0fc8e515a519021b6dda6dc6d48\` FOREIGN KEY (\`workoutSessionId\`) REFERENCES \`workout_session\`(\`id\`) ON DELETE NO ACTION ON UPDATE NO ACTION`);
        await queryRunner.query(`ALTER TABLE \`workout_session\` ADD CONSTRAINT \`FK_4233e722a30320ee5747a1f9fc5\` FOREIGN KEY (\`workoutId\`) REFERENCES \`workout\`(\`id\`) ON DELETE NO ACTION ON UPDATE NO ACTION`);
    }

    public async down(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`ALTER TABLE \`workout_session\` DROP FOREIGN KEY \`FK_4233e722a30320ee5747a1f9fc5\``);
        await queryRunner.query(`ALTER TABLE \`logged_set\` DROP FOREIGN KEY \`FK_0fc8e515a519021b6dda6dc6d48\``);
        await queryRunner.query(`ALTER TABLE \`logged_set\` DROP FOREIGN KEY \`FK_dc905d6547c8d0780266d45c468\``);
        await queryRunner.query(`ALTER TABLE \`workout\` CHANGE \`description\` \`description\` varchar(255) NULL DEFAULT 'NULL'`);
        await queryRunner.query(`ALTER TABLE \`logged_set\` CHANGE \`workoutExerciseId\` \`workoutExerciseId\` int NULL DEFAULT 'NULL'`);
        await queryRunner.query(`ALTER TABLE \`logged_set\` DROP COLUMN \`workoutSessionId\``);
        await queryRunner.query(`DROP TABLE \`workout_session\``);
        await queryRunner.query(`ALTER TABLE \`logged_set\` ADD CONSTRAINT \`FK_72f0a08d89bfbb0bbf30d4c18c6\` FOREIGN KEY (\`workoutExerciseId\`) REFERENCES \`workout_exercise\`(\`id\`) ON DELETE CASCADE ON UPDATE NO ACTION`);
    }

}
