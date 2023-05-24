-- Verificar se o banco de dados "uvv" já existe, se existir, então eu devo excluir.

DROP DATABASE IF EXISTS uvv;

-- Verificar se o cargo "gustavo_schade" já existe, se existir, então eu devo excluir.

DROP ROLE IF EXISTS gustavo_schade;

-- Depois, criar o usuário "gustavo_schade".

CREATE USER gustavo_schade
  WITH       = CREATEDB
  CREATEROLE = ENCRYPTED
  PASSWORD   = 'psetuvv'

-- Depois, criar o banco de dados.

CREATE DATABASE uvv 
  OWNER             =  gustavo_schade
  TEMPLATE          =  template0;
  ENCODING          = 'UTF8'
  LC_COLLATE        = 'pt_BR.UTF-8'
  LC_CTYPE          = 'pt_BR.UTF-8'
  ALLOW_CONNECTIONS =  true

-- Depois, dar permissão de acesso ao banco de dados.

\c uvv gustavo_schade;

-- Criar o schema.

CREATE SCHEMA lojas;

-- Criar a tabela "produtos". 

CREATE TABLE lojas.produtos (
  produto_id                NUMERIC(38)  NOT NULL,
  nome                      VARCHAR(255) NOT NULL,
  preco_unitario            NUMERIC(10,2),
  detalhes                  BYTEA,
  imagem                    BYTEA,
  imagem_mime_type          VARCHAR(512),
  imagem_arquivo            VARCHAR(512),
  imagem_charset            VARCHAR(512),
  imagem_ultima_atualizacao DATE,
  CONSTRAINT   produto_id 
  PRIMARY KEY (produto_id),
  CONSTRAINT check_preco_unitario 
  CHECK (preco_unitario >= 0)
);

COMMENT ON TABLE  lojas.produtos                           IS 'Criar a tabela "produtos".';
COMMENT ON COLUMN lojas.produtos.produto_id                IS 'Criar a coluna "produto_id", na qual ela é a Primary Key.';
COMMENT ON COLUMN lojas.produtos.nome                      IS 'Criar a coluna "nome".';
COMMENT ON COLUMN lojas.produtos.preco_unitario            IS 'Criar a coluna "preco_unitario".';
COMMENT ON COLUMN lojas.produtos.detalhes                  IS 'Criar a coluna "detalhes".';
COMMENT ON COLUMN lojas.produtos.imagem                    IS 'Criar a coluna "imagem".';
COMMENT ON COLUMN lojas.produtos.imagem_mime_type          IS 'Criar a coluna "imagem_mime_type".';
COMMENT ON COLUMN lojas.produtos.imagem_arquivo            IS 'Criar a coluna "imagem_arquivo".';
COMMENT ON COLUMN lojas.produtos.imagem_charset            IS 'Criar a coluna "imagem_charset".';
COMMENT ON COLUMN lojas.produtos.imagem_ultima_atualizacao IS 'Criar a coluna "imagem_ultima_atualizacao".';

-- Criar a tabela "lojas".

CREATE TABLE lojas.lojas (
  loja_id                 NUMERIC(38)  NOT NULL,
  nome                    VARCHAR(255) NOT NULL,
  endereco_web            VARCHAR(100),
  endereco_fisico         VARCHAR(512),
  latitude                NUMERIC,
  longitude               NUMERIC,
  logo                    BYTEA,
  logo_mime_type          VARCHAR(512),
  logo_arquivo            VARCHAR(512),
  logo_charset            VARCHAR(512),
  logo_ultima_atualizacao DATE,
  CONSTRAINT   loja_id     
  PRIMARY KEY (loja_id)
);
COMMENT ON TABLE  lojas.lojas                         IS 'Criar a tabela "lojas".';
COMMENT ON COLUMN lojas.lojas.loja_id                 IS 'Criar a coluna "loja_id", na qual ela é a Primary Key.';
COMMENT ON COLUMN lojas.lojas.nome                    IS 'Criar a coluna "nome".';
COMMENT ON COLUMN lojas.lojas.endereco_web            IS 'Criar a coluna "endereco_web".';
COMMENT ON COLUMN lojas.lojas.endereco_fisico         IS 'Criar a coluna "endereco_fisico".';
COMMENT ON COLUMN lojas.lojas.latitude                IS 'Criar a coluna "latitude".';
COMMENT ON COLUMN lojas.lojas.longitude               IS 'Criar a coluna "longitude".';
COMMENT ON COLUMN lojas.lojas.logo                    IS 'Criar a coluna "logo".';
COMMENT ON COLUMN lojas.lojas.logo_mime_type          IS 'Criar a coluna "logo_mime_type".';
COMMENT ON COLUMN lojas.lojas.logo_arquivo            IS 'Criar a coluna "logo_arquivo".';
COMMENT ON COLUMN lojas.lojas.logo_charset            IS 'Criar a coluna "logo_charset".';
COMMENT ON COLUMN lojas.lojas.logo_ultima_atualizacao IS 'Criar a coluna "logo_ultima_atualizacao".';

