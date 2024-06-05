# Use node image as base
FROM node:20

# Set working directory
WORKDIR /app

# Copy the rest of the application to the container
COPY . .

# Install dependencies
RUN npm install

# Expose port 4000
EXPOSE 4000

# Command to run the server
CMD ["npm", "run", "dev", "--", "--host"]
