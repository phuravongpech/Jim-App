# Use official Node.js runtime
FROM node:22-alpine

# Set the working directory
WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install --omit-dev

# Copy the rest of the app
COPY . .

# Build the application
RUN npm run build

# Expose the port
EXPOSE 3000
