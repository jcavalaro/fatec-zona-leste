drop table if exists tb_editora CASCADE;
drop table if exists tb_emprestimo_devolucao CASCADE;
drop table if exists tb_genero CASCADE;
drop table if exists tb_livro CASCADE;
drop table if exists tb_refresh_token CASCADE;
drop table if exists tb_role CASCADE;
drop table if exists tb_usuario CASCADE;
drop table if exists tb_usuario_role CASCADE;

create table tb_editora (
                            id bigint NOT NULL AUTO_INCREMENT primary key,
                            nome varchar(255));

create table tb_emprestimo_devolucao (
                                         id bigint NOT NULL AUTO_INCREMENT primary key,
                                         data_devolucao TIMESTAMP ,
                                         data_emprestimo TIMESTAMP,
                                         situacao varchar(255),
                                         livro_id bigint,
                                         usuario_id bigint);

create table tb_genero (
                           id bigint NOT NULL AUTO_INCREMENT primary key,
                           nome varchar(255));

create table tb_livro (
                          id bigint NOT NULL AUTO_INCREMENT primary key,
                          ano_publicacao TIMESTAMP,
                          autor varchar(255),
                          descricao varchar(255),
                          edicao integer,
                          img_url varchar(255),
                          isbn varchar(255),
                          quantidade integer,
                          status varchar(255),
                          titulo varchar(255),
                          editora_id bigint,
                          genero_id bigint);

create table tb_refresh_token (
                                  id bigint not null,
                                  expiry_date TIMESTAMP not null,
                                  token varchar(255) not null,
                                  usuario_id bigint);

create table tb_role (
                         id bigint NOT NULL AUTO_INCREMENT primary key,
                         autorizacao varchar(255));

create table tb_usuario (
                            id bigint NOT NULL AUTO_INCREMENT primary key,
                            cep varchar(255),
                            cidade varchar(255),
                            complemento varchar(255),
                            cpf varchar(255),
                            email varchar(255),
                            email_alternativo varchar(255),
                            endereco varchar(255),
                            estado varchar(255),
                            nome varchar(255),
                            numero_endereco varchar(255),
                            senha varchar(255),
                            sobrenome varchar(255),
                            telefone varchar(255));

create table tb_usuario_role (
                                 usuario_id bigint not null,
                                 role_id bigint not null);

alter table tb_refresh_token add primary key (id);
alter table tb_usuario_role add primary key (usuario_id, role_id);

alter table tb_editora add constraint UK_3bem15f641duw36d572nxmqof unique (nome);
alter table tb_genero add constraint UK_dd2x15l6td591powhdwepvws2 unique (nome);
alter table tb_refresh_token add constraint UK_i63fy6f7kgr4uk9ndkxe5q8q4 unique (token);
alter table tb_usuario add constraint UK_594wib8ansybtilla48x7vdld unique (cpf);
alter table tb_usuario add constraint UK_spmnyb4dsul95fjmr5kmdmvub unique (email);
alter table tb_usuario add constraint UK_spmnyb4d4533434435kmdmvub unique (email_alternativo);

alter table tb_emprestimo_devolucao add constraint FKgasrwi0qsqfveawvt1atsws3r foreign key (livro_id) references tb_livro(id);
alter table tb_emprestimo_devolucao add constraint FKe3ueryttqbylojb1w3pr877i4 foreign key (usuario_id) references tb_usuario(id);
alter table tb_livro add constraint FKld4mxvtivc86lren384755w5r foreign key (editora_id) references tb_editora(id);
alter table tb_livro add constraint FKpxd9hjiepwc97r5nbhl012tas foreign key (genero_id) references tb_genero(id);
alter table tb_refresh_token add constraint FKsxt8uwpnqfv2976b16g0hrbp4 foreign key (usuario_id) references tb_usuario(id);
alter table tb_usuario_role add constraint FKkix4nwaehqjwnk40e2e36903j foreign key (role_id) references tb_role(id);
alter table tb_usuario_role add constraint FKj4syki71kai6syrfuly9xfcq foreign key (usuario_id) references tb_usuario(id);

INSERT INTO tb_role (autorizacao) values ('ROLE_USUARIO');
INSERT INTO tb_role (autorizacao) values ('ROLE_BIBLIOTECARIO');
INSERT INTO tb_role (autorizacao) values ('ROLE_ADMIN');

