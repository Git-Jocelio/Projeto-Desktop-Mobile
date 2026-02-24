# Projeto Desktop-Mobile

Sistema desenvolvido em Delphi com arquitetura em camadas, separando aplicação Desktop (VCL) e Servidor REST.

## 📐 Arquitetura

O projeto segue separação de responsabilidades:

- **FontesVcl** → Aplicação Desktop (Camada de Apresentação)
- **FontesServidor** → Servidor REST (Camada de Serviços)
- Banco de Dados Firebird
- Comunicação via HTTP/REST

### 📂 Estrutura
/FontesVcl
/FontesServidor

## 🧠 Padrões Utilizados

- Separação em camadas (Presentation / Service / Data)
- DataModule para gerenciamento de conexão
- Organização modular por responsabilidade
- Versionamento com Git
- Deploy controlado por branch `main`

## 🔌 Tecnologias

- Delphi VCL
- Firebird
- REST API
- Git
- GitHub

## 🚀 Execução do Projeto

### 1️⃣ Clonar
git clone git@github.com
:Git-Jocelio/Projeto-Desktop-Mobile.git

### 2️⃣ Configuração

- Ajustar parâmetros de conexão no DataModule
- Configurar caminho do banco Firebird
- Compilar pelo Delphi

### 3️⃣ Execução

- Iniciar Servidor
- Executar aplicação VCL

## 🔐 Banco de Dados

Banco Firebird configurável via parâmetros.
Estrutura preparada para evolução e escalabilidade.

## 📈 Melhorias Futuras

- Implementação de autenticação
- Logs estruturados
- Tratamento global de exceções
- Documentação da API
- CI/CD

## 👨‍💻 Autor

Jocelio Gomes da Silva  
Desenvolvedor Delphi
