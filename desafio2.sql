-- Criação do banco de dados
CREATE DATABASE ecommerce;
USE ecommerce;

-- Tabela Cliente
CREATE TABLE Cliente (
    idCliente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    tipo ENUM('PF', 'PJ') NOT NULL,
    cpf CHAR(11) UNIQUE,
    cnpj CHAR(14) UNIQUE,
    endereco VARCHAR(255),
    telefone VARCHAR(15),
    email VARCHAR(100)
);

-- Tabela Pedido
CREATE TABLE Pedido (
    idPedido INT AUTO_INCREMENT PRIMARY KEY,
    idCliente INT,
    dataPedido DATE NOT NULL,
    status VARCHAR(50) NOT NULL,
    valorTotal DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (idCliente) REFERENCES Cliente(idCliente)
);

-- Tabela Pagamento
CREATE TABLE Pagamento (
    idPagamento INT AUTO_INCREMENT PRIMARY KEY,
    idPedido INT,
    tipoPagamento ENUM('Cartão', 'Boleto', 'Pix') NOT NULL,
    valor DECIMAL(10, 2) NOT NULL,
    status VARCHAR(50) NOT NULL,
    FOREIGN KEY (idPedido) REFERENCES Pedido(idPedido)
);

-- Tabela Entrega
CREATE TABLE Entrega (
    idEntrega INT AUTO_INCREMENT PRIMARY KEY,
    idPedido INT,
    status VARCHAR(50) NOT NULL,
    codigoRastreio VARCHAR(50) NOT NULL,
    FOREIGN KEY (idPedido) REFERENCES Pedido(idPedido)
);

-- Tabela Produto
CREATE TABLE Produto (
    idProduto INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT,
    preco DECIMAL(10, 2) NOT NULL
);

-- Tabela Fornecedor
CREATE TABLE Fornecedor (
    idFornecedor INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cnpj CHAR(14) UNIQUE NOT NULL,
    contato VARCHAR(100)
);

-- Tabela Estoque
CREATE TABLE Estoque (
    idEstoque INT AUTO_INCREMENT PRIMARY KEY,
    idProduto INT,
    idFornecedor INT,
    quantidade INT NOT NULL,
    FOREIGN KEY (idProduto) REFERENCES Produto(idProduto),
    FOREIGN KEY (idFornecedor) REFERENCES Fornecedor(idFornecedor)
);

-- Tabela Vendedor
CREATE TABLE Vendedor (
    idVendedor INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cnpj CHAR(14) UNIQUE NOT NULL,
    contato VARCHAR(100)
);

-- Tabela Produto_Pedido (Associativa)
CREATE TABLE Produto_Pedido (
    idProduto INT,
    idPedido INT,
    quantidade INT NOT NULL,
    PRIMARY KEY (idProduto, idPedido),
    FOREIGN KEY (idProduto) REFERENCES Produto(idProduto),
    FOREIGN KEY (idPedido) REFERENCES Pedido(idPedido)
);

-- Inserção de dados de teste
INSERT INTO Cliente (nome, tipo, cpf, cnpj, endereco, telefone, email) VALUES
('João Silva', 'PF', '12345678901', NULL, 'Rua A, 123', '11987654321', 'joao@email.com'),
('Empresa XYZ', 'PJ', NULL, '12345678901234', 'Av. B, 456', '11987654322', 'xyz@empresa.com');

INSERT INTO Pedido (idCliente, dataPedido, status, valorTotal) VALUES
(1, '2023-10-01', 'Em andamento', 150.00),
(2, '2023-10-02', 'Entregue', 300.00);

INSERT INTO Pagamento (idPedido, tipoPagamento, valor, status) VALUES
(1, 'Cartão', 150.00, 'Aprovado'),
(2, 'Boleto', 300.00, 'Pendente');

INSERT INTO Entrega (idPedido, status, codigoRastreio) VALUES
(1, 'Em trânsito', 'ABC123'),
(2, 'Entregue', 'XYZ456');

INSERT INTO Produto (nome, descricao, preco) VALUES
('Notebook', 'Notebook 16GB RAM, 512GB SSD', 3500.00),
('Smartphone', 'Smartphone 128GB, 6.5"', 2000.00);

INSERT INTO Fornecedor (nome, cnpj, contato) VALUES
('Fornecedor A', '11111111111111', 'fornecedorA@email.com'),
('Fornecedor B', '22222222222222', 'fornecedorB@email.com');

INSERT INTO Estoque (idProduto, idFornecedor, quantidade) VALUES
(1, 1, 10),
(2, 2, 20);

INSERT INTO Vendedor (nome, cnpj, contato) VALUES
('Vendedor X', '33333333333333', 'vendedorX@email.com'),
('Vendedor Y', '44444444444444', 'vendedorY@email.com');

INSERT INTO Produto_Pedido (idProduto, idPedido, quantidade) VALUES
(1, 1, 1),
(2, 2, 2);

-- Queries complexas
-- 1. Recuperações simples com SELECT Statement
SELECT * FROM Cliente;
SELECT * FROM Produto;

-- 2. Filtros com WHERE Statement
SELECT * FROM Pedido WHERE status = 'Em andamento';
SELECT * FROM Produto WHERE preco > 100;

-- 3. Expressões para gerar atributos derivados
SELECT idPedido, valorTotal, valorTotal * 0.9 AS valorComDesconto FROM Pedido;

-- 4. Ordenações com ORDER BY
SELECT * FROM Produto ORDER BY preco ASC;
SELECT * FROM Pedido ORDER BY dataPedido DESC;

-- 5. Filtros com HAVING
SELECT idCliente, COUNT(idPedido) AS totalPedidos FROM Pedido GROUP BY idCliente HAVING totalPedidos > 1;

-- 6. Junções entre tabelas
SELECT p.idPedido, p.dataPedido, p.status, c.nome AS nomeCliente FROM Pedido p INNER JOIN Cliente c ON p.idCliente = c.idCliente;
SELECT pr.nome AS nomeProduto, f.nome AS nomeFornecedor FROM Produto pr INNER JOIN Estoque e ON pr.idProduto = e.idProduto INNER JOIN Fornecedor f ON e.idFornecedor = f.idFornecedor;

-- Perguntas e respostas
-- 1. Quantos pedidos foram feitos por cada cliente?
SELECT c.nome, COUNT(p.idPedido) AS totalPedidos FROM Cliente c LEFT JOIN Pedido p ON c.idCliente = p.idCliente GROUP BY c.idCliente;

-- 2. Algum vendedor também é fornecedor?
SELECT v.nome AS nomeVendedor, f.nome AS nomeFornecedor FROM Vendedor v INNER JOIN Fornecedor f ON v.cnpj = f.cnpj;

-- 3. Relação de produtos, fornecedores e estoques
SELECT pr.nome AS nomeProduto, f.nome AS nomeFornecedor, e.quantidade FROM Produto pr INNER JOIN Estoque e ON pr.idProduto = e.idProduto INNER JOIN Fornecedor f ON e.idFornecedor = f.idFornecedor;

-- 4. Relação de nomes dos fornecedores e nomes dos produtos
SELECT f.nome AS nomeFornecedor, pr.nome AS nomeProduto FROM Fornecedor f INNER JOIN Estoque e ON f.idFornecedor = e.idFornecedor INNER JOIN Produto pr ON e.idProduto = pr.idProduto;