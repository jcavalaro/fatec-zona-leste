-- Nome: Ana Beatriz Barbosa Alves / Impar RA: 1110482113012
-- A - FUNCIONOU

/* 
Laboratório de Banco de Dados - Prof: Joilson de Souza Cardoso - Prova 01

Orientações
- Entregar a Prova no Pen Drive 
- Arquivo deve ser salvo na raiz do Pen Drive 
- Nome do Arquivo: Nome Completo.SQL
- Dentro do arquivo na Primeira linha: Nome Completo e RA(Opcional) 
- Escolher dentre as opções na 2ª Linha:
								A - Funcionou 
                                B - Compilou mas não funcionou 
                                C - Nem Compilou 
                                
Enunciado:
Criar procedure usando cursor para:
Par: Para cada disciplina que possui pré-requisito, obter o nome da disciplina seguido do nome da disciplina que é seu pre-requisito                                
Impar: Obter o numero de disciplinas do departamento denominado informatica.
*/

/* ****************** INICIO ******************** */
/* Resposta: */
/* Conecta ao banco PROVA_P1 */
USE PROVA_P1;

DELIMITER $$
CREATE PROCEDURE NUMERO_DE_DISC_DEPTO_INFORMATICA()
BEGIN
	DECLARE DONE INT DEFAULT 0;
	DECLARE C_NUMERO_DISCIPLINAS_INFORMATICA INT;
	DECLARE C1 CURSOR FOR 
		SELECT
			COUNT(NUM_DISC)
		FROM
			TB_DISCIPLINA A,
			TB_DEPTO B
		WHERE
			A.COD_DEPTO = B.COD_DEPTO
		AND 
			NOME_DEPTO = 'Informática';

	DECLARE CONTINUE HANDLER FOR NOT FOUND SET DONE = 1;
    
OPEN C1;

	CREATE TEMPORARY TABLE TB_RESULT (
		R_NUMERO_DISCIPLINAS_INFORMATICA INT
	);
    
    LOOP_NUM_DISC: LOOP
	FETCH C1 INTO C_NUMERO_DISCIPLINAS_INFORMATICA;
    IF DONE THEN
		SELECT R_NUMERO_DISCIPLINAS_INFORMATICA AS NUMERO_DISCIPLINAS_INFORMATICA FROM TB_RESULT;
		LEAVE LOOP_NUM_DISC;
	END IF;
    INSERT INTO TB_RESULT (R_NUMERO_DISCIPLINAS_INFORMATICA) VALUES (C_NUMERO_DISCIPLINAS_INFORMATICA);
	END LOOP LOOP_NUM_DISC;

CLOSE C1;
   
DROP TEMPORARY TABLE TB_RESULT;

END$$
DELIMITER ;

CALL NUMERO_DE_DISC_DEPTO_INFORMATICA();
DROP PROCEDURE NUMERO_DE_DISC_DEPTO_INFORMATICA;
/* ****************** FIM ******************** */

/* *************************** Foi necessário utilizar: *********************************** */
DROP DATABASE IF EXISTS PROVA_P1;

/* Criacao do banco DB_UNIVERSIDADE */
CREATE DATABASE PROVA_P1;

/* Conecta ao banco DB_UNIVERSIDADE */
USE PROVA_P1;

/* Criacao da tabela TB_DEPTO */
CREATE TABLE TB_DEPTO (COD_DEPTO CHAR(5), NOME_DEPTO VARCHAR(40));

/* Criacao da tabela TB_DISCIPLINA */
CREATE TABLE TB_DISCIPLINA (COD_DEPTO CHAR(5), NUM_DISC INT, NOME_DISC VARCHAR(10), CREDITO_DISC INT);

/* Criacao da tabela TB_PRE_REQ */
CREATE TABLE TB_PRE_REQ (COD_DEPTO CHAR(5), NUM_DISC INT, COD_DEPTO_PRE_REQ CHAR(5), NUM_DISC_PRE_REQ INT);

