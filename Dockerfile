# Use the official Node.js 14 image as the base image
FROM node:20

# Set the working directory inside the container
WORKDIR /app

# Copy package.json and package-lock.json to the working directory
COPY package*.json ./

# Install the app dependencies
RUN npm install --production

# Copy the rest of the app source code to the working directory
COPY . .

copy .env .env

Run npm run build

# Expose the port on which the app will run
EXPOSE 8000

# Start the app
CMD ["npm", "run", "start"]