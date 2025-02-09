# ---- STAGE 1: Build ----
    FROM node:22.13.1-slim AS builder
    WORKDIR /app
    
    # Instala pnpm globalmente
    RUN npm install -g pnpm@8.14.0
    
    # Copia arquivos de dependências
    COPY package.json pnpm-lock.yaml ./
    RUN pnpm install --frozen-lockfile
    
    # Copia o restante do código
    COPY . .
    
    # Constrói o projeto (Ex.: Nest, TypeScript, etc.)
    RUN pnpm run build
    
    # ---- STAGE 2: Production ----
    FROM node:22.13.1-slim
    WORKDIR /app
    
    # (Opcional) Instala o OpenSSL para evitar avisos do Prisma com Alpine ou Slim
    RUN apt-get update && apt-get install -y openssl
    
    # Instala pnpm globalmente na imagem final
    RUN npm install -g pnpm@8.14.0
    
    # Copia apenas os arquivos de dependências para instalar somente as deps de produção
    COPY package.json pnpm-lock.yaml ./
    RUN pnpm install --prod --frozen-lockfile
    
    # Copia apenas o código compilado da primeira etapa
    COPY --from=builder /app/dist ./dist
    
    # Copia também a pasta "prisma" e o schema.prisma da fase builder
    COPY --from=builder /app/prisma ./prisma
    
    # Se "prisma" (CLI) estiver em devDependencies, ela não virá com --prod.
    # Portanto, ou mova "prisma" e "@prisma/client" para "dependencies" no package.json,
    # ou substitua o comando acima por `pnpm install --frozen-lockfile` (instalando tudo).
    # Ao menos "@prisma/client" deve estar em dependencies para funcionar em runtime.
    
    EXPOSE 3334
    CMD ["node", "dist/main.js"]
    