-- =====================================================
-- Migration: 005_create_telas.sql
-- Descrição: Criação da tabela TELAS
-- Banco: Firebird 2.5
-- =====================================================


CREATE TABLE TELA (
    ID_TELA INTEGER NOT NULL,
    NOME_TELA VARCHAR(100) NOT NULL,
    MODULO VARCHAR(50) NOT NULL,
    ORDEM INTEGER NOT NULL,
    ATIVO CHAR(1) NOT NULL
);

-- PRIMARY KEY
ALTER TABLE TELA
ADD CONSTRAINT PK_TELA
PRIMARY KEY (ID_TELA);

-- GENERATOR
CREATE GENERATOR GEN_ID_TELA;

-- TRIGGER


CREATE TRIGGER BI_TELA FOR TELA
ACTIVE BEFORE INSERT POSITION 0
AS
BEGIN
    IF (NEW.ID_TELA IS NULL) THEN
        NEW.ID_TELA = GEN_ID(GEN_ID_TELA, 1);
END