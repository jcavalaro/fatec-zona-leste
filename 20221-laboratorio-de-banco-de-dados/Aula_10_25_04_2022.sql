/* 
Trigger: São gatilhos que disparam ações

- Eventos: INSERT, UPDATE e DELETE
- Tempo: BEFORE e AFTER
- Escopo: FOR EACH ROW e INSTRUÇÃO
- Pseudo Colunas: NEW.<coluna> INSERT
							   UPDATE
				  OLD.<coluna> UPDATE
                               DELETE
- Auditoria
- Historico de Alteracao

- Sintaxe MySQL
CREATE TRIGGER <nome_Trigger>
	AFTER <DELETE | INSERT | UPDATE>
		ON <nome_Tabela>
		<FOR EACH ROW>
	BEGIN
		corpo do código – SQL 
	END
*/

USE AULA_10_25_04_2022;

DROP TABLE IF EXISTS TB_LOG_PROFESSOR;
DROP TRIGGER IF EXISTS TGR_TB_PROFESSOR_INSERT;
DROP TRIGGER IF EXISTS TGR_TB_PROFESSOR_UPDATE;
DROP TRIGGER IF EXISTS TGR_TB_PROFESSOR_DELETE;

CREATE TABLE TB_LOG_PROFESSOR (
	USUARIO VARCHAR(40) NOT NULL,
	COD_PROF INT,
	TIPO_ALTERACAO VARCHAR(10),
	DATA_ALTERACAO DATETIME
);

DELIMITER $$
CREATE TRIGGER TGR_TB_PROFESSOR_INSERT BEFORE INSERT 
ON TB_PROFESSOR
FOR EACH ROW
BEGIN
	INSERT INTO TB_LOG_PROFESSOR (USUARIO, COD_PROF, TIPO_ALTERACAO, DATA_ALTERACAO) VALUES (CURRENT_USER(), NEW.COD_PROF, 'INSERT', NOW());
END $$

CREATE TRIGGER TGR_TB_PROFESSOR_UPDATE AFTER UPDATE 
ON TB_PROFESSOR
FOR EACH ROW
BEGIN
	INSERT INTO TB_LOG_PROFESSOR (USUARIO, COD_PROF, TIPO_ALTERACAO, DATA_ALTERACAO) VALUES (CURRENT_USER(), NEW.COD_PROF, 'UPDATE', NOW());
END $$

CREATE TRIGGER TGR_TB_PROFESSOR_DELETE AFTER DELETE 
ON TB_PROFESSOR
FOR EACH ROW
BEGIN
	INSERT INTO TB_LOG_PROFESSOR (USUARIO, COD_PROF, TIPO_ALTERACAO, DATA_ALTERACAO) VALUES (CURRENT_USER(), OLD.COD_PROF, 'DELETE', NOW());
END $$
DELIMITER ;

INSERT INTO TB_PROFESSOR(COD_PROF, COD_DEPTO, COD_TIT, NOME_PROF) VALUES (5, 'INF01', 2, 'Marcus');
INSERT INTO TB_PROFESSOR(COD_PROF, COD_DEPTO, COD_TIT, NOME_PROF) VALUES (6, 'MAT01', 2, 'Wellington');

UPDATE TB_PROFESSOR SET NOME_PROF = 'Marcus Vasconcelos' WHERE COD_PROF = 5;
UPDATE TB_PROFESSOR SET COD_TIT = 1 WHERE COD_PROF = 6;
    
DELETE FROM TB_PROFESSOR WHERE COD_PROF = 5;
DELETE FROM TB_PROFESSOR WHERE COD_PROF = 6;
 
SELECT USUARIO, COD_PROF, TIPO_ALTERACAO, DATA_ALTERACAO FROM TB_LOG_PROFESSOR;