FROM node:14.15.0

WORKDIR /app

ENV PATH /app/node_modules/.bin:$PATH

COPY package.json /app/package.json
RUN npm install
RUN npm install -g @angular/cli@10.2.0

COPY . /app

EXPOSE 4200
EXPOSE 80

CMD npm start
CMD ["ng","serve","--host", "54.204.101.213","--port","4200"]