# Stage 1: Build the Node.js application
FROM node:14 AS build
WORKDIR /muthu
COPY *.json ./
RUN npm install
COPY . .
RUN npm run build

# Stage 2: Create the Nginx container and copy the build output
FROM nginx:alpine
COPY --from=build /muthu/build/ /usr/share/nginx/html/
CMD ["nginx", "-g", "daemon off;"]