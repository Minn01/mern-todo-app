# Lightweight Node image
FROM node:22-alpine

# Working directory
WORKDIR /app

# Copy backend dependencies
COPY TODO/todo_backend/package*.json ./TODO/todo_backend/

# Install backend dependencies
RUN cd TODO/todo_backend && npm install

# Copy frontend dependencies
COPY TODO/todo_frontend/package*.json ./TODO/todo_frontend/

# Install frontend dependencies
RUN cd TODO/todo_frontend && npm install

# Copy application source
COPY TODO ./TODO

# Build React frontend
RUN cd TODO/todo_frontend && npm run build

# Move React build into backend static folder
RUN rm -rf TODO/todo_backend/static/build && \
    mkdir -p TODO/todo_backend/static && \
    mv TODO/todo_frontend/build TODO/todo_backend/static/

# Move to backend directory
WORKDIR /app/TODO/todo_backend

# Application port
EXPOSE 5000

# Start server
CMD ["npm","start"]