FROM node:14.15.0

#actualizamos paquetes
RUN apt update -y 

#actualizamos paquetes
RUN apt upgrade -y

#install nginx
RUN apt install -y nginx

COPY nginx.conf /etc/nginx/conf.d/default.conf

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

#RUN npm i @types/node@14.14.31 -D
#RUN npm rebuild node-sass/ts-xlsx/lib/main.d.ts
#RUN npm audit fix --force

# Copiamos todos los archivos de la ruta actual a APP
COPY . /app

EXPOSE 4200 80 443
CMD npm start
CMD ["nginx", "-g", "daemon off;"]
CMD ["ng","serve","--host", "0.0.0.0","--port","4200"]