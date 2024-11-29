-- Criação do banco de dados
CREATE DATABASE Oficina;

USE Oficina;

-- Tabela Cliente
CREATE TABLE Cliente (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    telefone VARCHAR(15),
    email VARCHAR(100),
    endereco VARCHAR(200)
);

-- Tabela Veiculo
CREATE TABLE Veiculo (
    id INT AUTO_INCREMENT PRIMARY KEY,
    cliente_id INT NOT NULL,
    marca VARCHAR(50) NOT NULL,
    modelo VARCHAR(50) NOT NULL,
    placa VARCHAR(10) UNIQUE NOT NULL,
    ano INT NOT NULL,
    FOREIGN KEY (cliente_id) REFERENCES Cliente(id)
);

-- Tabela Funcionario
CREATE TABLE Funcionario (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cargo VARCHAR(50) NOT NULL,
    salario DECIMAL(10,2) NOT NULL,
    data_contratacao DATE NOT NULL
);

-- Tabela Servico
CREATE TABLE Servico (
    id INT AUTO_INCREMENT PRIMARY KEY,
    descricao VARCHAR(200) NOT NULL,
    preco DECIMAL(10,2) NOT NULL
);

-- Tabela Ordem_Servico (OS)
CREATE TABLE Ordem_Servico (
    id INT AUTO_INCREMENT PRIMARY KEY,
    cliente_id INT NOT NULL,
    veiculo_id INT NOT NULL,
    funcionario_id INT NOT NULL,
    data_abertura DATE NOT NULL,
    data_fechamento DATE,
    status ENUM('Aberta', 'Em andamento', 'Concluída') DEFAULT 'Aberta',
    valor_total DECIMAL(10,2),
    FOREIGN KEY (cliente_id) REFERENCES Cliente(id),
    FOREIGN KEY (veiculo_id) REFERENCES Veiculo(id),
    FOREIGN KEY (funcionario_id) REFERENCES Funcionario(id)
);

-- Tabela OS_Servico (Relacionamento N:N entre Ordem_Servico e Servico)
CREATE TABLE OS_Servico (
    id INT AUTO_INCREMENT PRIMARY KEY,
    ordem_servico_id INT NOT NULL,
    servico_id INT NOT NULL,
    quantidade INT NOT NULL,
    preco_total DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (ordem_servico_id) REFERENCES Ordem_Servico(id),
    FOREIGN KEY (servico_id) REFERENCES Servico(id)
);

-- Tabela Pagamento
CREATE TABLE Pagamento (
    id INT AUTO_INCREMENT PRIMARY KEY,
    ordem_servico_id INT NOT NULL,
    forma_pagamento ENUM('Cartão', 'Dinheiro', 'Pix', 'Transferência') NOT NULL,
    valor DECIMAL(10,2) NOT NULL,
    data_pagamento DATE NOT NULL,
    FOREIGN KEY (ordem_servico_id) REFERENCES Ordem_Servico(id)
);

-- Inserção de dados
-- Clientes
INSERT INTO Cliente (nome, telefone, email, endereco)
VALUES 
('João Silva', '11999999999', 'joao@gmail.com', 'Rua A, 123'),
('Maria Oliveira', '11988888888', 'maria@gmail.com', 'Rua B, 456');

-- Veículos
INSERT INTO Veiculo (cliente_id, marca, modelo, placa, ano)
VALUES 
(1, 'Toyota', 'Corolla', 'ABC1234', 2018),
(2, 'Honda', 'Civic', 'DEF5678', 2020);

-- Funcionários
INSERT INTO Funcionario (nome, cargo, salario, data_contratacao)
VALUES 
('Carlos Santos', 'Mecânico', 3500.00, '2023-01-10'),
('Ana Lima', 'Atendente', 2500.00, '2022-06-15');

-- Serviços
INSERT INTO Servico (descricao, preco)
VALUES 
('Troca de óleo', 150.00),
('Alinhamento e balanceamento', 200.00),
('Revisão completa', 500.00);

-- Ordem de Serviço
INSERT INTO Ordem_Servico (cliente_id, veiculo_id, funcionario_id, data_abertura, status, valor_total)
VALUES 
(1, 1, 1, '2024-11-25', 'Aberta', NULL),
(2, 2, 1, '2024-11-26', 'Em andamento', NULL);

-- OS_Servico
INSERT INTO OS_Servico (ordem_servico_id, servico_id, quantidade, preco_total)
VALUES 
(1, 1, 1, 150.00),
(1, 2, 1, 200.00),
(2, 3, 1, 500.00);

-- Pagamentos
INSERT INTO Pagamento (ordem_servico_id, forma_pagamento, valor, data_pagamento)
VALUES 
(1, 'Cartão', 350.00, '2024-11-26');

-- Consultas SQL Complexas

-- 1. Quantas ordens de serviço cada cliente possui?
SELECT c.nome AS cliente, COUNT(os.id) AS total_ordens
FROM Cliente c
LEFT JOIN Ordem_Servico os ON c.id = os.cliente_id
GROUP BY c.id;

-- 2. Qual funcionário realizou o maior número de serviços?
SELECT f.nome AS funcionario, COUNT(os.id) AS total_servicos
FROM Funcionario f
INNER JOIN Ordem_Servico os ON f.id = os.funcionario_id
GROUP BY f.id
ORDER BY total_servicos DESC;

-- 3. Relação de serviços realizados por veículo
SELECT v.placa AS veiculo, s.descricao AS servico, os.data_abertura
FROM Ordem_Servico os
INNER JOIN OS_Servico oss ON os.id = oss.ordem_servico_id
INNER JOIN Servico s ON oss.servico_id = s.id
INNER JOIN Veiculo v ON os.veiculo_id = v.id;

-- 4. Total arrecadado por mês
SELECT DATE_FORMAT(p.data_pagamento, '%Y-%m') AS mes, SUM(p.valor) AS total_arrecadado
FROM Pagamento p
GROUP BY DATE_FORMAT(p.data_pagamento, '%Y-%m');

-- 5. Clientes com veículos que necessitam revisão pendente
SELECT DISTINCT c.nome AS cliente, v.placa AS veiculo
FROM Cliente c
INNER JOIN Veiculo v ON c.id = v.cliente_id
LEFT JOIN Ordem_Servico os ON v.id = os.veiculo_id AND os.status = 'Concluída'
WHERE os.id IS NULL;


