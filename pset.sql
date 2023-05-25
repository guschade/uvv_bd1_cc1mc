-- Verificar se o banco de dados "uvv" já existe, se existir, então eu devo excluir.

DROP DATABASE IF EXISTS uvv;

-- Verificar se o cargo "gustavo_schade" já existe, se existir, então eu devo excluir.

DROP ROLE IF EXISTS gustavo_schade;

-- Verificar se o cargo "gustavo_schade" já existe, se existir, então eu devo excluir.

DROP USER IF EXISTS gustavo_schade;

-- Depois, criar o usuário "gustavo_schade".

CREATE USER gustavo_schade WITH        
  CREATEDB
  CREATEROLE  
  ENCRYPTED PASSWORD 'psetuvv';
 
-- Depois, criar o banco de dados.

SET ROLE gustavo_schade;
CREATE DATABASE uvv 
  OWNER             =  gustavo_schade
  TEMPLATE          =  template0
  ENCODING          = 'UTF8'
  LC_COLLATE        = 'pt_BR.UTF-8'
  LC_CTYPE          = 'pt_BR.UTF-8'
  ALLOW_CONNECTIONS =  TRUE;

ALTER DATABASE uvv OWNER TO gustavo_schade;  	

-- Depois, dar permissão de acesso ao banco de dados.
\setenv PGPASSWORD 'psetuvv'

\c uvv gustavo_schade

-- Criar o schema.

CREATE SCHEMA lojas;

-- Criar a tabela "produtos". 

CREATE TABLE produtos (
                produto_id                NUMERIC(38)  NOT NULL,
                nome                      VARCHAR(255) NOT NULL,
                preco_unitario            NUMERIC(10,2),
                detalhes                  BYTEA,
                imagem                    BYTEA,
                imagem_mime_type          VARCHAR(512),
                imagem_arquivo            VARCHAR(512),
                imagem_charset            VARCHAR(512),
                imagem_ultima_atualizacao DATE,
                CONSTRAINT   pk_produtos 
                PRIMARY KEY (produto_id),
                CONSTRAINT   check_preco_unitario 
                CHECK       (preco_unitario >= 0)
);

-- Comentários da tabela e das colunas da tabela "produtos".

COMMENT ON TABLE  produtos                           IS 'Criar a tabela "produtos".';
COMMENT ON COLUMN produtos.produto_id                IS 'Criar a coluna "produto_id", na qual ela é a Primary Key.';
COMMENT ON COLUMN produtos.nome                      IS 'Criar a coluna "nome".';
COMMENT ON COLUMN produtos.preco_unitario            IS 'Criar a coluna "preco_unitario".';
COMMENT ON COLUMN produtos.detalhes                  IS 'Criar a coluna "detalhes".';
COMMENT ON COLUMN produtos.imagem                    IS 'Criar a coluna "imagem".';
COMMENT ON COLUMN produtos.imagem_mime_type          IS 'Criar a coluna "imagem_mime_type".';
COMMENT ON COLUMN produtos.imagem_arquivo            IS 'Criar a coluna "imagem_arquivo".';
COMMENT ON COLUMN produtos.imagem_charset            IS 'Criar a coluna "imagem_charset".';
COMMENT ON COLUMN produtos.imagem_ultima_atualizacao IS 'Criar a coluna "imagem_ultima_atualizacao".';

-- Criar a tabela "lojas".

CREATE TABLE lojas (
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
                CONSTRAINT   pk_lojas 
                PRIMARY KEY (loja_id),
                CONSTRAINT   check_endereco_web
                CHECK       (endereco_web IS NOT NULL)
);

-- Comentários da tabela e das colunas da tabela "lojas".

COMMENT ON TABLE  lojas                         IS 'Criar a tabela "lojas".';
COMMENT ON COLUMN lojas.loja_id                 IS 'Criar a coluna "loja_id", na qual ela é a Primary Key.';
COMMENT ON COLUMN lojas.nome                    IS 'Criar a coluna "nome".';
COMMENT ON COLUMN lojas.endereco_web            IS 'Criar a coluna "endereco_web".';
COMMENT ON COLUMN lojas.endereco_fisico         IS 'Criar a coluna "endereco_fisico".';
COMMENT ON COLUMN lojas.latitude                IS 'Criar a coluna "latitude".';
COMMENT ON COLUMN lojas.longitude               IS 'Criar a coluna "longitude".';
COMMENT ON COLUMN lojas.logo                    IS 'Criar a coluna "logo".';
COMMENT ON COLUMN lojas.logo_mime_type          IS 'Criar a coluna "logo_mime_type".';
COMMENT ON COLUMN lojas.logo_arquivo            IS 'Criar a coluna "logo_arquivo".';
COMMENT ON COLUMN lojas.logo_charset            IS 'Criar a coluna "logo_charset".';
COMMENT ON COLUMN lojas.logo_ultima_atualizacao IS 'Criar a coluna "logo_ultima_atualizacao".';

