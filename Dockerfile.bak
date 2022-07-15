FROM node:14-alpine as build-atc

# Creamos una carpeta llamada APP
RUN mkdir -p /app

# Asignamos la carpeta app para realizar las operaciones
WORKDIR /app

# Copiamos todas las dependencias
COPY package.json /app

# Instalamos todas las dependencias
RUN npm install
RUN npm install -g @angular/cli@10.2.0
RUN npm uninstall ng2-pdf-viewer
RUN npm install ng2-pdf-viewer@5.2.1
RUN npm i @types/node@14.14.31 -D
RUN npm rebuild node-sass/ts-xlsx/lib/main.d.ts

# Copiamos todos los archivos de la ruta actual a APP
COPY . /app

# Compilamos el proyecto
RUN node --max_old_space_size=8192 node_modules/@angular/cli/bin/ng build  --prod --base-href "/" #--deploy-url "https://dev-psecuritycmb.wposs.com/"

## Segunda etapa

FROM nginx:latest

COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80 443 4200
CMD ["nginx", "-g", "daemon off;"]