/* Criacao da tabela TB_TURMA */
CREATE TABLE TB_TURMA (ANO_SEM INT, COD_DEPTO CHAR(5), NUM_DISC INT, SIGLA_TUR CHAR(2), CAPAC_TUR INT);

/* Criacao da tabela TB_HORARIO */
CREATE TABLE TB_HORARIO (ANO_SEM INT, COD_DEPTO CHAR(5), NUM_DISC INT, SIGLA_TUR CHAR(2), DIA_SEM INT, HORA_INICIO INT, COD_PRED INT, NUM_SALA INT, NUM_HORAS INT);

/* Criacao da tabela TB_PREDIO */
CREATE TABLE TB_PREDIO (COD_PRED INT, NOME_PRED VARCHAR(40));

/* Criacao da tabela TB_SALA */
CREATE TABLE TB_SALA (COD_PRED INT, NUM_SALA INT, DESCRICAO_SALA VARCHAR(40), CAPAC_SALA INT);

/* Criacao da tabela TB_PROFESSOR */
CREATE TABLE TB_PROFESSOR (COD_PROF INT, COD_DEPTO CHAR(5), COD_TIT INT, NOME_PROF VARCHAR(40));

/* Criacao da tabela TB_PROF_TURMA */
CREATE TABLE TB_PROF_TURMA (ANO_SEM INT, COD_DEPTO CHAR(5), NUM_DISC INT, SIGLA_TUR CHAR(2), COD_PROF INT);

/* Criacao da tabela TB_TITULACAO */
CREATE TABLE TB_TITULACAO (COD_TIT INT, NOME_TIT VARCHAR(40));

/* Adicionar PK nas tabelas */
ALTER TABLE TB_DISCIPLINA ADD CONSTRAINT PK_TB_DISCIPLINA PRIMARY KEY (COD_DEPTO, NUM_DISC);   
ALTER TABLE TB_DEPTO ADD CONSTRAINT PK_TB_DEPTO PRIMARY KEY (COD_DEPTO);
ALTER TABLE TB_TURMA ADD CONSTRAINT PK_TB_TURMA PRIMARY KEY (ANO_SEM, COD_DEPTO, NUM_DISC, SIGLA_TUR);   
ALTER TABLE TB_HORARIO ADD CONSTRAINT PK_TB_HORARIO PRIMARY KEY (ANO_SEM, COD_DEPTO, NUM_DISC, SIGLA_TUR, DIA_SEM, HORA_INICIO);   
ALTER TABLE TB_PREDIO ADD CONSTRAINT PK_TB_PREDIO PRIMARY KEY (COD_PRED); 
ALTER TABLE TB_SALA ADD CONSTRAINT PK_TB_SALA PRIMARY KEY (COD_PRED, NUM_SALA); 
ALTER TABLE TB_PROFESSOR ADD CONSTRAINT PK_TB_PROFESSOR PRIMARY KEY (COD_PROF);
ALTER TABLE TB_TITULACAO ADD CONSTRAINT PK_TB_TITULACAO PRIMARY KEY (COD_TIT);   
ALTER TABLE TB_PRE_REQ ADD CONSTRAINT PK_TB_PRE_REQ PRIMARY KEY (COD_DEPTO, NUM_DISC, COD_DEPTO_PRE_REQ, NUM_DISC_PRE_REQ);  
ALTER TABLE TB_PROF_TURMA ADD CONSTRAINT PK_TB_PROF_TURMA PRIMARY KEY (ANO_SEM, COD_DEPTO, NUM_DISC, SIGLA_TUR, COD_PROF); 

