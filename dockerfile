FROM node:alpine3.16 as nodework
WORKDIR /myapp
COPY package.json .
RUN npm install
COPY . .
RUN npm run build


FROM nginx:1.23-alpine
WORKDIR /usr/share/nginx/html
RUN rm -rf ./*
COPY --from=nodework /myapp/build .
COPY nginx.conf /etc/nginx/nginx.conf

RUN chmod 755 /etc/nginx/nginx.conf
CMD exec nginx -g "daemon off;"




# ENTRYPOINT ["nginx","-g","daemon off;"]



# docker-compose build
# docker-compose up
# docker-compose up --build -d

# SAVE DOCKER IMAGE 
# docker save -o react-docker-image.tar 0161c7e6eaa4
