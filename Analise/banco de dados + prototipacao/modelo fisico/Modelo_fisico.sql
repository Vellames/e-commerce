drop database comtronic_ecommerce;

create database comtronic_ecommerce;

use comtronic_ecommerce;

CREATE TABLE categoria (
  id INTEGER NOT NULL AUTO_INCREMENT,
  ativo BOOL NULL,
  nome VARCHAR(20) NULL,
  PRIMARY KEY(id)
);

CREATE TABLE endereco (
  id INTEGER NOT NULL AUTO_INCREMENT,
  id_usuario INTEGER NOT NULL,
  cep CHAR(8) NULL,
  nome VARCHAR(50) NULL,
  tipo_endereco VARCHAR(20) NULL,
  complemento TEXT NULL,
  numero VARCHAR(10) NULL,
  PRIMARY KEY(id),
  INDEX endereco_FKIndex1(id_usuario)
);

CREATE TABLE endereco_venda (
  id INTEGER NOT NULL AUTO_INCREMENT,
  id_pedido INTEGER NOT NULL,
  cep CHAR(8) NULL,
  tipo_endereco VARCHAR(50) NULL,
  complemento TEXT NULL,
  numero VARCHAR(10) NULL,
  PRIMARY KEY(id),
  INDEX endereco_venda_FKIndex1(id_pedido)
);

CREATE TABLE marca (
  id INTEGER NOT NULL AUTO_INCREMENT,
  ativo BOOL NULL,
  nome VARCHAR(20) NULL,
  PRIMARY KEY(id)
);

CREATE TABLE operadora (
  id INTEGER NOT NULL AUTO_INCREMENT,
  nome VARCHAR(10) NULL,
  PRIMARY KEY(id)
);

CREATE TABLE pagamento (
  id INTEGER NOT NULL AUTO_INCREMENT,
  ativo BOOL NULL,
  nome VARCHAR(20) NULL,
  PRIMARY KEY(id)
);

CREATE TABLE pedido (
  id INTEGER NOT NULL AUTO_INCREMENT,
  id_usuario INTEGER NOT NULL,
  estado CHAR NULL,
  frete FLOAT NULL,
  data_hora DATETIME NULL,
  PRIMARY KEY(id),
  INDEX pedido_FKIndex1(id_usuario)
);

CREATE TABLE pedido_has_pagamento (
  id_pedido INTEGER NOT NULL,
  id_pagamento INTEGER NOT NULL,
  valor DOUBLE NULL,
  PRIMARY KEY(id_pedido, id_pagamento),
  INDEX pedido_has_pagamento_FKIndex1(id_pedido),
  INDEX pedido_has_pagamento_FKIndex2(id_pagamento)
);

CREATE TABLE pedido_has_produto (
  id_pedido INTEGER NOT NULL,
  id_produto INTEGER NOT NULL,
  quantidade INTEGER NULL,
  valor_unitario DOUBLE NULL,
  PRIMARY KEY(id_pedido, id_produto),
  INDEX pedido_has_produto_FKIndex1(id_pedido),
  INDEX pedido_has_produto_FKIndex2(id_produto)
);

CREATE TABLE perfil (
  id INTEGER NOT NULL AUTO_INCREMENT,
  nome VARCHAR(20) NULL,
  ativo BOOL NULL,
  PRIMARY KEY(id)
);

CREATE TABLE permissoes (
  id INTEGER NOT NULL AUTO_INCREMENT,
  id_perfil INTEGER NOT NULL,
  classe VARCHAR(20) NULL,
  permitir BOOL NULL,
  acao VARCHAR(20) NULL,
  PRIMARY KEY(id),
  INDEX permissoes_FKIndex1(id_perfil)
);

CREATE TABLE produto (
  id INTEGER NOT NULL AUTO_INCREMENT,
  id_categoria INTEGER NOT NULL,
  id_marca INTEGER NOT NULL,
  ativo BOOL NULL,
  quantidade INTEGER NULL,
  nome VARCHAR(50) NULL,
  PRIMARY KEY(id),
  INDEX produto_FKIndex1(id_marca),
  INDEX produto_FKIndex2(id_categoria)
);

CREATE TABLE telefone (
  id INTEGER NOT NULL AUTO_INCREMENT,
  id_usuario INTEGER NOT NULL,
  id_operadora INTEGER NOT NULL,
  id_tipo_telefone INTEGER NOT NULL,
  numero VARCHAR(15) NULL,
  PRIMARY KEY(id),
  INDEX telefone_FKIndex1(id_tipo_telefone),
  INDEX telefone_FKIndex2(id_operadora),
  INDEX telefone_FKIndex3(id_usuario)
);

CREATE TABLE tipo_telefone (
  id INTEGER NOT NULL AUTO_INCREMENT,
  nome VARCHAR(10) NULL,
  PRIMARY KEY(id)
);

CREATE TABLE usuario (
  id INTEGER NOT NULL AUTO_INCREMENT,
  id_perfil INTEGER NOT NULL,
  nome_completo VARCHAR(100) NULL,
  email VARCHAR(100) NULL,
  cpf CHAR(11) NULL,
  data_nascimento DATE NULL,
  sexo CHAR(1) NULL,
  PRIMARY KEY(id),
  INDEX usuario_FKIndex1(id_perfil)
);


CREATE VIEW v_usuario_perfil AS SELECT usuario.id,id_perfil,nome_completo,email,cpf,data_nascimento,sexo,nome,ativo FROM usuario
INNER JOIN perfil
ON perfil.id = usuario.id_perfil;
