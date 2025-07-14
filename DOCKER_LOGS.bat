@echo off
chcp 65001 >nul
echo.
echo 📋 Logs dos Containers Docker - Atendechat  
echo =============================================
echo.

if not exist "codatendechat-main\backend" (
    echo ❌ Projeto não encontrado!
    pause
    exit /b 1
)

cd codatendechat-main\backend

echo 🔍 Status dos containers:
docker ps --filter "name=atendechat" --format "table {{.Names}}\t{{.Ports}}\t{{.Status}}"

echo.
echo 📊 Escolha qual log visualizar:
echo 1. PostgreSQL
echo 2. Redis  
echo 3. Todos os containers
echo 4. Logs em tempo real (todos)
echo.
set /p escolha=Digite sua escolha (1-4): 

if "%escolha%"=="1" (
    echo.
    echo 🐘 Logs do PostgreSQL:
    docker logs atendechat-postgres
) else if "%escolha%"=="2" (
    echo.
    echo 🔴 Logs do Redis:
    docker logs atendechat-redis
) else if "%escolha%"=="3" (
    echo.
    echo 📋 Logs de todos os containers:
    docker-compose logs
) else if "%escolha%"=="4" (
    echo.
    echo 📡 Logs em tempo real (Ctrl+C para sair):
    docker-compose logs -f
) else (
    echo ❌ Opção inválida!
)

echo.
echo 💡 Comandos úteis:
echo docker logs atendechat-postgres  (logs PostgreSQL)
echo docker logs atendechat-redis     (logs Redis)
echo docker-compose logs -f          (todos em tempo real)
echo.

cd ..\..
pause