### STAGE 1: Build ###
FROM node:20-alpine AS builder
WORKDIR /usr/src/app
COPY package.json ./
RUN npm install
COPY . .
RUN npm run build

### STAGE 2: Run ###
# Stage 2: Serve app with nginx server
# Use official nginx image as the base image
FROM nginx:latest

COPY ./nginx.conf /etc/nginx/conf.d/default.conf


COPY --from=builder /usr/src/app/dist/test-l /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]