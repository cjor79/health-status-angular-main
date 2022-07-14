FROM node:14.15.0

WORKDIR /app

ENV PATH /app/node_modules/.bin:$PATH

COPY package.json /app/package.json
RUN npm install
RUN npm install -g @angular/cli@10.2.0

COPY . /app
## Segunda etapa

FROM nginx:1.19.2

COPY ssl/STAR_wposs_com.crt /etc/ssl/STAR_wposs_com.crt
COPY ssl/wposs_com.key /etc/ssl/wposs_com.key

COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=build-atc /app/dist/babylon /usr/share/nginx/html

EXPOSE 4200
EXPOSE 80 443

CMD ["nginx", "-g", "daemon off;"]
CMD npm start
CMD ["ng","serve","--host", "0.0.0.0","--port","4200"]