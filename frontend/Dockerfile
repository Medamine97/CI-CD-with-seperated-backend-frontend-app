# Use an official Node.js runtime as a parent image
FROM node:14-alpine AS build

# Set the working directory
WORKDIR /app

# Copy package.json and package-lock.json
COPY /frontend/package*.json /app/

# Install dependencies
RUN npm install

# Copy the rest of the application code
COPY /frontend/ /app/

# Build the application
RUN npm run build --configuration=production

# Use an official Nginx image to serve the frontend
FROM nginx:alpine

# Copy the build output to the Nginx html directory
COPY --from=build /app/dist/angular-ecommerce /usr/share/nginx/html

# Copy the nginx.conf to configure the nginx
COPY --from=build /app/nginx.conf /etc/nginx/nginx.conf
 
# Expose port 80
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]