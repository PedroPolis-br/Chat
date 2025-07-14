# 🚀 Guia Completo de Instalação - Atendechat no Windows

Este é um guia detalhado para configurar e rodar o projeto **Atendechat** no Windows.

## 📋 Pré-requisitos

### 1. Instalar Node.js v20.x
1. Acesse: https://nodejs.org/
2. Baixe a versão **20.x LTS** 
3. Execute o instalador e siga as instruções
4. Verifique a instalação:
```bash
node --version
npm --version
```

### 2. Instalar Git
1. Acesse: https://git-scm.com/download/win
2. Baixe e instale o Git for Windows
3. Durante a instalação, mantenha as opções padrão

### 3. Instalar PostgreSQL
1. Acesse: https://www.postgresql.org/download/windows/
2. Baixe o PostgreSQL 14+ 
3. Durante a instalação:
   - **Porta:** 5432 (padrão)
   - **Username:** postgres
   - **Anote a senha** que você definir (será usada depois)
4. Certifique-se que o serviço PostgreSQL está rodando

### 4. Instalar Redis (usando Docker Desktop)
1. Instale o Docker Desktop: https://www.docker.com/products/docker-desktop/
2. Abra o Docker Desktop e aguarde inicializar
3. Abra o **PowerShell como Administrador** e execute:
```bash
docker run --name redis-atendechat -p 6379:6379 --restart always -d redis redis-server --requirepass MinhaRedisPassword123
```

### 5. Instalar Editor de Código (Recomendado)
- **VS Code**: https://code.visualstudio.com/

## 🔧 Configuração do Projeto

### 1. Clonar/Extrair o Projeto
Se você já tem o arquivo zip (como no seu caso):
```bash
# Navegue até a pasta onde está o projeto
cd C:\caminho\para\seu\projeto\codatendechat-main
```

### 2. Configurar o Banco PostgreSQL
1. Abra o **pgAdmin** (instalado junto com PostgreSQL)
2. Conecte com o usuário `postgres` e a senha que você definiu
3. Crie um novo banco de dados:
   - Nome: `atendechat`
   - Owner: `postgres`

**OU** via linha de comando:
```bash
# Abra o cmd e execute:
psql -U postgres -h localhost
CREATE DATABASE atendechat;
\q
```

### 3. Configurar Variáveis de Ambiente

#### Backend (.env)
Navegue até a pasta `backend` e crie o arquivo `.env`:
```bash
cd backend
```

Crie o arquivo `.env` com o seguinte conteúdo:
```env
NODE_ENV=development
BACKEND_URL=http://localhost:8080
FRONTEND_URL=http://localhost:3000
PROXY_PORT=443
PORT=8080

DB_DIALECT=postgres
DB_HOST=localhost
DB_PORT=5432
DB_USER=postgres
DB_PASS=SuaSenhaPostgreSQL
DB_NAME=atendechat

JWT_SECRET=MinhaChaveSecretaJWT123456789
JWT_REFRESH_SECRET=MinhaChaveRefreshJWT987654321

REDIS_URI=redis://:MinhaRedisPassword123@127.0.0.1:6379
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

**⚠️ IMPORTANTE:** Substitua:
- `SuaSenhaPostgreSQL` pela senha que você definiu no PostgreSQL
- `MinhaRedisPassword123` pela senha do Redis (se mudou)
- As configurações de email pelos seus dados reais

#### Frontend (.env)
Navegue até a pasta `frontend` e crie o arquivo `.env`:
```bash
cd ..\frontend
```

Crie o arquivo `.env` com:
```env
REACT_APP_BACKEND_URL=http://localhost:8080
REACT_APP_HOURS_CLOSE_TICKETS_AUTO=24
```

## 📦 Instalação das Dependências

### 1. Instalar dependências do Backend
```bash
cd backend
npm install --force
```

Se houver erro com TypeScript, execute:
```bash
npm install -g typescript
npm install -g ts-node
```

### 2. Instalar dependências do Frontend
```bash
cd ..\frontend
npm install --force
```

## 🗄️ Configuração do Banco de Dados

### 1. Executar Migrações
```bash
cd ..\backend
npx sequelize db:migrate
```

### 2. Executar Seeds (dados iniciais)
```bash
npx sequelize db:seed:all
```

Se der erro, tente:
```bash
npm run db:migrate
npm run db:seed
```

## 🚀 Executando o Projeto

### 1. Iniciar o Backend
Abra um terminal na pasta `backend`:
```bash
cd backend
npm run dev:server
```

O backend estará rodando em: **http://localhost:8080**

### 2. Iniciar o Frontend
Abra um **NOVO** terminal na pasta `frontend`:
```bash
cd frontend
npm start
```

O frontend estará rodando em: **http://localhost:3000**

## 🔍 Verificações e Troubleshooting

### Verificar se Redis está rodando:
```bash
docker ps
```
Deve aparecer o container `redis-atendechat`

### Verificar se PostgreSQL está rodando:
- Abra o **Gerenciador de Tarefas**
- Procure por `postgres.exe` nos processos

### Problemas Comuns:

#### 1. Erro de conexão com PostgreSQL
- Verifique se o serviço PostgreSQL está rodando
- Confirme se a senha no `.env` está correta
- Teste a conexão:
```bash
psql -U postgres -h localhost -d atendechat
```

#### 2. Erro de conexão com Redis
- Verifique se o Docker Desktop está rodando
- Reinicie o container Redis:
```bash
docker restart redis-atendechat
```

#### 3. Erro nas migrações
- Confirme que o banco `atendechat` existe
- Execute as migrações uma por vez:
```bash
npx sequelize db:migrate:status
npx sequelize db:migrate
```

#### 4. Porta já em uso
Se a porta 8080 ou 3000 estiver em uso:
- Para o backend, mude a variável `PORT` no `.env`
- Para o frontend, o React perguntará se quer usar outra porta

#### 5. Erro de permissões Node.js
Execute o PowerShell como Administrador e:
```bash
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope LocalMachine
```

## 📱 Acessando o Sistema

1. **Frontend:** http://localhost:3000
2. **Backend API:** http://localhost:8080

### Credenciais Padrão (após seeds):
- **Email:** admin@atendechat.com
- **Senha:** 123456

## 🔄 Para Parar os Serviços

- **Backend/Frontend:** `Ctrl + C` no terminal
- **Redis:** `docker stop redis-atendechat`
- **PostgreSQL:** Através do pgAdmin ou Services do Windows

## 📞 Suporte

Se ainda assim tiver problemas:

1. Verifique os logs nos terminais
2. Confirme se todas as portas estão liberadas (8080, 3000, 5432, 6379)
3. Reinicie os serviços Docker e PostgreSQL
4. Certifique-se que o Windows Defender não está bloqueando as conexões

---

🎉 **Parabéns!** Se chegou até aqui, o Atendechat deve estar funcionando perfeitamente no seu Windows!