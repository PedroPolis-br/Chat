@echo off
chcp 65001 >nul
echo.
echo 🚀 Iniciando Backend - Atendechat com Docker
echo ============================================
echo.

if not exist "codatendechat-main\backend" (
    echo ❌ Pasta do backend não encontrada!
    echo 📁 Execute este script na pasta raiz do projeto.
    pause
    exit /b 1
)

:: Verificar se containers estão rodando
echo 🔍 Verificando containers Docker...
docker-compose ps | findstr "atendechat-postgres" >nul
if %errorlevel% neq 0 (
    echo ⚠️  Containers não estão rodando. Iniciando...
    docker-compose up -d
    echo ⏳ Aguardando containers iniciarem...
    timeout /t 10 /nobreak >nul
) else (
    echo ✅ Containers Docker já estão rodando!
)

cd codatendechat-main\backend

echo ⏳ Verificando configurações...
if not exist ".env" (
    echo ❌ Arquivo .env não encontrado!
    echo 🔧 Execute primeiro o SETUP_DOCKER.bat
    pause
    exit /b 1
)

echo 🗄️  Executando migrações do banco (se necessário)...
call npx sequelize db:migrate >nul 2>&1

echo 📊 Executando seeds (se necessário)...
call npx sequelize db:seed:all >nul 2>&1

echo.
echo 🚀 Iniciando servidor backend...
echo 🌐 Backend será executado em: http://localhost:8080
echo 🐘 PostgreSQL: localhost:5432
echo 🔴 Redis: localhost:6379
echo 💻 Adminer: http://localhost:8081 (para gerenciar banco)
echo.
echo 🛑 Para parar, pressione Ctrl+C
echo.

call npm run dev:server

pause