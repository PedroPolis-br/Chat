# 🐳 Comandos Docker - Atendechat

## 🚀 Scripts Automatizados

| Script | Função |
|--------|---------|
| `SETUP_DOCKER.bat` | Configuração completa inicial |
| `DOCKER_INICIAR.bat` | Iniciar containers |
| `DOCKER_PARAR.bat` | Parar containers |
| `DOCKER_LOGS.bat` | Visualizar logs |

## 📋 Comandos Manuais Úteis

### Gerenciamento de Containers
```bash
# Ver containers rodando:
docker ps

# Ver todos os containers (incluindo parados):
docker ps -a

# Iniciar containers:
cd codatendechat-main\backend
docker-compose up -d

# Parar containers:
docker-compose down

# Parar e remover dados:
docker-compose down -v

# Reiniciar containers:
docker-compose restart

# Recriar containers:
docker-compose up -d --force-recreate
```

### Logs e Monitoramento
```bash
# Logs do PostgreSQL:
docker logs atendechat-postgres

# Logs do Redis:
docker logs atendechat-redis

# Logs de todos os containers:
docker-compose logs

# Logs em tempo real:
docker-compose logs -f

# Últimas 50 linhas dos logs:
docker logs --tail 50 atendechat-postgres
```

### Acesso aos Bancos
```bash
# Conectar no PostgreSQL:
docker exec -it atendechat-postgres psql -U atendechat_user -d atendechat

# Comandos SQL úteis:
\l                    # Listar bancos
\dt                   # Listar tabelas
\q                    # Sair

# Conectar no Redis:
docker exec -it atendechat-redis redis-cli

# Autenticar no Redis:
AUTH redis_password123

# Comandos Redis úteis:
ping                  # Testar conexão
keys *                # Listar chaves
info                  # Informações do servidor
exit                  # Sair
```

### Backup e Restore
```bash
# Backup do PostgreSQL:
docker exec atendechat-postgres pg_dump -U atendechat_user atendechat > backup.sql

# Restore do PostgreSQL:
docker exec -i atendechat-postgres psql -U atendechat_user atendechat < backup.sql

# Backup dos dados Redis:
docker exec atendechat-redis redis-cli --rdb /data/dump.rdb
```

### Limpeza e Manutenção
```bash
# Remover containers parados:
docker container prune

# Remover volumes não utilizados:
docker volume prune

# Remover imagens não utilizadas:
docker image prune

# Limpeza completa (cuidado!):
docker system prune -a

# Ver espaço utilizado:
docker system df
```

### Troubleshooting
```bash
# Verificar saúde dos containers:
docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"

# Inspecionar container:
docker inspect atendechat-postgres

# Executar comando dentro do container:
docker exec -it atendechat-postgres bash

# Ver recursos utilizados:
docker stats

# Reiniciar Docker daemon (se necessário):
# Reinicie o Docker Desktop
```

### Reset Completo
```bash
# Parar tudo:
docker-compose down -v

# Remover containers:
docker rm atendechat-postgres atendechat-redis

# Remover volumes:
docker volume rm $(docker volume ls -q | grep atendechat)

# Iniciar novamente:
docker-compose up -d

# Executar migrações:
npx sequelize db:migrate
npx sequelize db:seed:all
```

## 🔧 Configurações dos Containers

### PostgreSQL
- **Image:** postgres:15
- **Container:** atendechat-postgres
- **Porta:** 5432
- **Usuário:** atendechat_user
- **Senha:** atendechat_password
- **Banco:** atendechat

### Redis
- **Image:** redis:7-alpine
- **Container:** atendechat-redis  
- **Porta:** 6379
- **Senha:** redis_password123

## 📊 Monitoramento

### Verificar se está tudo funcionando:
```bash
# 1. Containers rodando:
docker ps --filter "name=atendechat"

# 2. PostgreSQL aceitando conexões:
docker exec atendechat-postgres pg_isready -U atendechat_user

# 3. Redis respondendo:
docker exec atendechat-redis redis-cli ping

# 4. Teste de conectividade:
docker exec atendechat-postgres psql -U atendechat_user -d atendechat -c "SELECT 1;"
```

---

💡 **Dica:** Mantenha sempre o Docker Desktop rodando antes de usar qualquer comando!