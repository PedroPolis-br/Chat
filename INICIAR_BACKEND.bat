@echo off
chcp 65001 >nul
echo.
echo 🚀 Iniciando Backend do Atendechat...
echo ====================================
echo.

if not exist "codatendechat-main\backend" (
    echo ❌ Pasta do backend não encontrada!
    echo 📁 Execute este script na pasta raiz do projeto.
    pause
    exit /b 1
)

cd codatendechat-main\backend

echo ⏳ Verificando configurações...
if not exist ".env" (
    echo ❌ Arquivo .env não encontrado!
    echo 🔧 Execute primeiro o SETUP_WINDOWS.bat
    pause
    exit /b 1
)

echo 🗄️  Executando migrações do banco...
call npx sequelize db:migrate

echo 📊 Executando seeds...
call npx sequelize db:seed:all

echo.
echo 🚀 Iniciando servidor backend...
echo 🌐 Backend será executado em: http://localhost:8080
echo 🛑 Para parar, pressione Ctrl+C
echo.

call npm run dev:server

pause