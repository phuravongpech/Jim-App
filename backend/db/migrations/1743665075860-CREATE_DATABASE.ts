import { MigrationInterface, QueryRunner } from "typeorm";

export class CREATEDATABASE1743665075860 implements MigrationInterface {
    name = 'CREATEDATABASE1743665075860'

    public async up(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`CREATE TABLE \`exercise\` (\`id\` varchar(255) NOT NULL, \`gifUrl\` varchar(255) NOT NULL, \`bodyPart\` varchar(255) NOT NULL, \`target\` varchar(255) NOT NULL, \`equipment\` varchar(255) NOT NULL, \`name\` varchar(255) NOT NULL, \`instructions\` json NOT NULL, PRIMARY KEY (\`id\`)) ENGINE=InnoDB`);
        await queryRunner.query(`CREATE TABLE \`logged_set\` (\`id\` int NOT NULL AUTO_INCREMENT, \`weight\` int NOT NULL, \`rep\` int NOT NULL, \`setNumber\` int NOT NULL, \`workoutExerciseId\` int NULL, \`workoutSessionId\` int NOT NULL, PRIMARY KEY (\`id\`)) ENGINE=InnoDB`);
        await queryRunner.query(`CREATE TABLE \`workout_exercise\` (\`id\` int NOT NULL AUTO_INCREMENT, \`workoutId\` int NOT NULL, \`exerciseId\` varchar(255) NOT NULL, \`restTimeSecond\` int NOT NULL, \`setCount\` int NOT NULL, PRIMARY KEY (\`id\`)) ENGINE=InnoDB`);
        await queryRunner.query(`CREATE TABLE \`workout\` (\`id\` int NOT NULL AUTO_INCREMENT, \`name\` varchar(255) NOT NULL, \`description\` varchar(255) NULL, \`createdAt\` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6), \`updatedAt\` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6), PRIMARY KEY (\`id\`)) ENGINE=InnoDB`);
        await queryRunner.query(`CREATE TABLE \`workout_session\` (\`id\` int NOT NULL AUTO_INCREMENT, \`workoutId\` int NULL, \`startWorkout\` varchar(255) NOT NULL, \`endWorkout\` varchar(255) NOT NULL, PRIMARY KEY (\`id\`)) ENGINE=InnoDB`);
        await queryRunner.query(`ALTER TABLE \`logged_set\` ADD CONSTRAINT \`FK_dc905d6547c8d0780266d45c468\` FOREIGN KEY (\`workoutExerciseId\`) REFERENCES \`workout_exercise\`(\`id\`) ON DELETE SET NULL ON UPDATE NO ACTION`);
        await queryRunner.query(`ALTER TABLE \`logged_set\` ADD CONSTRAINT \`FK_0fc8e515a519021b6dda6dc6d48\` FOREIGN KEY (\`workoutSessionId\`) REFERENCES \`workout_session\`(\`id\`) ON DELETE NO ACTION ON UPDATE NO ACTION`);
        await queryRunner.query(`ALTER TABLE \`workout_exercise\` ADD CONSTRAINT \`FK_35fe273716366d768fba9964813\` FOREIGN KEY (\`workoutId\`) REFERENCES \`workout\`(\`id\`) ON DELETE CASCADE ON UPDATE NO ACTION`);
        await queryRunner.query(`ALTER TABLE \`workout_exercise\` ADD CONSTRAINT \`FK_a2ac7d92eeb9bd5fc2bb9896611\` FOREIGN KEY (\`exerciseId\`) REFERENCES \`exercise\`(\`id\`) ON DELETE CASCADE ON UPDATE NO ACTION`);
        await queryRunner.query(`ALTER TABLE \`workout_session\` ADD CONSTRAINT \`FK_4233e722a30320ee5747a1f9fc5\` FOREIGN KEY (\`workoutId\`) REFERENCES \`workout\`(\`id\`) ON DELETE SET NULL ON UPDATE NO ACTION`);
    }

    public async down(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`ALTER TABLE \`workout_session\` DROP FOREIGN KEY \`FK_4233e722a30320ee5747a1f9fc5\``);
        await queryRunner.query(`ALTER TABLE \`workout_exercise\` DROP FOREIGN KEY \`FK_a2ac7d92eeb9bd5fc2bb9896611\``);
        await queryRunner.query(`ALTER TABLE \`workout_exercise\` DROP FOREIGN KEY \`FK_35fe273716366d768fba9964813\``);
        await queryRunner.query(`ALTER TABLE \`logged_set\` DROP FOREIGN KEY \`FK_0fc8e515a519021b6dda6dc6d48\``);
        await queryRunner.query(`ALTER TABLE \`logged_set\` DROP FOREIGN KEY \`FK_dc905d6547c8d0780266d45c468\``);
        await queryRunner.query(`DROP TABLE \`workout_session\``);
        await queryRunner.query(`DROP TABLE \`workout\``);
        await queryRunner.query(`DROP TABLE \`workout_exercise\``);
        await queryRunner.query(`DROP TABLE \`logged_set\``);
        await queryRunner.query(`DROP TABLE \`exercise\``);
    }

}
