FROM node:14.15.0

WORKDIR /app

ENV PATH /app/node_modules/.bin:$PATH

COPY package.json /app/package.json
RUN npm install
RUN npm install -g @angular/cli@10.2.0

COPY . /app

FROM httpd:latest
RUN rm /usr/local/apache2/htdocs/index.html

RUN sed -i \
  's/#LoadModule rewrite_module modules\/mod_rewrite.so/LoadModule rewrite_module modules\/mod_rewrite.so/g' \
  /usr/local/apache2/conf/httpd.conf

# Append to the published directory, that we want to rewrite any request that is not an actual file
# to the index.html page.
RUN sed -i '/<Directory "\/usr\/local\/apache2\/htdocs">/a### Rewrite rule was written from the Dockerfile when building the image ###\n\
  DirectoryIndex index.html\n\
  RewriteEngine on\n\
  RewriteCond %{REQUEST_FILENAME} -s [OR]\n\
  RewriteCond %{REQUEST_FILENAME} -d\n\
  RewriteRule ^.*$ - [NC,L]\n\
  RewriteRule ^(.*) index.html [NC,L]\n' \
  /usr/local/apache2/conf/httpd.conf

# Comment out the default config that handles requests to /.htaccess and /.ht* with a special error message,
# Angular will handle all routing
RUN sed -i '/<Files "\.ht\*">/,/<\/Files>/c# This was commented out from the Dockerfile\n# <Files ".ht*">\n#     Require all denied\n# <\/Files>' \
  /usr/local/apache2/conf/httpd.conf

RUN sed -i '288s/.*/    Options -Indexes\n/' /usr/local/apache2/conf/httpd.conf

RUN sed -i '/Group daemon/a### Rewrite rule was written from the Dockerfile when building the image ###\n\
  <IfModule mod_headers.c>\n\
  Header set X-XSS-Protection "1; mode=block"\n\
  Header always append X-Frame-Options SAMEORIGIN\n\
  Header set X-Content-Type-Options nosniff\n\
  </IfModule>\n' \
  /usr/local/apache2/conf/httpd.conf

EXPOSE 4200
EXPOSE 80

CMD ["httpd", "-D", "FOREGROUND"]
CMD npm start
CMD ["ng","serve","--host", "0.0.0.0","--port","4200"]