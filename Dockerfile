# ---- STAGE 1: Build ----
    FROM node:22.13.1-slim AS builder
    WORKDIR /app
    
    # Instala pnpm globalmente sem usar corepack
    RUN npm install -g pnpm@8.14.0
    
    # Copia apenas os arquivos de dependências para otimizar cache do Docker
    COPY package.json pnpm-lock.yaml ./
    RUN pnpm install --frozen-lockfile
    
    # Copia o restante do código e executa o build
    COPY . .
    RUN pnpm run build
    
    # ---- STAGE 2: Production ----
    FROM node:22.13.1-slim
    WORKDIR /app
    
    # Instala pnpm globalmente na imagem final
    RUN npm install -g pnpm@8.14.0
    
    # Copia apenas os arquivos de dependências para instalar apenas as dependências de produção
    COPY package.json pnpm-lock.yaml ./
    RUN pnpm install --prod --frozen-lockfile
    
    # Copia apenas o código compilado da primeira etapa
    COPY --from=builder /app/dist ./dist
    
    # Define a porta que será exposta
    EXPOSE 3334
    
    # Comando para iniciar o serviço
    CMD ["node", "dist/main.js"]
    