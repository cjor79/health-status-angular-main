FROM node:14.15.0

WORKDIR /app

ENV PATH /app/node_modules/.bin:$PATH

COPY package.json /app/package.json
RUN npm install
RUN npm install -g @angular/cli@10.2.0

COPY . /app
## Segunda etapa

FROM nginx:1.19.2

COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 4200
EXPOSE 80 443

CMD ["nginx", "-g", "daemon off;"]
CMD npm start
CMD ["ng","serve","--host", "0.0.0.0","--port","4200"]