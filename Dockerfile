FROM node:22.12.0-alpine3.21 AS builder

# Instala o pnpm globalmente
RUN npm install -g pnpm

WORKDIR /app

# Copia apenas os arquivos de configuração do projeto para aproveitar o cache
COPY package.json pnpm-lock.yaml* ./

# Instala as dependências usando pnpm
RUN pnpm install --frozen-lockfile

# Copia o restante do código-fonte
COPY . .

# Build da aplicação
RUN pnpm build

# ------------------------------------------------------------------------
FROM node:22.12.0-alpine3.21 AS runtime

# Instala o pnpm globalmente também no estágio de runtime, caso precise rodar algo no container final
RUN npm install -g pnpm

WORKDIR /app

# Copia node_modules (opcional, se for rodar a aplicação a partir do build)
COPY --from=builder /app/node_modules ./node_modules

# Copia a pasta dist gerada pelo build
COPY --from=builder /app/dist ./dist

# Copia outros arquivos necessários (se tiver configurações extras)
# COPY --from=builder /app/prisma ./prisma

# Inicia a aplicação
CMD ["node", "dist/main.js"]