/* Adicionar FK nas tabelas */
ALTER TABLE TB_HORARIO ADD CONSTRAINT FK_HORARIO_RELATION_TURMA FOREIGN KEY (ANO_SEM) REFERENCES TB_TURMA (ANO_SEM);
ALTER TABLE TB_HORARIO ADD CONSTRAINT FK_HORARIO_RELATION_SALA FOREIGN KEY (COD_PRED, NUM_SALA) REFERENCES TB_SALA (COD_PRED, NUM_SALA); 
ALTER TABLE TB_SALA ADD CONSTRAINT FK_SALA_RELATION_PREDIO FOREIGN KEY (COD_PRED) REFERENCES TB_PREDIO (COD_PRED); 
ALTER TABLE TB_PROFESSOR ADD CONSTRAINT FK_PROFESSOR_RELATION_DEPTO FOREIGN KEY (COD_DEPTO) REFERENCES TB_DEPTO (COD_DEPTO); 
ALTER TABLE TB_PROFESSOR ADD CONSTRAINT FK_PROFESSOR_RELATION_TITULACAO FOREIGN KEY (COD_TIT) REFERENCES TB_TITULACAO (COD_TIT);
ALTER TABLE TB_PROF_TURMA ADD CONSTRAINT FK_PROFTURMA_RELATION_TURMA FOREIGN KEY (ANO_SEM, COD_DEPTO, NUM_DISC, SIGLA_TUR) REFERENCES TB_TURMA (ANO_SEM, COD_DEPTO, NUM_DISC, SIGLA_TUR); 
ALTER TABLE TB_PROF_TURMA ADD CONSTRAINT FK_PROFTURMA_RELATION_PROFESSOR FOREIGN KEY (COD_PROF) REFERENCES TB_PROFESSOR (COD_PROF);
ALTER TABLE TB_DISCIPLINA ADD CONSTRAINT FK_DISCIPLI_RELATION_DEPTO FOREIGN KEY (COD_DEPTO) REFERENCES TB_DEPTO (COD_DEPTO);
ALTER TABLE TB_PRE_REQ ADD CONSTRAINT FK_PREREQ_TEM_PRE_DISCIPLI FOREIGN KEY (COD_DEPTO_PRE_REQ, NUM_DISC_PRE_REQ) REFERENCES TB_DISCIPLINA (COD_DEPTO, NUM_DISC);
ALTER TABLE TB_PRE_REQ ADD CONSTRAINT FK_PREREQ_EQ_PRE_DISCIPLI FOREIGN KEY (COD_DEPTO, NUM_DISC) REFERENCES TB_DISCIPLINA (COD_DEPTO, NUM_DISC);
ALTER TABLE TB_TURMA ADD CONSTRAINT FK_TURMA_RELATION_DISCIPLI FOREIGN KEY (COD_DEPTO, NUM_DISC) REFERENCES TB_DISCIPLINA (COD_DEPTO, NUM_DISC);

/* Inserir Dados Na Tabela TB_DEPTO */
INSERT INTO TB_DEPTO(COD_DEPTO, NOME_DEPTO) VALUES ('INF01', 'Informática');
INSERT INTO TB_DEPTO(COD_DEPTO, NOME_DEPTO) VALUES ('MAT01', 'Matemática');
INSERT INTO TB_DEPTO(COD_DEPTO, NOME_DEPTO) VALUES ('ELE01', 'Eletrônica');

/* Inserir Dados Na Tabela TB_DISCIPLINA */
INSERT INTO TB_DISCIPLINA(COD_DEPTO, NUM_DISC, NOME_DISC, CREDITO_DISC) VALUES ('INF01', 1, 'LinguProgr', 4);
INSERT INTO TB_DISCIPLINA(COD_DEPTO, NUM_DISC, NOME_DISC, CREDITO_DISC) VALUES ('INF01', 2, 'EstruDados', 4);
INSERT INTO TB_DISCIPLINA(COD_DEPTO, NUM_DISC, NOME_DISC, CREDITO_DISC) VALUES ('INF01', 3, 'BancoDados', 8);
INSERT INTO TB_DISCIPLINA(COD_DEPTO, NUM_DISC, NOME_DISC, CREDITO_DISC) VALUES ('MAT01', 4, 'MatemDiscr', 4);
INSERT INTO TB_DISCIPLINA(COD_DEPTO, NUM_DISC, NOME_DISC, CREDITO_DISC) VALUES ('MAT01', 5, 'FundaCálcu', 6);

