@echo off
chcp 65001 >nul
echo.
echo 🎨 Iniciando Frontend - Atendechat com Docker
echo =============================================
echo.

if not exist "codatendechat-main\frontend" (
    echo ❌ Pasta do frontend não encontrada!
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

cd codatendechat-main\frontend

echo ⏳ Verificando configurações...
if not exist ".env" (
    echo ❌ Arquivo .env não encontrado!
    echo 🔧 Execute primeiro o SETUP_DOCKER.bat
    pause
    exit /b 1
)

echo.
echo 🚀 Iniciando servidor frontend...
echo 🌐 Frontend será executado em: http://localhost:3000
echo 🔗 API Backend: http://localhost:8080
echo.
echo ⚠️  IMPORTANTE: Certifique-se que o backend já está rodando!
echo 📁 Execute INICIAR_BACKEND_DOCKER.bat em outro terminal
echo.
echo 🛑 Para parar, pressione Ctrl+C
echo.

call npm start

pause