# Use official Node.js runtime
FROM node:22-alpine

# Set the working directory
WORKDIR /jim-app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the app
COPY . .

# Build the application
RUN npm run build

# Expose the port
EXPOSE 3000

# Start the application
CMD ["npm", "run", "start:prod"]