-- Criar a tabela "estoques".

CREATE TABLE estoques (
                estoque_id NUMERIC(38) NOT NULL,
                loja_id    NUMERIC(38) NOT NULL,
                produto_id NUMERIC(38) NOT NULL,
                quantidade NUMERIC(38) NOT NULL,
                CONSTRAINT   pk_estoques 
                PRIMARY KEY (estoque_id),
                CONSTRAINT   check_quantidade
                CHECK       (quantidade >=0)
);

-- Comentários da tabela e das colunas da tabela "estoques".

COMMENT ON TABLE  estoques            IS 'Criar a tabela "estoques".';
COMMENT ON COLUMN estoques.estoque_id IS 'Criar a coluna "estoque_id", na qual ela é a Primary Key.';
COMMENT ON COLUMN estoques.loja_id    IS 'Criar a coluna "loja_id", na qual é uma FK.';
COMMENT ON COLUMN estoques.produto_id IS 'Criar a coluna "produto_id", na qual é uma FK.';
COMMENT ON COLUMN estoques.quantidade IS 'Criar a coluna "quantidade".';

-- Aqui estão as Foreign Keys (FK) da tabela "estoques".

ALTER TABLE    estoques 
ADD CONSTRAINT lojas_estoques_fk
FOREIGN KEY   (loja_id)
REFERENCES     lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE    estoques 
ADD CONSTRAINT produtos_estoques_fk
FOREIGN KEY   (produto_id)
REFERENCES     produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- Criar a tabela "clientes".

CREATE TABLE clientes (
                cliente_id NUMERIC(38)  NOT NULL,
                email      VARCHAR(255) NOT NULL,
                nome       VARCHAR(255) NOT NULL,
                telefone1  VARCHAR(20),
                telefone2  VARCHAR(20),
                telefone3  VARCHAR(20),
                CONSTRAINT   pk_clientes 
                PRIMARY KEY (cliente_id),
                CONSTRAINT   check_telefone1
                CHECK       (telefone1 IS NOT NULL)
);

-- Comentários da tabela e das colunas da tabela "clientes".

COMMENT ON TABLE  clientes            IS 'Criar a tabela "clientes".';
COMMENT ON COLUMN clientes.cliente_id IS 'Criar a coluna "cliente_id", na qual ela é a Primary Key.';
COMMENT ON COLUMN clientes.email      IS 'Criar a coluna "email".';
COMMENT ON COLUMN clientes.nome       IS 'Criar a coluna "nome".';
COMMENT ON COLUMN clientes.telefone1  IS 'Criar a tabela "telefone1".';
COMMENT ON COLUMN clientes.telefone2  IS 'Criar a coluna "telefone2".';
COMMENT ON COLUMN clientes.telefone3  IS 'Criar a coluna "telefone3".';

-- Criar a tabela "envios".

CREATE TABLE envios (
                envio_id NUMERIC(38) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                cliente_id NUMERIC(38) NOT NULL,
                endereco_entrega VARCHAR(512) NOT NULL,
                status VARCHAR(15) NOT NULL,
                CONSTRAINT   pk_envios 
                PRIMARY KEY (envio_id),
                CONSTRAINT   check_status 
                CHECK       (status IN ('CRIADO', 'ENVIADO', 'TRANSITO', 'ENTREGUE'))
);

-- Comentários da tabela e das colunas da tabela "envios".

COMMENT ON TABLE  envios                  IS 'Criar a tabela "envios".';
COMMENT ON COLUMN envios.envio_id         IS 'Criar a coluna "envio_id", na qual ela é a Primary Key.';
COMMENT ON COLUMN envios.loja_id          IS 'Criar a coluna "loja_id", na qual ela é uma FK.';
COMMENT ON COLUMN envios.cliente_id       IS 'Criar a coluna "cliente_id", na qual é uma FK.';
COMMENT ON COLUMN envios.endereco_entrega IS 'Criar a coluna "endereco_entrega".';
COMMENT ON COLUMN envios.status           IS 'Criar a coluna "status".';

