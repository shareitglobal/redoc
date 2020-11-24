FROM node as builder

WORKDIR /opt
COPY . /opt

RUN yarn
RUN yarn build

FROM nginx

RUN echo 'Europe/Helsinki' > /etc/timezone
RUN ln -sf /usr/share/zoneinfo/Europe/Helsinki /etc/localtime

WORKDIR /usr/share/nginx/html
COPY --from=builder /opt/build  /usr/share/nginx/html
