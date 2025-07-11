@echo off
chcp 65001 >nul
echo.
echo 🚀 Configurador Automático - Atendechat Windows
echo ================================================
echo.

:: Verificar se Node.js está instalado
echo ⏳ Verificando Node.js...
node --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ Node.js não encontrado!
    echo 📥 Por favor, instale o Node.js v20.x antes de continuar.
    echo 🔗 https://nodejs.org/
    pause
    exit /b 1
)
echo ✅ Node.js encontrado!

:: Verificar se está na pasta correta
if not exist "codatendechat-main" (
    echo ❌ Pasta 'codatendechat-main' não encontrada!
    echo 📁 Execute este script na pasta onde está o projeto.
    pause
    exit /b 1
)

echo.
echo 📂 Navegando para o projeto...
cd codatendechat-main

:: Criar arquivos .env se não existirem
echo.
echo 📝 Configurando arquivos de ambiente...

if not exist "backend\.env" (
    echo 🔧 Criando backend\.env...
    copy "backend\.env.example" "backend\.env" >nul
    echo ✅ Arquivo backend\.env criado!
    echo ⚠️  Lembre-se de editar o arquivo backend\.env com suas configurações!
) else (
    echo ℹ️  Arquivo backend\.env já existe.
)

if not exist "frontend\.env" (
    echo 🔧 Criando frontend\.env...
    copy "frontend\.env.example" "frontend\.env" >nul
    echo ✅ Arquivo frontend\.env criado!
) else (
    echo ℹ️  Arquivo frontend\.env já existe.
)

:: Instalar dependências do backend
echo.
echo 📦 Instalando dependências do backend...
cd backend
echo ⏳ Executando npm install no backend...
call npm install --force
if %errorlevel% neq 0 (
    echo ❌ Erro ao instalar dependências do backend!
    pause
    exit /b 1
)
echo ✅ Dependências do backend instaladas!

:: Instalar dependências do frontend
echo.
echo 📦 Instalando dependências do frontend...
cd ..\frontend
echo ⏳ Executando npm install no frontend...
call npm install --force
if %errorlevel% neq 0 (
    echo ❌ Erro ao instalar dependências do frontend!
    pause
    exit /b 1
)
echo ✅ Dependências do frontend instaladas!

echo.
echo 🎉 Configuração básica concluída!
echo.
echo 📋 PRÓXIMOS PASSOS:
echo.
echo 1. 🔧 Configure o PostgreSQL e crie o banco 'atendechat'
echo 2. 🐳 Inicie o Redis via Docker:
echo    docker run --name redis-atendechat -p 6379:6379 --restart always -d redis redis-server --requirepass MinhaRedisPassword123
echo.
echo 3. ✏️  Edite o arquivo backend\.env com suas configurações:
echo    - DB_PASS (senha do PostgreSQL)
echo    - Configurações de email
echo.
echo 4. 🗄️  Execute as migrações do banco:
echo    cd backend
echo    npx sequelize db:migrate
echo    npx sequelize db:seed:all
echo.
echo 5. 🚀 Inicie os serviços:
echo    Backend: cd backend ^&^& npm run dev:server
echo    Frontend: cd frontend ^&^& npm start
echo.
echo 📖 Para instruções detalhadas, consulte: GUIA_INSTALACAO_WINDOWS.md
echo.

cd ..
pause