-- Aqui estão as Foreign Keys (FK) da tabela "envios".

ALTER TABLE    envios 
ADD CONSTRAINT lojas_envios_fk
FOREIGN KEY   (loja_id)
REFERENCES     lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE    envios 
ADD CONSTRAINT clientes_envios_fk
FOREIGN KEY   (cliente_id)
REFERENCES     clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- Criar a tabela "pedidos".

CREATE TABLE pedidos (
                pedido_id  NUMERIC(38) NOT NULL,
                data_hora  TIMESTAMP   NOT NULL,
                cliente_id NUMERIC(38) NOT NULL,
                status     VARCHAR(15) NOT NULL,
                loja_id    NUMERIC(38) NOT NULL,
                CONSTRAINT   pk_pedidos 
                PRIMARY KEY (pedido_id),
                CONSTRAINT   check_status 
                CHECK       (status IN ('CANCELADO', 'COMPLETO', 'ABERTO', 'PAGO', 'REEMBOLSADO', 'ENVIADO'))
);

-- Comentários da tabela e das colunas da tabela "pedidos".

COMMENT ON TABLE  pedidos            IS 'Criar a tabela "pedidos".';
COMMENT ON COLUMN pedidos.pedido_id  IS 'Criar a coluna "pedido_id", na qual ela é a Primary Key.';
COMMENT ON COLUMN pedidos.data_hora  IS 'Criar a coluna "data_hora".';
COMMENT ON COLUMN pedidos.cliente_id IS 'Criar a coluna "cliente_id", na qual ela é Foreign Key.';
COMMENT ON COLUMN pedidos.status     IS 'Criar a coluna "status".';
COMMENT ON COLUMN pedidos.loja_id    IS 'Criar a coluna "loja_id", na qual ela é FK.';


-- Aqui estão as Foreign Keys (FK) da tabela "pedidos".

ALTER TABLE    pedidos 
ADD CONSTRAINT clientes_pedidos_fk
FOREIGN KEY   (cliente_id)
REFERENCES     clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE    pedidos 
ADD CONSTRAINT lojas_pedidos_fk
FOREIGN KEY   (loja_id)
REFERENCES     lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- Criar a tabela "pedidos_itens".

CREATE TABLE pedidos_itens (
                pedido_id       NUMERIC(38)   NOT NULL,
                produto_id      NUMERIC(38)   NOT NULL,
                numero_da_linha NUMERIC(38)   NOT NULL,
                preco_unitario  NUMERIC(10,2) NOT NULL,
                quantidade      NUMERIC(38)   NOT NULL,
                envio_id        NUMERIC(38),
                CONSTRAINT   pk_pedidos_itens 
                PRIMARY KEY (pedido_id, produto_id),
                CONSTRAINT   check_quantidade
                CHECK       (quantidade >=0) 
);

-- Comentários da tabela e das colunas da tabela "pedidos_itens".

COMMENT ON TABLE  pedidos_itens                 IS 'Criar a tabela "pedidos_itens".';
COMMENT ON COLUMN pedidos_itens.pedido_id       IS 'Criar a coluna "pedido_id", na qual ela é uma PFK.';
COMMENT ON COLUMN pedidos_itens.produto_id      IS 'Criar a coluna "produto_id", na qual ela é uma PFK.';
COMMENT ON COLUMN pedidos_itens.numero_da_linha IS 'Criar a coluna "numero_da_linha".';
COMMENT ON COLUMN pedidos_itens.preco_unitario  IS 'Criar a coluna "preco_unitario".';
COMMENT ON COLUMN pedidos_itens.quantidade      IS 'Criar a coluna "quantidade".';
COMMENT ON COLUMN pedidos_itens.envio_id        IS 'Criar a coluna "envio_id", na qual ela é uma FK.';

-- Aqui estão as Foreign Keys (FK) da tabela "pedidos_itens".

ALTER TABLE    pedidos_itens 
ADD CONSTRAINT produtos_pedidos_itens_fk
FOREIGN KEY   (produto_id)
REFERENCES     produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE    pedidos_itens 
ADD CONSTRAINT envios_pedidos_itens_fk
FOREIGN KEY   (envio_id)
REFERENCES     envios (envio_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE    pedidos_itens 
ADD CONSTRAINT pedidos_pedidos_itens_fk
FOREIGN KEY   (pedido_id)
REFERENCES     pedidos (pedido_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
