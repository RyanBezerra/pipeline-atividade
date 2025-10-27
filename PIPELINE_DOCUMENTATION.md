# Pipeline CI/CD - AdminLTE Project

## 📋 Visão Geral

Este projeto implementa uma pipeline CI/CD completa para o AdminLTE utilizando GitHub Actions, Docker e GitFlow. A pipeline automatiza todo o processo de desenvolvimento, desde a análise de código até o deploy em produção.

## 🏗️ Arquitetura da Pipeline

### Branches e GitFlow

```
main (produção)
├── develop (desenvolvimento)
│   ├── feature/nova-funcionalidade
│   ├── feature/correcao-bug
│   └── feature/melhoria-ui
├── release/v1.0.0
└── hotfix/correcao-critica
```

### Workflows Implementados

1. **CI/CD Principal** (`.github/workflows/ci-cd.yml`)
2. **GitFlow** (`.github/workflows/gitflow.yml`)
3. **Docker** (`.github/workflows/docker.yml`)
4. **Testes** (`.github/workflows/testing.yml`)
5. **Documentação** (`.github/workflows/documentation.yml`)

## 🚀 Workflows Detalhados

### 1. CI/CD Principal

**Triggers:**
- Push para branches: `main`, `develop`, `feature/*`, `hotfix/*`, `release/*`
- Pull Requests para `main` e `develop`

**Jobs:**

#### Code Quality
- ✅ ESLint (análise de JavaScript)
- ✅ Stylelint (análise de CSS/SCSS)
- ✅ Verificação de lockfile
- ✅ Upload de resultados para artifacts

#### Build and Test
- ✅ Build de produção (`npm run production`)
- ✅ Execução de testes (`npm run test`)
- ✅ Verificação de tamanho do bundle
- ✅ Upload de arquivos de build

#### Security Scan
- ✅ Auditoria de segurança NPM (`npm audit`)
- ✅ Verificação de vulnerabilidades

#### Deploy
- ✅ Deploy automático para staging (branch `develop`)
- ✅ Deploy automático para produção (branch `main`)
- ✅ Notificações de deploy

#### Create Release
- ✅ Criação automática de releases
- ✅ Geração de changelog
- ✅ Upload de assets

### 2. GitFlow Workflow

**Funcionalidades:**
- ✅ Iniciar nova feature (`feature-start`)
- ✅ Finalizar feature (`feature-finish`)
- ✅ Iniciar release (`release-start`)
- ✅ Finalizar release (`release-finish`)
- ✅ Iniciar hotfix (`hotfix-start`)
- ✅ Finalizar hotfix (`hotfix-finish`)
- ✅ Criação automática de Pull Requests

**Como usar:**
1. Acesse a aba "Actions" no GitHub
2. Selecione "GitFlow Workflow"
3. Clique em "Run workflow"
4. Escolha a ação desejada
5. Preencha os parâmetros necessários

### 3. Docker Workflow

**Funcionalidades:**
- ✅ Build multi-stage da imagem Docker
- ✅ Push para GitHub Container Registry
- ✅ Análise de vulnerabilidades com Trivy
- ✅ Deploy automático baseado na branch
- ✅ Limpeza de imagens antigas

**Imagens geradas:**
- `ghcr.io/ryanbezerra/pipeline-atividade:main` (produção)
- `ghcr.io/ryanbezerra/pipeline-atividade:develop` (staging)
- `ghcr.io/ryanbezerra/pipeline-atividade:latest` (última versão)

### 4. Testing Workflow

**Tipos de teste:**
- ✅ Testes unitários
- ✅ Testes de performance
- ✅ Testes de compatibilidade de navegadores
- ✅ Testes de segurança
- ✅ Relatório final de testes

**Execução:**
- Push para branches de feature
- Pull Requests
- Agendamento semanal (segundas-feiras às 2h)

### 5. Documentation Workflow

**Funcionalidades:**
- ✅ Build da documentação com Jekyll
- ✅ Validação HTML
- ✅ Deploy para GitHub Pages
- ✅ Geração automática de changelog
- ✅ Análise de qualidade da documentação

## 🐳 Containerização

### Dockerfile

