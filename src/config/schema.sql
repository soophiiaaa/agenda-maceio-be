CREATE TABLE categoria (
	id VARCHAR(36) PRIMARY KEY,
    nome VARCHAR(100) NOT NULL
);

CREATE TABLE usuario (
	id VARCHAR(36) PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    senha VARCHAR(255) NOT NULL,
    localizacao VARCHAR(255) NOT NULL,
    tipo ENUM('administrador', 'comum') NOT NULL DEFAULT 'comum'
);

CREATE TABLE evento (
	id VARCHAR(36) PRIMARY KEY,
    id_categoria VARCHAR(36) NOT NULL,
    nome VARCHAR(255) NOT NULL,
    descricao TEXT,
    data DATETIME NOT NULL,
    localizacao VARCHAR(255),
    pago BOOLEAN DEFAULT FALSE,
    valor DECIMAL(10, 2) DEFAULT 0.00,
    
    CONSTRAINT fk_categoria_evento FOREIGN KEY (id_categoria) REFERENCES categoria(id) ON DELETE CASCADE
);

CREATE TABLE favorito (
	id VARCHAR(36) PRIMARY KEY,
    id_usuario VARCHAR(36) NOT NULL,
    id_evento VARCHAR(36) NOT NULL,
    
    CONSTRAINT fk_usuario_favorito FOREIGN KEY (id_usuario) REFERENCES usuario(id) ON DELETE CASCADE,
    CONSTRAINT fk_evento_favorito FOREIGN KEY (id_evento) REFERENCES evento(id) ON DELETE CASCADE
);

CREATE TABLE ingresso (
	id VARCHAR(36) PRIMARY KEY,
    id_evento VARCHAR(36) NOT NULL,
    titulo VARCHAR(100) NOT NULL,
    valor DECIMAL(10, 2) NOT NULL,
    quantidade_disponivel INT NOT NULL,
    
    CONSTRAINT fk_evento_ingresso FOREIGN KEY (id_evento) REFERENCES evento(id) ON DELETE CASCADE
);

CREATE TABLE compra (
	id VARCHAR(36) PRIMARY KEY,
    id_usuario VARCHAR(36) NOT NULL,
    id_ingresso VARCHAR(36) NOT NULL,
    valor_total DECIMAL(10, 2) NOT NULL,
    quantidade INT NOT NULL,
    forma_pagamento VARCHAR(50),
    data_compra DATETIME DEFAULT CURRENT_TIMESTAMP,
    
    CONSTRAINT fk_usuario_compra FOREIGN KEY (id_usuario) REFERENCES usuario(id),
    CONSTRAINT fk_ingresso_compra FOREIGN KEY (id_ingresso) REFERENCES ingresso(id)
);
