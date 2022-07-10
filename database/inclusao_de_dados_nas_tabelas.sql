use db_faculdade;

INSERT INTO departamento (nome_departamento)
VALUES
('Ciências Humanas'),
('Matemática'),
('Biológicas'),
('Estágio');

SELECT * FROM departamento;

INSERT INTO professor 
(nome_professor, sobrenome_professor, status_prof, cod_departamento)
VALUES
('Fábio', 'dos Reis', 0, 2),
('Sophie', 'Allemand', 1, 1),
('Monica', 'Barroso', 1, 3);

SELECT * FROM professor;

INSERT INTO curso 
(nome_curso, cod_departamento)
VALUES
('Matemática', 2),
('Psicologia', 1),
('Análise de Sistemas', 2),
('Biologia', 3),
('História', 1),
('Engenharia', 2);

SELECT * FROM curso;

INSERT INTO turma
(cod_curso, periodo, num_alunos, data_inicio, data_fim)
VALUES
(2, 'Manhã', 20, '2016-05-12', '2017-10-15'),
(1, 'Noite', 10, '2014-05-12', '2020-03-05'),
(3, 'Tarde', 15, '2012-05-12', '2014-05-10');

SELECT * FROM turma;

INSERT INTO disciplina
(nome_disciplina, cod_departamento, carga_horaria, descricao, num_alunos)
VALUES
('Raciocínio Lógico', 2, 1200, 'Desenvolver o raciocínio lógico', 50),
('Psicologia Cognitiva', 1, 1400, 'Entender o funcionamento do aprendizado', 30),
('Programação em C', 2, 1200, 'Aprender uma linguagem de programação', 20),
('Eletrônica Digital', 2, 300, 'Funcionamento de circuitos digitais', 30);

SELECT * FROM disciplina;

INSERT INTO aluno
(nome_aluno, sobrenome_aluno, cpf, status_aluno, cod_turma, sexo, cod_curso, nome_pai, nome_mae, email, whatsapp)
VALUES
('Marcos', 'Aurélio Martins', 11111111111, 1, 2, 'M', 3, 'Marcio Aurélio', 'Maria Aparecida', 'marcosaurelio@gmail.com', 911111111),
('Gabriel', 'Fernando de Almeida', 22222222222, 1, 1, 'M', 1, 'Adão Almeida', 'Fernanda Almeida', 'gabrielalmeida@yahoo.com', 922222222),
('Beatriz', 'Sonia Meneguel', '33333333333', 1, 3, 'F', 3, 'Samuel Meneguel', 'Gabriella Meneguel', 'beatrizmene@hotmail.com', 933333333),
('Jorge', 'Soares', 44444444444, 1, 3, 'M', 4, 'João Soares', 'Maria Richter', 'jorgesoares@ig.com', 944444444),
('Ana Paula', 'Ferretti', 55555555555, 1, 3, 'F', 5, 'Marcio Ferretti', 'Ana Hoffbahn', 'anapaulaferretti@uol.com', 944444444),
('Monica', 'Yamaguti', 66666666666, 1, 2, 'F', 6, 'Wilson Oliveira', 'Fernanda Yamaguti', 'monyamaguti@outlook.com', 955555555);

SELECT * FROM aluno;

INSERT INTO aluno_disciplina
(ra, cod_disciplina)
VALUES
(3, 1),
(1, 2),
(2, 3),
(4, 3), 
(5, 4), 
(6, 1);

SELECT * FROM aluno_disciplina;

INSERT INTO curso_disciplina
(cod_curso, cod_disciplina)
VALUES
(1, 1),
(2, 2),
(3, 3),
(6, 4);

SELECT * FROM curso_disciplina;

INSERT INTO prof_disciplina
(cod_professor, cod_disciplina)
VALUES
(2, 1),
(1, 2),
(3, 3),
(2, 4);

SELECT * FROM prof_disciplina;

INSERT INTO historico
(ra, data_inicio, data_fim)
VALUES
(2, '2016-05-12', '2017-10-15'),
(3, '2014-05-12', '2020-03-05'),
(1, '2010-05-12', '2012-05-10');

SELECT * FROM historico;

INSERT INTO tipo_logradouro
(tipo_logradouro)
VALUES
('Rua'),
('Avenida'),
('Alameda'),
('Travessa');

SELECT * FROM tipo_logradouro;

INSERT INTO endereco_aluno
(ra, cod_tipo_logradouro, nome_rua, num_rua, complemento, cep)
VALUES
(2, 1, 'das Giestas', 255, 'Casa 02', 02854000),
(3, 3, 'Lorena', 10, 'Apto 15', 02945000),
(1, 2, 'do Cursino', 1248, '', 02851400),
(4, 1, 'das Heras', 495, '', 03563142),
(5, 3, 'Santos', 1856, '', 04523963),
(6, 4, 'Matão', 206, '', 04213650);

SELECT * FROM endereco_aluno;

INSERT INTO hist_disciplina
(cod_historico, cod_disciplina, nota, frequencia)
VALUES
(1, 2, 7, 6),
(2, 3, 8.5, 2),
(3, 1, 6.8, 8);

SELECT * FROM hist_disciplina;

INSERT INTO tipo_telefone
(tipo_telefone)
VALUES
('Res'),
('Come'),
('Cel'),
('Rec');

SELECT * FROM tipo_telefone;

INSERT INTO telefones_aluno
(ra, cod_tipo_telefone, num_telefone)
VALUES
(1, 1, 35710001),
(2, 1, 35725047),
(2, 3, 944552211),
(3, 1, 35715634),
(3, 3, 988887777),
(4, 1, 35418697),
(4, 3, 966331122),
(5, 1, 35692424);

SELECT * FROM telefones_aluno;