```dockerfile
# Multi-stage build
FROM node:18-alpine AS builder
# ... configuração de build

FROM nginx:alpine
# ... configuração de produção
```

### Docker Compose

**Serviços:**
- `adminlte`: Produção (porta 8080)
- `adminlte-dev`: Desenvolvimento (porta 8081)
- `nginx-exporter`: Monitoramento (porta 9113)

**Comandos:**
```bash
# Produção
docker-compose up -d

# Desenvolvimento
docker-compose --profile dev up -d

# Com monitoramento
docker-compose --profile monitoring up -d
```

## 🔧 Configuração do Nginx

**Otimizações implementadas:**
- ✅ Compressão gzip
- ✅ Cache de arquivos estáticos
- ✅ Headers de segurança
- ✅ Health check endpoint
- ✅ Configuração para SPA

## 📊 Monitoramento e Métricas

### Métricas coletadas:
- ✅ Tempo de build
- ✅ Taxa de sucesso dos testes
- ✅ Vulnerabilidades de segurança
- ✅ Tamanho dos bundles
- ✅ Performance da aplicação

### Dashboards:
- GitHub Actions (execuções)
- GitHub Packages (imagens Docker)
- GitHub Pages (documentação)

## 🚦 Estados da Pipeline

### ✅ Sucesso
- Todos os testes passaram
- Build executado com sucesso
- Deploy realizado
- Documentação atualizada

### ❌ Falha
- Testes falharam
- Vulnerabilidades críticas encontradas
- Build falhou
- Deploy falhou

### ⚠️ Aviso
- Vulnerabilidades moderadas
- Testes de performance com problemas
- Documentação com problemas menores

## 🔐 Segurança

### Medidas implementadas:
- ✅ Auditoria automática de dependências
- ✅ Análise de vulnerabilidades com Trivy
- ✅ Headers de segurança no Nginx
- ✅ Verificação de lockfile
- ✅ Secrets management no GitHub

### Secrets necessários:
- `GITHUB_TOKEN` (automático)
- Tokens de deploy (se necessário)
- Credenciais de serviços externos

## 📈 Métricas de Performance

### Tempos médios de execução:
- Code Quality: ~2 minutos
- Build and Test: ~5 minutos
- Security Scan: ~1 minuto
- Docker Build: ~8 minutos
- Deploy: ~3 minutos

### Otimizações:
- ✅ Cache de dependências NPM
- ✅ Cache de layers Docker
- ✅ Execução paralela de jobs
- ✅ Artifacts para reutilização

## 🛠️ Comandos Úteis

### GitFlow Manual
```bash
# Iniciar feature
git checkout develop
git checkout -b feature/nova-funcionalidade

# Finalizar feature
git checkout develop
git merge --no-ff feature/nova-funcionalidade

# Iniciar release
git checkout develop
git checkout -b release/v1.0.0

# Finalizar release
git checkout main
git merge --no-ff release/v1.0.0
git tag -a v1.0.0 -m "Release v1.0.0"
```

### Docker
```bash
# Build local
docker build -t adminlte .

# Executar localmente
docker run -p 8080:80 adminlte

# Usar Docker Compose
docker-compose up -d
```

### Desenvolvimento
```bash
# Instalar dependências
npm ci

# Desenvolvimento
npm run dev

# Build de produção
npm run production

# Testes
npm run test
```

## 📚 Recursos Adicionais

### Links úteis:
- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [Docker Documentation](https://docs.docker.com/)
- [GitFlow Documentation](https://nvie.com/posts/a-successful-git-branching-model/)
- [AdminLTE Documentation](https://adminlte.io/docs/3.2/)

### Troubleshooting:
- Verificar logs dos workflows no GitHub Actions
- Validar configuração do Docker
- Verificar permissões dos secrets
- Consultar documentação específica de cada ferramenta

## 🎯 Próximos Passos

### Melhorias futuras:
- [ ] Integração com Kubernetes
- [ ] Testes E2E automatizados
- [ ] Monitoramento com Prometheus/Grafana
- [ ] CDN para arquivos estáticos
- [ ] Backup automático
- [ ] Rollback automático em caso de falha

---

**Desenvolvido por:** Ryan Bezerra  
**Data:** $(date)  
**Versão:** 1.0.0
