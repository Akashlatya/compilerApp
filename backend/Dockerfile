# Use the latest LTS (Long Term Support) Node.js version
FROM node:lts-slim

# Install necessary compilers and tools
RUN apt-get update && apt-get install -y --no-install-recommends \
    openjdk-17-jdk-headless \
    gcc \
    g++ \
    python3 \
    && rm -rf /var/lib/apt/lists/*

# Set the working directory inside the container
WORKDIR /app

# Copy package dependencies first for layer caching
COPY package*.json ./
RUN npm ci --omit=dev

# Copy application source
COPY . .

# Expose the port the app runs on
EXPOSE 3001

# Healthcheck monitoring endpoint
HEALTHCHECK --interval=30s --timeout=5s --start-period=5s --retries=3 \
  CMD node -e "require('http').get('http://localhost:3001/healthz', (res) => process.exit(res.statusCode === 200 ? 0 : 1))"

# Command to run the application
CMD ["node", "index.js"]
