# Use Node.js LTS (Long Term Support) version
FROM node:20-slim

# Create app directory
WORKDIR /app

# Install app dependencies
# Copy package files first to leverage Docker cache
COPY package*.json ./

# Install dependencies with production flag
RUN npm ci --only=production

# Copy app source
COPY . .

# Create a non-root user
RUN addgroup --system appgroup && adduser --system --group appgroup appuser
USER appuser

# Expose the port the app runs on
EXPOSE 3000

# Set environment variables
ENV NODE_ENV=production

# Command to run the application
CMD ["node", "server.js"] 