-- Criar a tabela "estoques".

CREATE TABLE lojas.estoques (
  estoque_id NUMERIC(38) NOT NULL,
  loja_id    NUMERIC(38) NOT NULL,
  produto_id NUMERIC(38) NOT NULL,
  quantidade NUMERIC(38) NOT NULL,
  CONSTRAINT   estoque_id  
  PRIMARY KEY (estoque_id)
);
COMMENT ON TABLE  lojas.estoques            IS 'Criar a tabela "estoques".';
COMMENT ON COLUMN lojas.estoques.estoque_id IS 'Criar a coluna "estoque_id", na qual ela é a Primary Key.';
COMMENT ON COLUMN lojas.estoques.loja_id    IS 'Criar a coluna "loja_id", na qual é uma FK.';
COMMENT ON COLUMN lojas.estoques.produto_id IS 'Criar a coluna "produto_id", na qual é uma FK.';
COMMENT ON COLUMN lojas.estoques.quantidade IS 'Criar a coluna "quantidade".';

-- Aqui estão as Foreign Keys (FK) da tabela "estoques".

ALTER TABLE    lojas.estoques 
ADD CONSTRAINT lojas_estoques_fk
FOREIGN KEY    (loja_id)
REFERENCES     lojas.lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE    lojas.estoques 
ADD CONSTRAINT produtos_estoques_fk
FOREIGN KEY    (produto_id)
REFERENCES     lojas.produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- Criar a tabela "clientes".

CREATE TABLE lojas.clientes (
  cliente_id NUMERIC(38)  NOT NULL,
  email      VARCHAR(255) NOT NULL,
  nome       VARCHAR(255) NOT NULL,
  telefone1  VARCHAR(20),
  telefone2  VARCHAR(20),
  telefone3  VARCHAR(20),
  CONSTRAINT   cliente_id 
  PRIMARY KEY (cliente_id)
);
COMMENT ON TABLE  lojas.clientes            IS 'Criar a tabela "clientes".';
COMMENT ON COLUMN lojas.clientes.cliente_id IS 'Criar a coluna "cliente_id", na qual ela é a Primary Key.';
COMMENT ON COLUMN lojas.clientes.email      IS 'Criar a coluna "email".';
COMMENT ON COLUMN lojas.clientes.nome       IS 'Criar a coluna "nome".';
COMMENT ON COLUMN lojas.clientes.telefone1  IS 'Criar a tabela "telefone1".';
COMMENT ON COLUMN lojas.clientes.telefone2  IS 'Criar a coluna "telefone2".';
COMMENT ON COLUMN lojas.clientes.telefone3  IS 'Criar a coluna "telefone3".';

-- Criar a tabela "envios".

CREATE TABLE lojas.envios (
  envio_id         NUMERIC(38)  NOT NULL,
  loja_id          NUMERIC(38)  NOT NULL,
  cliente_id       NUMERIC(38)  NOT NULL,
  endereco_entrega VARCHAR(512) NOT NULL,
  status           VARCHAR(15)  NOT NULL,
  CONSTRAINT   envio_id 
  PRIMARY KEY (envio_id),
  CONSTRAINT check_status 
  CHECK (status IN ('CRIADO', 'ENVIADO', 'TRANSITO', 'ENTREGUE'))
);

COMMENT ON TABLE  lojas.envios                  IS 'Criar a tabela "envios".';
COMMENT ON COLUMN lojas.envios.envio_id         IS 'Criar a coluna "envio_id", na qual é a Primary Key.';
COMMENT ON COLUMN lojas.envios.loja_id          IS 'Criar a coluna "loja_id", na qual é uma FK.';
COMMENT ON COLUMN lojas.envios.cliente_id       IS 'Criar a coluna "cliente_id", na qual é uma FK.';
COMMENT ON COLUMN lojas.envios.endereco_entrega IS 'Criar a coluna "endereco_entrega".';
COMMENT ON COLUMN lojas.envios.status           IS 'Criar a coluna "status".';

