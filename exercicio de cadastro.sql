ALTER DATABASE cadastro
CHARACTER SET = utf8mb4
COLLATE = utf8mb4_general_ci;

USE cadastro;

CREATE TABLE pessoas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    nascimento DATE,
    sexo ENUM('M', 'F'),
    peso DECIMAL(5,2) CHECK (peso > 0),
    altura DECIMAL(3,2) CHECK (altura > 0),
    nacionalidade VARCHAR(50) DEFAULT 'Brasil',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE clientes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    data_cadastro DATE DEFAULT (CURRENT_DATE),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_email (email)
);

CREATE TABLE produtos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    preco DECIMAL(10,2) NOT NULL CHECK (preco >= 0),
    estoque INT DEFAULT 0 CHECK (estoque >= 0),
    disponivel BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_nome (nome),
    INDEX idx_disponivel (disponivel)
);

CREATE TABLE funcionarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    matricula VARCHAR(20) UNIQUE NOT NULL,
    nome_completo VARCHAR(150) NOT NULL,
    cargo VARCHAR(80),
    salario DECIMAL(10,2) CHECK (salario >= 0),
    data_nascimento DATE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_matricula (matricula)
);

CREATE TABLE cursos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT,
    carga_horaria INT NOT NULL CHECK (carga_horaria > 0),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_nome (nome)
);

CREATE TABLE vendas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    cliente_id INT NOT NULL,
    data_venda TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    valor_total DECIMAL(10,2) NOT NULL CHECK (valor_total >= 0),
    forma_pagamento ENUM('dinheiro', 'cartao_debito', 'cartao_credito', 'pix', 'transferencia') NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (cliente_id) REFERENCES clientes(id) ON DELETE RESTRICT,
    INDEX idx_cliente (cliente_id),
    INDEX idx_data_venda (data_venda)
);

CREATE TABLE itens_venda (
    id INT AUTO_INCREMENT PRIMARY KEY,
    venda_id INT NOT NULL,
    produto_id INT NOT NULL,
    quantidade INT NOT NULL CHECK (quantidade > 0),
    preco_unitario DECIMAL(10,2) NOT NULL CHECK (preco_unitario >= 0),
    subtotal DECIMAL(10,2) NOT NULL CHECK (subtotal >= 0),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (venda_id) REFERENCES vendas(id) ON DELETE CASCADE,
    FOREIGN KEY (produto_id) REFERENCES produtos(id) ON DELETE RESTRICT,
    INDEX idx_venda (venda_id),
    INDEX idx_produto (produto_id)
);

INSERT INTO pessoas (nome, nascimento, sexo, peso, altura, nacionalidade) VALUES
('Alisson Silva', '1990-01-05', 'M', 75.5, 1.75, 'Brasil'),
('Beatriz Santos', '1992-02-15', 'F', 62.3, 1.68, 'Brasil'),
('Carlos Oliveira', '1988-03-22', 'M', 80.1, 1.80, 'Brasil'),
('Eduardo Costa', '1995-04-10', 'M', 70.8, 1.72, 'Brasil'),
('Eliana Ferreira', '1987-05-30', 'F', 58.9, 1.65, 'Brasil'),
('Francisco Lima', '1993-06-18', 'M', 68.4, 1.70, 'Brasil'),
('George Almeida', '1991-07-25', 'M', 77.2, 1.78, 'Brasil'),
('Higor Ribeiro', '1989-08-14', 'M', 72.6, 1.74, 'Brasil'),
('Iago Mendes', '1994-09-08', 'M', 74.1, 1.76, 'Brasil'),
('João Pereira', '1986-10-12', 'M', 69.5, 1.71, 'Brasil');

INSERT INTO clientes (nome, email, data_cadastro) VALUES
('Maria José', 'maria.jose@email.com', '2024-01-15'),
('Pedro Henrique', 'pedro.henrique@email.com', '2024-02-20'),
('Ana Carolina', 'ana.carolina@email.com', '2024-03-10'),
('Roberto Silva', 'roberto.silva@email.com', '2024-04-05'),
('Fernanda Lima', 'fernanda.lima@email.com', '2024-05-12');


INSERT INTO produtos (nome, preco, estoque, disponivel) VALUES
('Notebook Dell', 2500.00, 10, TRUE),
('Mouse Wireless', 45.90, 50, TRUE),
('Teclado Mecânico', 189.99, 25, TRUE),
('Monitor 24"', 899.00, 15, TRUE),
('Webcam HD', 120.50, 30, TRUE),
('Fone Bluetooth', 79.90, 0, FALSE);


INSERT INTO funcionarios (matricula, nome_completo, cargo, salario, data_nascimento) VALUES
('FUNC001', 'João Santos Silva', 'Gerente de Vendas', 5500.00, '1985-03-15'),
('FUNC002', 'Maria Oliveira Costa', 'Vendedora', 2800.00, '1992-07-22'),
('FUNC003', 'Carlos Eduardo Lima', 'Técnico em TI', 3200.00, '1988-11-10'),
('FUNC004', 'Ana Paula Ferreira', 'Assistente Administrativo', 2200.00, '1995-05-18'),
('FUNC005', 'Roberto Almeida', 'Estoquista', 1800.00, '1990-12-08');


INSERT INTO cursos (nome, descricao, carga_horaria) VALUES
('HTML5 Completo', 'Curso completo de HTML5 com exemplos práticos', 40),
('Algoritmos e Lógica', 'Fundamentos de lógica de programação', 30),
('Photoshop Avançado', 'Técnicas avançadas de Photoshop CC', 25),
('PHP para Iniciantes', 'Introdução ao desenvolvimento web com PHP', 50),
('Java Fundamentals', 'Fundamentos da linguagem Java', 45),
('MySQL Avançado', 'Administração e otimização de bancos MySQL', 35),
('Word Profissional', 'Uso avançado do Microsoft Word', 20),
('Dança Contemporânea', 'Técnicas de dança contemporânea', 40),
('Culinária Árabe', 'Pratos tradicionais da culinária árabe', 30),
('Marketing Digital', 'Estratégias de marketing para redes sociais', 25);


INSERT INTO vendas (cliente_id, valor_total, forma_pagamento) VALUES
(1, 2545.90, 'cartao_credito'),
(2, 189.99, 'pix'),
(3, 1019.50, 'cartao_debito'),
(4, 79.90, 'dinheiro'),
(5, 899.00, 'transferencia');


INSERT INTO itens_venda (venda_id, produto_id, quantidade, preco_unitario, subtotal) VALUES
(1, 1, 1, 2500.00, 2500.00),
(1, 2, 1, 45.90, 45.90),
(2, 3, 1, 189.99, 189.99),
(3, 4, 1, 899.00, 899.00),
(3, 5, 1, 120.50, 120.50),
(4, 6, 1, 79.90, 79.90),
(5, 4, 1, 899.00, 899.00);

DESCRIBE pessoas;
DESCRIBE clientes;
DESCRIBE produtos;
DESCRIBE funcionarios;
DESCRIBE cursos;
DESCRIBE vendas;
DESCRIBE itens_venda;