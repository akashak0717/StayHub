# ================================
# Stage 1: Install dependencies
# ================================
FROM node:22-alpine AS dependencies

WORKDIR /app

# Copy package files
COPY app/package*.json ./

# Install dependencies
RUN npm ci --omit=dev


# ================================
# Stage 2: Production image
# ================================
FROM node:22-alpine AS production

WORKDIR /app

# Copy installed dependencies from Stage 1
COPY --from=dependencies /app/node_modules ./node_modules

# Copy application source code
COPY app/ .

# Production environment
ENV NODE_ENV=production

# Application port
EXPOSE 8081

# Start application
CMD ["npm", "start"]