-- =====================================================
-- Migration: 006_create_usuario_perfil.sql
-- Descrição: Criação da tabela USUARIO_PERFIL
-- Banco: Firebird 2.5
-- =====================================================


-- =====================================================
-- CREATE TABLE
-- =====================================================

CREATE TABLE USUARIO_PERFIL (
    ID INTEGER NOT NULL,
    USUARIOID INTEGER NOT NULL,
    ID_PERFIL INTEGER NOT NULL,

    CONSTRAINT PK_USUARIO_PERFIL
        PRIMARY KEY (ID),

    CONSTRAINT UK_USUARIO_PERFIL
        UNIQUE (USUARIOID, ID_PERFIL)
);


-- Índice para o relacionamento com USUARIO
CREATE INDEX IDX_USUARIO_PERFIL_USUARIO
ON USUARIO_PERFIL (ID_USUARIO);

-- Índice para o relacionamento com PERFIL
CREATE INDEX IDX_USUARIO_PERFIL_PERFIL
ON USUARIO_PERFIL (ID_PERFIL);

-- FK para USUARIO
ALTER TABLE USUARIO_PERFIL
ADD CONSTRAINT FK_USUARIO_PERFIL_USUARIO
FOREIGN KEY (ID_USUARIO)
REFERENCES USUARIO (USUARIOID);

-- FK para PERFIL
ALTER TABLE USUARIO_PERFIL
ADD CONSTRAINT FK_USUARIO_PERFIL_PERFIL
FOREIGN KEY (ID_PERFIL)
REFERENCES PERFIL (ID_PERFIL);

-- Generator
CREATE GENERATOR GEN_USUARIO_PERFIL_ID;


-- =====================================================
-- TRIGGER
-- =====================================================

SET TERM ^ ;

CREATE TRIGGER BI_USUARIO_PERFIL
FOR USUARIO_PERFIL
ACTIVE BEFORE INSERT
POSITION 0
AS
BEGIN
    IF (NEW.ID IS NULL) THEN
        NEW.ID = GEN_ID(GEN_USUARIO_PERFIL_ID, 1);
END^

SET TERM ; ^