@echo off
chcp 65001 >nul
echo.
echo 🎨 Iniciando Frontend do Atendechat...
echo =====================================
echo.

if not exist "codatendechat-main\frontend" (
    echo ❌ Pasta do frontend não encontrada!
    echo 📁 Execute este script na pasta raiz do projeto.
    pause
    exit /b 1
)

cd codatendechat-main\frontend

echo ⏳ Verificando configurações...
if not exist ".env" (
    echo ❌ Arquivo .env não encontrado!
    echo 🔧 Execute primeiro o SETUP_WINDOWS.bat
    pause
    exit /b 1
)

echo.
echo 🚀 Iniciando servidor frontend...
echo 🌐 Frontend será executado em: http://localhost:3000
echo 🛑 Para parar, pressione Ctrl+C
echo.
echo ⚠️  IMPORTANTE: Certifique-se que o backend já está rodando!
echo.

call npm start

pause