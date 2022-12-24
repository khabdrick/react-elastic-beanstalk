# FROM node AS build
# WORKDIR /app
# COPY package*.json ./
# RUN npm install
# COPY . .
# RUN npm run build

# FROM nginx:alpine AS prod
# WORKDIR /usr/share/nginx/html
# COPY --from=prod /app/build .
# EXPOSE 80
# # run nginx with global directives and daemon off
# ENTRYPOINT ["nginx", "-g", "daemon off;"]


FROM node:17.1-alpine as build-stage
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build


FROM nginx:latest as prod-stage
COPY --from=build-stage /app/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]