/* Inserir Dados Na Tabela TB_PRE_REQ */
INSERT INTO TB_PRE_REQ(COD_DEPTO, NUM_DISC, COD_DEPTO_PRE_REQ, NUM_DISC_PRE_REQ) VALUES ('INF01', 2, 'INF01', 1);
INSERT INTO TB_PRE_REQ(COD_DEPTO, NUM_DISC, COD_DEPTO_PRE_REQ, NUM_DISC_PRE_REQ) VALUES ('MAT01', 5, 'MAT01', 4);
INSERT INTO TB_PRE_REQ(COD_DEPTO, NUM_DISC, COD_DEPTO_PRE_REQ, NUM_DISC_PRE_REQ) VALUES ('INF01', 3, 'INF01', 2);
INSERT INTO TB_PRE_REQ(COD_DEPTO, NUM_DISC, COD_DEPTO_PRE_REQ, NUM_DISC_PRE_REQ) VALUES ('INF01', 3, 'INF01', 1);

/* Inserir Dados Na Tabela TB_TURMA */
INSERT INTO TB_TURMA(ANO_SEM, COD_DEPTO, NUM_DISC, SIGLA_TUR, CAPAC_TUR) VALUES (20021, 'INF01', 1, 'T1', 30);
INSERT INTO TB_TURMA(ANO_SEM, COD_DEPTO, NUM_DISC, SIGLA_TUR, CAPAC_TUR) VALUES (20022, 'INF01', 1, 'T1', 30);
INSERT INTO TB_TURMA(ANO_SEM, COD_DEPTO, NUM_DISC, SIGLA_TUR, CAPAC_TUR) VALUES (20021, 'INF01', 2, 'T2', 30);
INSERT INTO TB_TURMA(ANO_SEM, COD_DEPTO, NUM_DISC, SIGLA_TUR, CAPAC_TUR) VALUES (20022, 'INF01', 3, 'T1', 200);
INSERT INTO TB_TURMA(ANO_SEM, COD_DEPTO, NUM_DISC, SIGLA_TUR, CAPAC_TUR) VALUES (20031, 'INF01', 3, 'T2', 30);
INSERT INTO TB_TURMA(ANO_SEM, COD_DEPTO, NUM_DISC, SIGLA_TUR, CAPAC_TUR) VALUES (20021, 'MAT01', 5, 'T1', 15);
INSERT INTO TB_TURMA(ANO_SEM, COD_DEPTO, NUM_DISC, SIGLA_TUR, CAPAC_TUR) VALUES (20022, 'INF01', 3, 'T2', 25);

/* Inserir Dados Na Tabela TB_PREDIO */
INSERT INTO TB_PREDIO(COD_PRED, NOME_PRED) VALUES (43423, 'Informática-Aulas');
INSERT INTO TB_PREDIO(COD_PRED, NOME_PRED) VALUES (43421, 'Administração');  
INSERT INTO TB_PREDIO(COD_PRED, NOME_PRED) VALUES (43424, 'Laboratórios');

/* Inserir Dados Na Tabela TB_SALA */
INSERT INTO TB_SALA(COD_PRED, NUM_SALA, DESCRICAO_SALA, CAPAC_SALA) VALUES (43423, 101, 'Laboratório Prática', 30);
INSERT INTO TB_SALA(COD_PRED, NUM_SALA, DESCRICAO_SALA, CAPAC_SALA) VALUES (43421, 102, 'Sala Teórica', 50);
INSERT INTO TB_SALA(COD_PRED, NUM_SALA, DESCRICAO_SALA, CAPAC_SALA) VALUES (43424, 215, 'Laboratório Prática', 40);

