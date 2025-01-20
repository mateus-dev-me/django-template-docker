# Django Template Project

Este é um template de projeto Django configurado para ser facilmente utilizado em novos projetos. Ele já vem com as configurações básicas para desenvolvimento e produção utilizando Docker e Docker Compose. O template inclui integração com um banco de dados Postgres e está pronto para ser extendido de acordo com as necessidades do seu projeto.

## Estrutura do Projeto

A estrutura do template é a seguinte:


```
.
├── Dockerfile                # Arquivo Docker para criar a imagem do container
├── Makefile                  # Makefile para automação de tarefas
├── README.md                 # Documentação principal do projeto
├── app
│   ├── core
│   │   ├── __init__.py
│   │   ├── asgi.py
│   │   ├── settings          # Configurações do Django divididas em base, dev e prod
│   │   │   ├── __init__.py
│   │   │   ├── base.py
│   │   │   ├── dev.py
│   │   │   └── prod.py
│   │   ├── settings.py       # Arquivo principal de configurações
│   │   ├── urls.py           # URL routing do Django
│   │   └── wsgi.py           # Configurações para WSGI
│   ├── db.sqlite3            # Banco de dados SQLite (desenvolvimento)
│   ├── manage.py             # Script de gerenciamento do Django
│   └── requirements.txt      # Dependências do projeto
├── compose.yml               # Configuração do Docker Compose para containers
├── poetry.lock               # Arquivo de bloqueio do Poetry
├── pyproject.toml            # Arquivo de configuração do Poetry
└── scripts
    └── commands.sh           # Script de inicialização e setup
```


## Descrição dos Arquivos

- **Dockerfile**: Contém as instruções para construir a imagem Docker do projeto. Instala as dependências e configura o ambiente virtual Python.
  
- **Docker Compose (`compose.yml`)**: Configuração do Docker Compose para rodar o contêiner web e o banco de dados Postgres. O contêiner web depende do banco de dados.

- **Makefile**: Utilizado para automação de tarefas de desenvolvimento e produção.

- **README.md**: Este arquivo que contém informações gerais sobre o projeto.

- **app/core/settings**: Diretório contendo os arquivos de configuração para diferentes ambientes:
  - **base.py**: Configurações compartilhadas para todos os ambientes.
  - **dev.py**: Configurações específicas para o ambiente de desenvolvimento.
  - **prod.py**: Configurações específicas para o ambiente de produção.
  
- **app/requirements.txt**: Lista de pacotes Python necessários para o projeto.

- **scripts/commands.sh**: Script responsável por iniciar a aplicação, fazer migrações, coletar arquivos estáticos e iniciar o servidor (com opção de desenvolvimento ou produção).

## Configuração do Ambiente

### Docker

O projeto utiliza Docker para facilitar o desenvolvimento e a implantação. O **Dockerfile** define o ambiente do container, enquanto o **docker-compose.yml** configura os serviços necessários, como o serviço de aplicação (web) e banco de dados (db).

Para construir a imagem e rodar os containers:

1. **Construa a imagem Docker**:
   ```bash
   docker-compose build
   ```

2. **Inicie os containers**:
   ```bash
   docker-compose up
   ```

Isso irá subir os contêineres `web` e `db`, e você poderá acessar a aplicação em `http://localhost:8000`
