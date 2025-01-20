#!/bin/sh

set -e

# Função para verificar se o Postgres está disponível
wait_for_postgres() {
  echo "🟡 Aguardando a inicialização do banco de dados Postgres ($POSTGRES_HOST:$POSTGRES_PORT)..."
  until nc -z "$POSTGRES_HOST" "$POSTGRES_PORT"; do
    sleep 2
  done
  echo "✅ Banco de dados Postgres iniciado com sucesso ($POSTGRES_HOST:$POSTGRES_PORT)"
}

# Função para coletar arquivos estáticos
collect_static_files() {
  echo "⚙️ Coletando arquivos estáticos..."
  python manage.py collectstatic --noinput
}

# Função para realizar migrações
make_migrations() {
  echo "⚙️ Realizando migrações..."
  python manage.py makemigrations --noinput
  python manage.py migrate --noinput
}

# Função para configurar diretórios de logs
setup_logs() {
  LOG_DIR="/data/logs"
  ACCESS_LOG="${LOG_DIR}/access.log"
  ERROR_LOG="${LOG_DIR}/error.log"

  # Criação do diretório de logs se não existir
  if [ ! -d "$LOG_DIR" ]; then
    echo "📂 Criando diretório de logs: $LOG_DIR"
    mkdir -p "$LOG_DIR"
  fi

  echo "✅ Diretório de logs configurado com sucesso."
}

# Função para iniciar o Gunicorn
start_gunicorn() {
  echo "🚀 Iniciando o servidor Gunicorn para o aplicativo Django..."
  exec gunicorn core.wsgi:application \
    --bind 0.0.0.0:8000 \
    --workers 3 \
    --timeout 120 \
    --access-logfile "$ACCESS_LOG" \
    --error-logfile "$ERROR_LOG"
}

# Função para iniciar o servidor de desenvolvimento Django (runserver)
start_runserver() {
  echo "🚀 Iniciando o servidor de desenvolvimento Django (runserver)..."
  exec python manage.py runserver 0.0.0.0:8000
}

# Função principal que verifica o ambiente e executa as ações apropriadas
start_application() {
  if echo "$DJANGO_SETTINGS_MODULE" | grep -q "prod"; then
    echo "🌍 Ambiente de produção detectado."

    # Etapas de produção: Verifica Postgres, coleta estáticos, faz migrações, configura logs e inicia Gunicorn
    wait_for_postgres
    collect_static_files
    make_migrations
    setup_logs
    start_gunicorn
  else
    echo "🖥️ Ambiente de desenvolvimento detectado."

    # Etapas de desenvolvimento: Coleta estáticos, faz migrações e inicia o runserver
    collect_static_files
    make_migrations
    start_runserver
  fi
}

start_application

