@echo off
chcp 65001 >nul
echo.
echo 🐳 Iniciando Atendechat com Docker
echo ==================================
echo.

if not exist "codatendechat-main\backend" (
    echo ❌ Projeto não encontrado!
    echo 🔧 Execute primeiro o SETUP_DOCKER.bat
    pause
    exit /b 1
)

cd codatendechat-main\backend

echo ⏳ Verificando Docker...
docker ps >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ Docker Desktop não está rodando!
    echo 🔧 Abra o Docker Desktop primeiro.
    pause
    exit /b 1
)

echo 🐳 Iniciando containers (PostgreSQL + Redis)...
docker-compose up -d

echo ⏳ Aguardando bancos iniciarem...
timeout /t 10 /nobreak >nul

echo 📋 Status dos containers:
docker ps --filter "name=atendechat" --format "table {{.Names}}\t{{.Ports}}\t{{.Status}}"

echo.
echo ✅ Containers prontos!
echo.
echo 🚀 Agora abra 2 terminais e execute:
echo.
echo 📟 Terminal 1 - Backend:
echo    cd codatendechat-main\backend
echo    npm run dev:server
echo.
echo 📟 Terminal 2 - Frontend:
echo    cd codatendechat-main\frontend 
echo    npm start
echo.
echo 🌐 Depois acesse: http://localhost:3000
echo.

cd ..\..
pause