-- Aqui estão as Foreign Keys (FK) da tabela "envios".

ALTER TABLE    lojas.envios 
ADD CONSTRAINT lojas_envios_fk
FOREIGN KEY    (loja_id)
REFERENCES     lojas.lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE    lojas.envios 
ADD CONSTRAINT clientes_envios_fk
FOREIGN KEY    (cliente_id)
REFERENCES     lojas.clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- Criar a tabela "pedidos".

CREATE TABLE lojas.pedidos (
  pedido_id  NUMERIC(38) NOT NULL,
  data_hora  TIMESTAMP   NOT NULL,
  cliente_id NUMERIC(38) NOT NULL,
  status     VARCHAR(15) NOT NULL,
  loja_id    NUMERIC(38) NOT NULL,
  CONSTRAINT   pedido_id 
  PRIMARY KEY (pedido_id),
  CONSTRAINT check_status 
  CHECK (status IN ('CANCELADO', 'COMPLETO', 'ABERTO', 'PAGO', 'REEMBOLSADO', 'ENVIADO'))
);

COMMENT ON TABLE  lojas.pedidos            IS 'Criar a tabela "pedidos".';
COMMENT ON COLUMN lojas.pedidos.pedido_id  IS 'Criar a coluna "pedido_id", na qual ela é a Primary Key.';
COMMENT ON COLUMN lojas.pedidos.data_hora  IS 'Criar a coluna "data_hora".';
COMMENT ON COLUMN lojas.pedidos.cliente_id IS 'Criar a coluna "cliente_id", na qual ela é FK.';
COMMENT ON COLUMN lojas.pedidos.status     IS 'Criar a coluna "status".';
COMMENT ON COLUMN lojas.pedidos.loja_id    IS 'Criar a coluna "loja_id", na qual ela é FK.';

-- Aqui estão as Foreign Keys (FK) da tabela "pedidos".

ALTER TABLE    lojas.pedidos 
ADD CONSTRAINT clientes_pedidos_fk
FOREIGN KEY    (cliente_id)
REFERENCES     lojas.clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE    lojas.pedidos 
ADD CONSTRAINT lojas_pedidos_fk
FOREIGN KEY    (loja_id)
REFERENCES     lojas.lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- Criar a tabela "pedidos_itens".

CREATE TABLE lojas.pedidos_itens (
  pedido_id       NUMERIC(38)   NOT NULL,
  produto_id      NUMERIC(38)   NOT NULL,
  numero_da_linha NUMERIC(38)   NOT NULL,
  preco_unitario  NUMERIC(10,2) NOT NULL,
  quantidade      NUMERIC(38)   NOT NULL,
  envio_id        NUMERIC(38),
  CONSTRAINT   pedido_id 
  PRIMARY KEY (pedido_id, produto_id)
);
COMMENT ON TABLE  lojas.pedidos_itens                 IS 'Criar a tabela "pedidos_itens".';
COMMENT ON COLUMN lojas.pedidos_itens.pedido_id       IS 'Criar a coluna "pedido_id", na qual ela é uma PFK.';
COMMENT ON COLUMN lojas.pedidos_itens.produto_id      IS 'Criar a coluna "produto_id", na qual ela é uma PFK.';
COMMENT ON COLUMN lojas.pedidos_itens.numero_da_linha IS 'Criar a coluna "numero_da_linha".';
COMMENT ON COLUMN lojas.pedidos_itens.preco_unitario  IS 'Criar a coluna "preco_unitario".';
COMMENT ON COLUMN lojas.pedidos_itens.quantidade      IS 'Criar a coluna "quantidade".';
COMMENT ON COLUMN lojas.pedidos_itens.envio_id        IS 'Criar a coluna "envio_id", na qual ela é uma FK.';

-- Aqui estão as Foreign Keys (FK) da tabela "pedidos_itens".

ALTER TABLE    lojas.pedidos_itens 
ADD CONSTRAINT envios_pedidos_itens_fk
FOREIGN KEY    (envio_id)
REFERENCES     lojas.envios (envio_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE    lojas.pedidos_itens 
ADD CONSTRAINT pedidos_pedidos_itens_fk
FOREIGN KEY    (pedido_id)
REFERENCES     lojas.pedidos (pedido_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;








