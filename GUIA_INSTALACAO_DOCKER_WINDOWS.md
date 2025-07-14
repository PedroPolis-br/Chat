# 🐳 Guia de Instalação DOCKER - Atendechat no Windows

**Esta é a forma MAIS FÁCIL de instalar o Atendechat!** Usando Docker, você não precisa instalar PostgreSQL nem Redis diretamente no Windows.

## 🎯 Vantagens do Docker:
- ✅ **Sem instalação** de PostgreSQL ou Redis no Windows
- ✅ **Configuração automática** de todos os bancos
- ✅ **Isolamento** completo do ambiente
- ✅ **Fácil de limpar** e reconfigurar
- ✅ **Funciona igual** em qualquer Windows

## 📋 Pré-requisitos (APENAS 2 itens!)

### 1. Node.js v20.x
1. Acesse: https://nodejs.org/
2. Baixe a versão **20.x LTS**
3. Instale normalmente
4. Verifique: `node --version`

### 2. Docker Desktop
1. Acesse: https://www.docker.com/products/docker-desktop/
2. Baixe e instale o Docker Desktop
3. **IMPORTANTE:** Abra o Docker Desktop e aguarde ficar verde
4. Verifique: `docker --version`

**E só! Não precisa instalar PostgreSQL nem Redis! 🚀**

## 🔧 Configuração Rápida

### 1. Preparar o Projeto
Se você já extraiu o zip:
```bash
# Navegue até a pasta do projeto
cd C:\caminho\para\seu\projeto\codatendechat-main
```

### 2. Configurar Variáveis (.env)

#### Backend (.env)
Na pasta `backend`, crie o arquivo `.env`:
```env
NODE_ENV=development
BACKEND_URL=http://localhost:8080
FRONTEND_URL=http://localhost:3000
PORT=8080

# Configurações Docker - NÃO MUDE ESTAS!
DB_DIALECT=postgres
DB_HOST=localhost
DB_PORT=5432
DB_USER=atendechat_user
DB_PASS=atendechat_password
DB_NAME=atendechat

# Redis Docker - NÃO MUDE ESTAS!
REDIS_PORT=6379
REDIS_PASS=redis_password123
REDIS_DBS=16

JWT_SECRET=MinhaChaveSecretaJWT123456789
JWT_REFRESH_SECRET=MinhaChaveRefreshJWT987654321

REDIS_URI=redis://:redis_password123@127.0.0.1:6379
REDIS_OPT_LIMITER_MAX=1
REGIS_OPT_LIMITER_DURATION=3000

USER_LIMIT=10
CONNECTIONS_LIMIT=5
CLOSED_SEND_BY_ME=true

GERENCIANET_SANDBOX=true
GERENCIANET_CLIENT_ID=Client_Id_Gerencianet
GERENCIANET_CLIENT_SECRET=Client_Secret_Gerencianet
GERENCIANET_PIX_CERT=certificado-Gerencianet
GERENCIANET_PIX_KEY=chave pix gerencianet

# EMAIL (Configure com seus dados reais)
MAIL_HOST=smtp.gmail.com
MAIL_USER=seu@gmail.com
MAIL_PASS=SuaSenhaDoEmail
MAIL_FROM=seu@gmail.com
MAIL_PORT=465
```

#### Frontend (.env)
Na pasta `frontend`, crie o arquivo `.env`:
```env
REACT_APP_BACKEND_URL=http://localhost:8080
REACT_APP_HOURS_CLOSE_TICKETS_AUTO=24
```

## 🚀 Instalação Automática via Docker

### 1. Instalar Dependências
```bash
# Backend
cd backend
npm install --force

# Frontend
cd ../frontend
npm install --force
```

### 2. Iniciar Bancos via Docker
```bash
cd ../backend
docker-compose -f docker-compose.databases.yml up -d
```

Este comando vai:
- ✅ Baixar PostgreSQL automaticamente
- ✅ Baixar Redis automaticamente  
- ✅ Criar o banco "atendechat"
- ✅ Configurar usuários e senhas
- ✅ Rodar em background

### 3. Aguardar Bancos Iniciarem
```bash
# Verificar se está tudo rodando (deve aparecer 2 containers):
docker ps
```

### 4. Executar Migrações
```bash
# Na pasta backend:
npx sequelize db:migrate
npx sequelize db:seed:all
```

### 5. Iniciar Aplicação
```bash
# Terminal 1 - Backend:
cd backend
npm run dev:server

# Terminal 2 - Frontend:
cd frontend
npm start
```

## 🌐 Acessar o Sistema
- **Frontend:** http://localhost:3000
- **Login:** admin@atendechat.com / 123456

## 🔧 Comandos Docker Úteis

### Verificar Status
```bash
# Ver containers rodando:
docker ps

# Ver logs do PostgreSQL:
docker logs codatendechat-main-db_postgres-1

# Ver logs do Redis:
docker logs codatendechat-main-cache-1
```

### Parar/Iniciar Bancos
```bash
# Parar todos os bancos:
docker-compose -f docker-compose.databases.yml down

# Iniciar novamente:
docker-compose -f docker-compose.databases.yml up -d

# Reiniciar apenas PostgreSQL:
docker restart codatendechat-main-db_postgres-1

# Reiniciar apenas Redis:
docker restart codatendechat-main-cache-1
```

### Acessar Bancos Diretamente
```bash
# Conectar no PostgreSQL:
docker exec -it codatendechat-main-db_postgres-1 psql -U atendechat_user -d atendechat

# Conectar no Redis:
docker exec -it codatendechat-main-cache-1 redis-cli
> AUTH redis_password123
> ping
```

## 🔄 Reset Completo do Ambiente

Se algo der errado e quiser começar do zero:

```bash
# 1. Parar aplicação (Ctrl+C nos terminais)

# 2. Parar e remover containers:
docker-compose -f docker-compose.databases.yml down -v

# 3. Remover dados persistentes:
docker volume prune

# 4. Iniciar novamente:
docker-compose -f docker-compose.databases.yml up -d

# 5. Executar migrações novamente:
npx sequelize db:migrate
npx sequelize db:seed:all
```

## 🆘 Problemas Comuns com Docker

### 1. "Docker daemon is not running"
**Solução:** Abra o Docker Desktop e aguarde inicializar

### 2. "Port is already allocated"
**Solução:** 
```bash
# Parar containers conflitantes:
docker stop $(docker ps -q)
```

### 3. Containers não inicializam
**Solução:**
```bash
# Ver logs de erro:
docker-compose -f docker-compose.databases.yml logs

# Recriar containers:
docker-compose -f docker-compose.databases.yml down
docker-compose -f docker-compose.databases.yml up -d --force-recreate
```

### 4. Erro de permissão no Windows
**Solução:** Execute Docker Desktop como Administrador

## 📦 O que fica no Docker?
- ✅ **PostgreSQL** - Banco principal rodando no container
- ✅ **Redis** - Cache e filas rodando no container  
- ✅ **Dados** - Persistidos em volumes Docker
- ❌ **Node.js** - Roda direto no Windows (mais rápido para desenvolvimento)

## 🎉 Vantagens desta Configuração:
1. **Fácil Setup** - Só precisa do Docker + Node.js
2. **Ambiente Isolado** - Bancos não "sujam" o Windows
3. **Reset Fácil** - Um comando limpa tudo
4. **Performance** - Node.js roda nativo no Windows
5. **Portabilidade** - Funciona igual em qualquer máquina

---

🚀 **Com Docker é muito mais simples! Menos instalações, menos problemas!**