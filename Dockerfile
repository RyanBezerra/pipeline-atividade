# Dockerfile para AdminLTE
FROM node:18-alpine AS builder

# Definir diretório de trabalho
WORKDIR /app

# Copiar arquivos de dependências
COPY package*.json ./

# Instalar dependências
RUN npm ci --only=production

# Copiar código fonte
COPY . .

# Construir aplicação
RUN npm run production

# Estágio de produção
FROM nginx:alpine

# Copiar arquivos construídos
COPY --from=builder /app/dist /usr/share/nginx/html
COPY --from=builder /app/docs_html /usr/share/nginx/html/docs

# Copiar configuração personalizada do nginx
COPY nginx.conf /etc/nginx/nginx.conf

# Expor porta
EXPOSE 80

# Comando de inicialização
CMD ["nginx", "-g", "daemon off;"]