INSERT INTO tb_editora (nome) VALUES ('Companhia das Letras');
INSERT INTO tb_editora (nome) VALUES ('Rocco');
INSERT INTO tb_editora (nome) VALUES ('Arqueiro');
INSERT INTO tb_editora (nome) VALUES ('Intrínseca');
INSERT INTO tb_editora (nome) VALUES ('Sextante');
INSERT INTO tb_editora (nome) VALUES ('Ediouro');
INSERT INTO tb_editora (nome) VALUES ('Panda Books');
INSERT INTO tb_editora (nome) VALUES ('Ubu');
INSERT INTO tb_editora (nome) VALUES ('Alta Books');
INSERT INTO tb_editora (nome) VALUES ('Chiado Grupo Editorial');
INSERT INTO tb_editora (nome) VALUES ('Edições Loyola');
INSERT INTO tb_editora (nome) VALUES ('Record');
INSERT INTO tb_editora (nome) VALUES ('Draco');
INSERT INTO tb_editora (nome) VALUES ('Gente');
INSERT INTO tb_editora (nome) VALUES ('Martin Claret');
INSERT INTO tb_editora (nome) VALUES ('Somos Educação');
INSERT INTO tb_editora (nome) VALUES ('Ática');
INSERT INTO tb_editora (nome) VALUES ('Scipione');
INSERT INTO tb_editora (nome) VALUES ('Saraiva');
INSERT INTO tb_editora (nome) VALUES ('Moderna');
INSERT INTO tb_editora (nome) VALUES ('Positivo');
INSERT INTO tb_editora (nome) VALUES ('FTD');
INSERT INTO tb_editora (nome) VALUES ('Artmed');
INSERT INTO tb_editora (nome) VALUES ('Escala');
INSERT INTO tb_editora (nome) VALUES ('Martins Fontes');
INSERT INTO tb_editora (nome) VALUES ('Anglo');
INSERT INTO tb_editora (nome) VALUES ('Atual');
INSERT INTO tb_editora (nome) VALUES ('MacMillan');
INSERT INTO tb_editora (nome) VALUES ('AJS');
INSERT INTO tb_editora (nome) VALUES ('Bookman');
INSERT INTO tb_editora (nome) VALUES ('Pearson Universidades');

INSERT INTO tb_genero (nome) VALUES ('Fantasia');
INSERT INTO tb_genero (nome) VALUES ('Ficção científica');
INSERT INTO tb_genero (nome) VALUES ('Distopia');
INSERT INTO tb_genero (nome) VALUES ('Ação e aventura');
INSERT INTO tb_genero (nome) VALUES ('Ficção Policial');
INSERT INTO tb_genero (nome) VALUES ('Horror');
INSERT INTO tb_genero (nome) VALUES ('Thriller e Suspense');
INSERT INTO tb_genero (nome) VALUES ('Ficção histórica');
INSERT INTO tb_genero (nome) VALUES ('Romance');
INSERT INTO tb_genero (nome) VALUES ('Ficção Feminina');
INSERT INTO tb_genero (nome) VALUES ('Ficção Contemporânea');
INSERT INTO tb_genero (nome) VALUES ('Realismo mágico');
INSERT INTO tb_genero (nome) VALUES ('Graphic Novel');
INSERT INTO tb_genero (nome) VALUES ('Conto');
INSERT INTO tb_genero (nome) VALUES ('Young adult – Jovem adulto');
INSERT INTO tb_genero (nome) VALUES ('New adult – Novo Adulto');
INSERT INTO tb_genero (nome) VALUES ('Infantil');
INSERT INTO tb_genero (nome) VALUES ('Memórias e autobiografia');
INSERT INTO tb_genero (nome) VALUES ('Biografia');
INSERT INTO tb_genero (nome) VALUES ('Gastronomia');
INSERT INTO tb_genero (nome) VALUES ('Arte e Fotografia');
INSERT INTO tb_genero (nome) VALUES ('Autoajuda');
INSERT INTO tb_genero (nome) VALUES ('História');
INSERT INTO tb_genero (nome) VALUES ('Viagem');
INSERT INTO tb_genero (nome) VALUES ('Crimes Reais');
INSERT INTO tb_genero (nome) VALUES ('Humor');
INSERT INTO tb_genero (nome) VALUES ('Ensaios');
INSERT INTO tb_genero (nome) VALUES ('Guias & Como fazer');
INSERT INTO tb_genero (nome) VALUES ('Religião e Espiritualidade');
INSERT INTO tb_genero (nome) VALUES ('Humanidades e Ciências Sociais');
INSERT INTO tb_genero (nome) VALUES ('Paternidade e família');
INSERT INTO tb_genero (nome) VALUES ('Tecnologia e Ciência');