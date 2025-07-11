# 🔧 TROUBLESHOOTING - Soluções para Problemas Comuns

## ❌ Problemas de Instalação

### 1. "npm install" falhando
**Sintomas:** Erros durante `npm install`
```bash
# Soluções:
npm cache clean --force
npm install --force
# ou
npm install --legacy-peer-deps
```

### 2. Erro de permissão no Windows
**Sintomas:** "Execution of scripts is disabled"
```powershell
# Execute no PowerShell como Administrador:
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope LocalMachine
```

### 3. TypeScript não encontrado
**Sintomas:** "tsc is not recognized"
```bash
npm install -g typescript
npm install -g ts-node
```

## 🗄️ Problemas de Banco de Dados

### 1. Erro de conexão PostgreSQL
**Sintomas:** "connect ECONNREFUSED 127.0.0.1:5432"

**Soluções:**
- ✅ Verificar se PostgreSQL está rodando
- ✅ Conferir senha no arquivo `.env`
- ✅ Testar conexão:
```bash
psql -U postgres -h localhost -d atendechat
```

### 2. Banco "atendechat" não existe
**Sintomas:** "database atendechat does not exist"

**Solução:**
```sql
-- No pgAdmin ou terminal psql:
CREATE DATABASE atendechat;
```

### 3. Erro nas migrações
**Sintomas:** Falha em `npx sequelize db:migrate`

**Soluções:**
```bash
# Verificar status das migrações:
npx sequelize db:migrate:status

# Reverter e tentar novamente:
npx sequelize db:migrate:undo:all
npx sequelize db:migrate

# Criar banco manualmente se necessário:
npx sequelize db:create
```

## 🐳 Problemas com Redis/Docker

### 1. Redis não conecta
**Sintomas:** "connect ECONNREFUSED 127.0.0.1:6379"

**Soluções:**
```bash
# Verificar se container está rodando:
docker ps

# Reiniciar container:
docker restart redis-atendechat

# Recriar container:
docker stop redis-atendechat
docker rm redis-atendechat
docker run --name redis-atendechat -p 6379:6379 --restart always -d redis redis-server --requirepass MinhaRedisPassword123
```

### 2. Docker Desktop não iniciando
**Sintomas:** Docker não abre ou trava

**Soluções:**
- ✅ Reiniciar o computador
- ✅ Verificar se Hyper-V está habilitado (Windows)
- ✅ Executar Docker como Administrador

## 🚀 Problemas de Execução

### 1. Porta já em uso
**Sintomas:** "Port 3000/8080 is already in use"

**Soluções:**
```bash
# Windows - matar processo na porta:
netstat -ano | findstr :3000
taskkill /PID [PID_NUMBER] /F

# Ou mudar a porta no .env:
# Backend: PORT=8081
# Frontend: irá perguntar se quer usar outra porta
```

### 2. Backend não inicia
**Sintomas:** Erro ao executar `npm run dev:server`

**Checklist:**
- ✅ Arquivo `.env` existe e está configurado
- ✅ PostgreSQL está rodando
- ✅ Redis está rodando
- ✅ Banco "atendechat" existe
- ✅ Migrações foram executadas

### 3. Frontend não carrega
**Sintomas:** Página em branco ou erro 404

**Soluções:**
- ✅ Verificar se backend está rodando primeiro
- ✅ Conferir se REACT_APP_BACKEND_URL está correto no `.env`
- ✅ Limpar cache do npm:
```bash
npm start -- --reset-cache
```

### 4. Erro de autenticação/login
**Sintomas:** Não consegue fazer login

**Soluções:**
```bash
# Executar seeds novamente:
cd backend
npx sequelize db:seed:all

# Credenciais padrão:
# Email: admin@atendechat.com
# Senha: 123456
```

## 🌐 Problemas de Rede

### 1. "Network Error" no frontend
**Sintomas:** Erro ao conectar com backend

**Checklist:**
- ✅ Backend rodando em http://localhost:8080
- ✅ CORS configurado corretamente
- ✅ Firewall não bloqueando conexões

### 2. WhatsApp não conecta
**Sintomas:** QR Code não aparece

**Soluções:**
- ✅ Verificar configurações de rede
- ✅ Aguardar alguns minutos
- ✅ Reiniciar backend

## 🔍 Comandos de Diagnóstico

### Verificar se serviços estão rodando:
```bash
# PostgreSQL (Windows):
sc query postgresql-x64-14

# Verificar portas em uso:
netstat -ano | findstr :3000
netstat -ano | findstr :8080
netstat -ano | findstr :5432
netstat -ano | findstr :6379

# Testar conexão Redis:
docker exec -it redis-atendechat redis-cli
> AUTH MinhaRedisPassword123
> ping
```

### Logs de erro:
- ✅ Verificar terminal do backend para erros
- ✅ Verificar terminal do frontend para erros
- ✅ Verificar logs do Docker: `docker logs redis-atendechat`

## 📞 Último Recurso

Se nada funcionar:

1. 🔄 **Reset completo:**
```bash
# Parar todos os serviços
# Deletar node_modules e reinstalar
cd backend
rm -rf node_modules
npm install --force

cd ../frontend
rm -rf node_modules
npm install --force
```

2. 🗄️ **Recriar banco:**
```sql
DROP DATABASE atendechat;
CREATE DATABASE atendechat;
```

3. 🐳 **Recriar Redis:**
```bash
docker stop redis-atendechat
docker rm redis-atendechat
# Executar comando de criação novamente
```

4. 🆘 **Verificar arquivos de log** para mensagens de erro específicas

---

💡 **Dica:** Sempre mantenha os terminais abertos para ver mensagens de erro em tempo real!