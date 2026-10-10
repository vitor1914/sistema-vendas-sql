PRAGMA foreign_keys=OFF;
BEGIN TRANSACTION;
CREATE TABLE clientes (
    id_cliente INTEGER PRIMARY KEY,
    nome TEXT NOT NULL,
    email TEXT UNIQUE,
    telefone TEXT,
    cidade TEXT,
    estado TEXT,
    data_cadastro TEXT NOT NULL DEFAULT (date('now')),
    ativo INTEGER NOT NULL DEFAULT 1 CHECK (ativo IN (0, 1))
);
INSERT INTO clientes VALUES(1,'João Silva','joao@email.com','61999990001','Brasília','DF','2026-10-10',1);
INSERT INTO clientes VALUES(2,'Maria Santos','maria@email.com','61999990002','Goiânia','GO','2026-10-10',1);
INSERT INTO clientes VALUES(3,'Pedro Oliveira','pedro@email.com','61999990003','Anápolis','GO','2026-10-10',1);
CREATE TABLE categorias (
    id_categoria INTEGER PRIMARY KEY,
    nome TEXT NOT NULL UNIQUE,
    descricao TEXT
);
INSERT INTO categorias VALUES(1,'Informática','Computadores e acessórios');
INSERT INTO categorias VALUES(2,'Periféricos','Teclados, mouses e acessórios');
INSERT INTO categorias VALUES(3,'Móveis','Móveis para escritório');
CREATE TABLE produtos (
    id_produto INTEGER PRIMARY KEY,
    sku TEXT NOT NULL UNIQUE,
    nome TEXT NOT NULL,
    id_categoria INTEGER NOT NULL,
    preco_custo_centavos INTEGER NOT NULL CHECK (preco_custo_centavos >= 0),
    preco_venda_centavos INTEGER NOT NULL CHECK (preco_venda_centavos >= 0),
    estoque_atual INTEGER NOT NULL DEFAULT 0 CHECK (estoque_atual >= 0),
    estoque_minimo INTEGER NOT NULL DEFAULT 5 CHECK (estoque_minimo >= 0),
    ativo INTEGER NOT NULL DEFAULT 1 CHECK (ativo IN (0, 1)),
    FOREIGN KEY (id_categoria) REFERENCES categorias(id_categoria)
);
INSERT INTO produtos VALUES(1,'INF001','Notebook',1,250000,350000,10,2,1);
INSERT INTO produtos VALUES(2,'INF002','Monitor 24 polegadas',1,45000,75000,8,3,1);
INSERT INTO produtos VALUES(3,'PER001','Mouse USB',2,1500,3500,30,5,1);
INSERT INTO produtos VALUES(4,'PER002','Teclado USB',2,3000,6500,20,5,1);
INSERT INTO produtos VALUES(5,'MOV001','Cadeira de escritório',3,18000,32000,6,2,1);
CREATE TABLE pedidos (
    id_pedido INTEGER PRIMARY KEY,
    id_cliente INTEGER NOT NULL,
    data_pedido TEXT NOT NULL DEFAULT (datetime('now')),
    status TEXT NOT NULL DEFAULT 'PENDENTE'
        CHECK (status IN ('PENDENTE', 'CONFIRMADO', 'CANCELADO')),
    desconto_centavos INTEGER NOT NULL DEFAULT 0 CHECK (desconto_centavos >= 0),
    observacao TEXT,
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
);
CREATE TABLE itens_pedido (
    id_item INTEGER PRIMARY KEY,
    id_pedido INTEGER NOT NULL,
    id_produto INTEGER NOT NULL,
    quantidade INTEGER NOT NULL CHECK (quantidade > 0),
    preco_unitario_centavos INTEGER NOT NULL CHECK (preco_unitario_centavos >= 0),
    desconto_unitario_centavos INTEGER NOT NULL DEFAULT 0
        CHECK (desconto_unitario_centavos BETWEEN 0 AND preco_unitario_centavos),
    FOREIGN KEY (id_pedido) REFERENCES pedidos(id_pedido),
    FOREIGN KEY (id_produto) REFERENCES produtos(id_produto),
    UNIQUE (id_pedido, id_produto)
);
CREATE TABLE pagamentos (
    id_pagamento INTEGER PRIMARY KEY,
    id_pedido INTEGER NOT NULL,
    data_pagamento TEXT,
    forma_pagamento TEXT NOT NULL
        CHECK (forma_pagamento IN ('PIX', 'DINHEIRO', 'CREDITO', 'DEBITO', 'BOLETO')),
    valor_centavos INTEGER NOT NULL CHECK (valor_centavos > 0),
    status TEXT NOT NULL DEFAULT 'PENDENTE'
        CHECK (status IN ('PENDENTE', 'PAGO', 'ESTORNADO')),
    FOREIGN KEY (id_pedido) REFERENCES pedidos(id_pedido)
);
CREATE TABLE movimentacoes_estoque (
    id_movimentacao INTEGER PRIMARY KEY,
    id_produto INTEGER NOT NULL,
    data_movimentacao TEXT NOT NULL DEFAULT (datetime('now')),
    tipo TEXT NOT NULL CHECK (tipo IN ('ENTRADA', 'SAIDA')),
    quantidade INTEGER NOT NULL CHECK (quantidade > 0),
    motivo TEXT NOT NULL,
    id_pedido INTEGER,
    FOREIGN KEY (id_produto) REFERENCES produtos(id_produto),
    FOREIGN KEY (id_pedido) REFERENCES pedidos(id_pedido)
);
CREATE INDEX idx_pedidos_data ON pedidos(data_pedido);
CREATE INDEX idx_pedidos_cliente ON pedidos(id_cliente);
CREATE INDEX idx_itens_pedido ON itens_pedido(id_pedido);
CREATE INDEX idx_itens_produto ON itens_pedido(id_produto);
CREATE INDEX idx_pagamentos_pedido ON pagamentos(id_pedido);
CREATE INDEX idx_movimentacoes_produto ON movimentacoes_estoque(id_produto);
COMMIT;
