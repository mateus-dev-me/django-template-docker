# Sobre o Projeto

Este é um template de projeto Django configurado para ser facilmente utilizado em novos projetos. Ele já vem com as configurações básicas para desenvolvimento e produção utilizando Docker e Docker Compose. O template inclui integração com um banco de dados Postgres e está pronto para ser extendido de acordo com as necessidades do seu projeto.

## Estrutura do Projeto
Este projeto segue uma estrutura modular para organização do código, configuração e automação de tarefas. Abaixo está uma visão geral da estrutura de diretórios e arquivos do projeto.

```
.
├── app
│   ├── config
│   │   ├── __init__.py
│   │   ├── asgi.py
│   │   └── settings            # Configurações do Django divididas em base, dev e prod
│   │       ├── __init__.py
│   │       ├── base.py
│   │       ├── dev.py
│   │       └── prod.py
│   ├── core
│   │   ├── __init__.py
│   │   ├── abstracts           # Módulo para abstrações e modelos base
│   │   │   ├── __init__.py
│   │   │   └── models.py
│   │   └── apps.py
│   ├── db.sqlite3              # Banco de dados SQLite (apenas para desenvolvimento)
│   └── manage.py               # Script principal para execução de comandos Django
├── dotenv-files
│    └── .env-example           # Exemplo de variáveis de ambiente para configuração
├── scripts
│    └── commands.sh            # Script de automação de comandos
├── Dockerfile                  # Arquivo Docker para criar a imagem do container
├── compose.yml                 # Configuração do Docker Compose para orquestração de containers
├── pyproject.toml              # Arquivo de configuração do Poetry (dependências e metadados do projeto)
├── Makefile                    # Makefile para automação de tarefas comuns
└── README.md                   # Documentação do projeto
```

## Descrição dos diretórios e arquivos principais

### `app/`
Este diretório contém o código principal da aplicação.
- `config/`: Configurações do Django, incluindo diferentes ambientes (`base.py`, `dev.py`, `prod.py`).
- `core/`: Módulo central do projeto, contendo abstrações e configurações iniciais.
- `db.sqlite3`: Banco de dados utilizado apenas para ambiente de desenvolvimento.
- `manage.py`: Utilizado para rodar comandos administrativos do Django.

### `dotenv-files/`
Contém arquivos `.env` para configuração de variáveis de ambiente.
- `.env-example`: Modelo de arquivo de configuração para ambiente local.

### `scripts/`
Scripts auxiliares para facilitar automação de tarefas.
- `commands.sh`: Contém comandos para inicialização e setup do projeto.

### `Dockerfile`
Define a imagem Docker para o projeto, permitindo execução em ambiente conteinerizado.

### `compose.yml`
Arquivo de configuração do Docker Compose para gerenciamento de múltiplos containers.

### `pyproject.toml`
Gerencia dependências e metadados do projeto utilizando o Poetry.

### `Makefile`
Facilita a execução de tarefas comuns através de comandos simplificados.

## Configuração e Uso

### 1. Clonar o repositório
```sh
git clone https://github.com/mateus-dev-me/django-template-docker.git
cd django-template-docker
```

### 2. Criar e configurar o ambiente virtual
```sh
make install
```

### 3. Configurar variáveis de ambiente
Copie o arquivo `.env-example` para `.env` e edite conforme necessário:
```sh
cp dotenv-files/.env-example .env
```

### 4. Subir o ambiente com Docker
```sh
docker-compose up -d
```

### 5. Executar a aplicação
```sh
make run
```

Agora o servidor estará rodando e acessível via `http://localhost:8000/`.
