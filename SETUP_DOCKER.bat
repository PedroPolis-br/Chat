@echo off
chcp 65001 >nul
echo.
echo 🐳 Configurador Docker - Atendechat Windows
echo ============================================
echo.

:: Verificar se Docker está rodando
echo ⏳ Verificando Docker...
docker --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ Docker não encontrado!
    echo 📥 Por favor, instale o Docker Desktop antes de continuar.
    echo 🔗 https://www.docker.com/products/docker-desktop/
    pause
    exit /b 1
)
echo ✅ Docker encontrado!

:: Verificar se Docker daemon está rodando
docker ps >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ Docker Desktop não está rodando!
    echo 🔧 Abra o Docker Desktop e aguarde inicializar.
    echo ⏳ Pressione qualquer tecla quando o Docker estiver verde...
    pause
)

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

:: Criar arquivos .env para Docker
echo.
echo 📝 Configurando arquivos Docker...

echo 🔧 Criando backend\.env para Docker...
copy "backend\.env.docker" "backend\.env" >nul
echo ✅ Arquivo backend\.env criado com configurações Docker!

if not exist "frontend\.env" (
    echo 🔧 Criando frontend\.env...
    copy "frontend\.env.example" "frontend\.env" >nul
    echo ✅ Arquivo frontend\.env criado!
) else (
    echo ℹ️  Arquivo frontend\.env já existe.
)

:: Instalar dependências do backend
echo.
echo � Instalando dependências do backend...
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

:: Iniciar containers Docker
echo.
echo � Iniciando containers Docker...
cd ..\backend
echo ⏳ Baixando e iniciando PostgreSQL + Redis...
docker-compose up -d
if %errorlevel% neq 0 (
    echo ❌ Erro ao iniciar containers Docker!
    echo 🔧 Verifique se o Docker Desktop está rodando.
    pause
    exit /b 1
)

echo ✅ Containers Docker iniciados!
echo.
echo ⏳ Aguardando bancos de dados inicializarem...
timeout /t 15 /nobreak >nul

:: Verificar se containers estão rodando
docker ps --filter "name=atendechat" --format "table {{.Names}}\t{{.Status}}" | findstr atendechat >nul
if %errorlevel% neq 0 (
    echo ❌ Containers não estão rodando corretamente!
    echo 🔍 Verificando logs...
    docker-compose logs
    pause
    exit /b 1
)

echo ✅ Bancos de dados prontos!

:: Executar migrações
echo.
echo 🗄️  Executando migrações do banco...
npx sequelize db:migrate
if %errorlevel% neq 0 (
    echo ❌ Erro nas migrações! Tentando novamente em 10 segundos...
    timeout /t 10 /nobreak >nul
    npx sequelize db:migrate
)

echo 📊 Executando seeds (dados iniciais)...
npx sequelize db:seed:all

echo.
echo 🎉 Configuração Docker concluída com sucesso!
echo.
echo 📋 CONTAINERS DOCKER RODANDO:
docker ps --filter "name=atendechat" --format "table {{.Names}}\t{{.Ports}}\t{{.Status}}"
echo.
echo 🚀 PRÓXIMOS PASSOS:
echo.
echo 1. 🖥️  Abra 2 terminais separados
echo.
echo 2. 🔙 Terminal 1 - Iniciar Backend:
echo    cd codatendechat-main\backend
echo    npm run dev:server
echo.
echo 3. 🎨 Terminal 2 - Iniciar Frontend:
echo    cd codatendechat-main\frontend
echo    npm start
echo.
echo 4. 🌐 Acessar: http://localhost:3000
echo    Login: admin@atendechat.com / 123456
echo.
echo 💡 DICAS:
echo • Use DOCKER_INICIAR.bat para facilitar
echo • Use DOCKER_PARAR.bat para parar os containers
echo • Use DOCKER_LOGS.bat para ver logs dos containers
echo.

cd ..
pause