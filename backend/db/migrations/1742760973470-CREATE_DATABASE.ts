import { MigrationInterface, QueryRunner } from "typeorm";

export class CREATEDATABASE1742760973470 implements MigrationInterface {
    name = 'CREATEDATABASE1742760973470'

    public async up(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`CREATE TABLE \`exercise\` (\`id\` varchar(255) NOT NULL, \`gifUrl\` varchar(255) NOT NULL, \`bodyPart\` varchar(255) NOT NULL, \`target\` varchar(255) NOT NULL, \`equipment\` varchar(255) NOT NULL, \`name\` varchar(255) NOT NULL, \`instructions\` json NOT NULL, PRIMARY KEY (\`id\`)) ENGINE=InnoDB`);
        await queryRunner.query(`CREATE TABLE \`logged_set\` (\`id\` int NOT NULL AUTO_INCREMENT, \`weight\` int NOT NULL, \`rep\` int NOT NULL, \`setNumber\` int NOT NULL, \`workoutExerciseId\` int NULL, PRIMARY KEY (\`id\`)) ENGINE=InnoDB`);
        await queryRunner.query(`CREATE TABLE \`workout_exercise\` (\`id\` int NOT NULL AUTO_INCREMENT, \`workoutId\` int NOT NULL, \`exerciseId\` varchar(255) NOT NULL, \`restTimeSecond\` int NOT NULL, \`setCount\` int NOT NULL, PRIMARY KEY (\`id\`)) ENGINE=InnoDB`);
        await queryRunner.query(`CREATE TABLE \`workout\` (\`id\` int NOT NULL AUTO_INCREMENT, \`name\` varchar(255) NOT NULL, \`description\` varchar(255) NULL, \`createdAt\` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6), \`updatedAt\` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6), PRIMARY KEY (\`id\`)) ENGINE=InnoDB`);
        await queryRunner.query(`ALTER TABLE \`logged_set\` ADD CONSTRAINT \`FK_72f0a08d89bfbb0bbf30d4c18c6\` FOREIGN KEY (\`workoutExerciseId\`) REFERENCES \`workout_exercise\`(\`id\`) ON DELETE CASCADE ON UPDATE NO ACTION`);
        await queryRunner.query(`ALTER TABLE \`workout_exercise\` ADD CONSTRAINT \`FK_35fe273716366d768fba9964813\` FOREIGN KEY (\`workoutId\`) REFERENCES \`workout\`(\`id\`) ON DELETE CASCADE ON UPDATE NO ACTION`);
        await queryRunner.query(`ALTER TABLE \`workout_exercise\` ADD CONSTRAINT \`FK_a2ac7d92eeb9bd5fc2bb9896611\` FOREIGN KEY (\`exerciseId\`) REFERENCES \`exercise\`(\`id\`) ON DELETE CASCADE ON UPDATE NO ACTION`);
    }

    public async down(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`ALTER TABLE \`workout_exercise\` DROP FOREIGN KEY \`FK_a2ac7d92eeb9bd5fc2bb9896611\``);
        await queryRunner.query(`ALTER TABLE \`workout_exercise\` DROP FOREIGN KEY \`FK_35fe273716366d768fba9964813\``);
        await queryRunner.query(`ALTER TABLE \`logged_set\` DROP FOREIGN KEY \`FK_72f0a08d89bfbb0bbf30d4c18c6\``);
        await queryRunner.query(`DROP TABLE \`workout\``);
        await queryRunner.query(`DROP TABLE \`workout_exercise\``);
        await queryRunner.query(`DROP TABLE \`logged_set\``);
        await queryRunner.query(`DROP TABLE \`exercise\``);
    }

}
