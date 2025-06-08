-- Criar o banco de dados
CREATE DATABASE Escola;
USE Escola;

-- Criar tabela de Cursos
CREATE TABLE Cursos (
    id_curso INT PRIMARY KEY AUTO_INCREMENT,
    nome_curso VARCHAR(100) NOT NULL
);

-- Criar tabela de Alunos com chave estrangeira para Cursos
CREATE TABLE Alunos (
    id_aluno INT PRIMARY KEY AUTO_INCREMENT,
    nome_aluno VARCHAR(100) NOT NULL,
    idade INT,
    id_curso INT,
    FOREIGN KEY (id_curso) REFERENCES Cursos(id_curso)
);

-- Inserir dados na tabela Cursos
INSERT INTO Cursos (nome_curso) VALUES
('Matemática'),
('História'),
('Informática');

-- Inserir dados na tabela Alunos
INSERT INTO Alunos (nome_aluno, idade, id_curso) VALUES
('Ana Silva', 17, 1),
('Carlos Souza', 18, 3),
('Mariana Lima', 16, 2),
('João Pedro', 17, 1);

-- Consulta 1: Listar todos os alunos com o nome do curso
SELECT 
    Alunos.nome_aluno, 
    Alunos.idade, 
    Cursos.nome_curso
FROM 
    Alunos
JOIN 
    Cursos ON Alunos.id_curso = Cursos.id_curso;

-- Consulta 2: Ver cursos e a quantidade de alunos matriculados
SELECT 
    Cursos.nome_curso, 
    COUNT(Alunos.id_aluno) AS total_alunos
FROM 
    Cursos
LEFT JOIN 
    Alunos ON Cursos.id_curso = Alunos.id_curso
GROUP BY 
    Cursos.nome_curso;

-- Consulta 3: Buscar todos os alunos do curso de Matemática
SELECT 
    nome_aluno 
FROM 
    Alunos 
WHERE 
    id_curso = (SELECT id_curso FROM Cursos WHERE nome_curso = 'Matemática');
