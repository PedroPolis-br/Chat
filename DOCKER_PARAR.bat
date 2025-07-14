@echo off
chcp 65001 >nul
echo.
echo 🛑 Parando Containers Docker - Atendechat
echo ==========================================
echo.

if not exist "codatendechat-main\backend" (
    echo ❌ Projeto não encontrado!
    pause
    exit /b 1
)

cd codatendechat-main\backend

echo 🐳 Parando containers Docker...
docker-compose down

echo.
echo 📋 Containers restantes:
docker ps --filter "name=atendechat" --format "table {{.Names}}\t{{.Status}}"

echo.
echo ✅ Containers Docker parados!
echo.
echo 💡 Para remover dados persistentes também, use:
echo    docker-compose down -v
echo.
echo 🚀 Para iniciar novamente, use: DOCKER_INICIAR.bat
echo.

cd ..\..
pause