/* Inserir Dados Na Tabela TB_HORARIO */
INSERT INTO TB_HORARIO(ANO_SEM, COD_DEPTO, NUM_DISC, SIGLA_TUR, DIA_SEM, HORA_INICIO, COD_PRED, NUM_SALA, NUM_HORAS) VALUES (20021,  'INF01',  1,  'T1',  2,  1030,  43423,  101, 60);
INSERT INTO TB_HORARIO(ANO_SEM, COD_DEPTO, NUM_DISC, SIGLA_TUR, DIA_SEM, HORA_INICIO, COD_PRED, NUM_SALA, NUM_HORAS) VALUES (20021,  'INF01',  2,  'T2',  2,  1030,  43423,  101, 60);
INSERT INTO TB_HORARIO(ANO_SEM, COD_DEPTO, NUM_DISC, SIGLA_TUR, DIA_SEM, HORA_INICIO, COD_PRED, NUM_SALA, NUM_HORAS) VALUES (20021,  'INF01',  2,  'T2',  3,  1030,  43423,  101, 60);
INSERT INTO TB_HORARIO(ANO_SEM, COD_DEPTO, NUM_DISC, SIGLA_TUR, DIA_SEM, HORA_INICIO, COD_PRED, NUM_SALA, NUM_HORAS) VALUES (20022,  'INF01',  3,  'T2',  4,  0830,  43424,  215, 45);
INSERT INTO TB_HORARIO(ANO_SEM, COD_DEPTO, NUM_DISC, SIGLA_TUR, DIA_SEM, HORA_INICIO, COD_PRED, NUM_SALA, NUM_HORAS) VALUES (20021,  'INF01',  1,  'T1',  4,  1330,  43423,  101, 60);

/* Inserir Dados Na Tabela TB_TITULACAO */
INSERT INTO TB_TITULACAO(COD_TIT, NOME_TIT) VALUES (1, 'Doutor');
INSERT INTO TB_TITULACAO(COD_TIT, NOME_TIT) VALUES (2, 'Mestre');
INSERT INTO TB_TITULACAO(COD_TIT, NOME_TIT) VALUES (3, 'Especialista');
INSERT INTO TB_TITULACAO(COD_TIT, NOME_TIT) VALUES (4, 'Graduado');

/* Inserir Dados Na Tabela TB_PROFESSOR */
INSERT INTO TB_PROFESSOR(COD_PROF, COD_DEPTO, COD_TIT, NOME_PROF) VALUES (1, 'INF01', 1, 'Antunes');
INSERT INTO TB_PROFESSOR(COD_PROF, COD_DEPTO, COD_TIT, NOME_PROF) VALUES (2, 'INF01', 2, 'Colevati  dos  Santos');
INSERT INTO TB_PROFESSOR(COD_PROF, COD_DEPTO, COD_TIT, NOME_PROF) VALUES (3, 'MAT01', 3, 'Joilson');
INSERT INTO TB_PROFESSOR(COD_PROF, COD_DEPTO, COD_TIT, NOME_PROF) VALUES (4, 'MAT01', 4, 'Wellington');

/* Inserir Dados Na Tabela TB_PROF_TURMA */
INSERT INTO TB_PROF_TURMA(ANO_SEM, COD_DEPTO, NUM_DISC, SIGLA_TUR, COD_PROF) VALUES (20021, 'INF01', 1, 'T1', 1);
INSERT INTO TB_PROF_TURMA(ANO_SEM, COD_DEPTO, NUM_DISC, SIGLA_TUR, COD_PROF) VALUES (20022, 'INF01', 1, 'T1', 1);
INSERT INTO TB_PROF_TURMA(ANO_SEM, COD_DEPTO, NUM_DISC, SIGLA_TUR, COD_PROF) VALUES (20021, 'INF01', 2, 'T2', 1);
INSERT INTO TB_PROF_TURMA(ANO_SEM, COD_DEPTO, NUM_DISC, SIGLA_TUR, COD_PROF) VALUES (20021, 'INF01', 2, 'T2', 2);
INSERT INTO TB_PROF_TURMA(ANO_SEM, COD_DEPTO, NUM_DISC, SIGLA_TUR, COD_PROF) VALUES (20021, 'MAT01', 5, 'T1', 3);
INSERT INTO TB_PROF_TURMA(ANO_SEM, COD_DEPTO, NUM_DISC, SIGLA_TUR, COD_PROF) VALUES (20021, 'MAT01', 5, 'T1', 2);