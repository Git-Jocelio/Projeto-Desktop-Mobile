Projeto Desktop-Mobile

Sistema desenvolvido em Delphi com arquitetura em camadas, separando aplicação Desktop (VCL) e Servidor REST.

📐 Arquitetura
O projeto segue separação de responsabilidades:

FontesVcl → Aplicação Desktop (Camada de Apresentação)
FontesServidor → Servidor REST (Camada de Serviços)
Banco de Dados: Firebird 2.5
Comunicação: HTTP utilizando o framework Horse
```
📂 Estrutura do Projeto
Projeto-Desktop-Mobile
│
├── FontesVcl
│   ├── DataModules
│   │   ├── DataModulePessoa.pas
│   │   ├── DataModuleProduto.pas
│   │   └── DataModuleUsuario.pas
│   │
│   ├── FormBaseEdicao
│   │   └── UnitFormBaseEdicao.pas
│   │
│   ├── FormCadastros
│   │   └── Produtos
│   │       └── UnitFormProduto.pas
│   │
│   ├── Services
│   │   └── ServicePessoa.pas
│   │
│   ├── Utils
│   │   ├── VclLoading.pas
│   │   ├── VclNavigation.pas
│   │   └── VclSession.pas
│   │
│   ├── UnitFrmPrincipal.pas
│   └── UnitLogin.pas
│
├── FontesServidor
│   ├── Config
│   │   └── EnvConf.pas
│   │
│   ├── Controllers
│   │   ├── Controllers.Cliente.pas
│   │   └── Controllers.Usuario.pas
│   │
│   ├── DataModules
│   │   ├── DataModulePessoa.pas
│   │   ├── DataModuleServidor.pas
│   │   └── DataModuleUsuario.pas
│   │
│   ├── Service
│   │   └── ServicePessoa.pas
│   │
│   ├── Utils
│   │   └── UMD5.pas
│   │
│   └── UnitPrincipal.pas
│
└── README.md
```
📖 Organização das Pastas

🖥 FontesVcl
Aplicação Desktop desenvolvida em Delphi VCL, responsável pela interface do usuário e comunicação com o servidor REST.

DataModules → Gerenciamento de conexões e datasets da aplicação
FormBaseEdicao → Formulários base reutilizáveis para cadastros
FormCadastros → Telas de cadastro do sistema
Services → Camada responsável pela comunicação com a API REST
Utils → Funções auxiliares utilizadas pela aplicação
UnitFrmPrincipal → Tela principal do sistema
UnitLogin → Tela de autenticação do usuário

🌐 FontesServidor
Servidor REST desenvolvido com Horse, responsável pelas regras de negócio e acesso ao banco de dados.

Config → Configurações da aplicação e variáveis de ambiente
Controllers → Endpoints da API responsáveis por receber as requisições HTTP
DataModules → Gerenciamento de conexão com o banco de dados
Service → Camada de regras de negócio
Utils → Funções utilitárias usadas pelo servidor
UnitPrincipal → Inicialização do servidor e configuração das rotas

🧠 Padrões Utilizados

Separação em camadas MVC (Model-View-Controller)
DataModule para gerenciamento de conexão
Organização modular por responsabilidade
Versionamento com Git

🔌 Tecnologias
Delphi VCL Versão 13
Firebird 2.5
REST API (Framework Horse)
Git
GitHub

🚀 Execução do Projeto

1️⃣ Clonar o repositório
git clone git@github.com:Git-Jocelio/Projeto-Desktop-Mobile.git

2️⃣ Configuração
Ajustar parâmetros de conexão no DataModule
Configurar caminho do banco Firebird
Compilar o projeto pelo Delphi

3️⃣ Pré-requisitos
Antes de executar o projeto, certifique-se de ter instalado:
Delphi 11 Alexandria ou superior
Firebird Server 2.5 ou superior
Boss (Gerenciador de dependências para Delphi) — opcional, mas recomendado para o Horse

🔐 Banco de Dados
Banco Firebird configurável via parâmetros.
A estrutura foi preparada para permitir evolução e escalabilidade do sistema.

📈 Melhorias Futuras
Implementação de autenticação de usuários
Logs estruturados para auditoria e análise
Documentação da API utilizando GBSwagger

👨‍💻 Autor
Grupo Aussel

Jocelio Gomes da Silva
Desenvolvedor Delphi
