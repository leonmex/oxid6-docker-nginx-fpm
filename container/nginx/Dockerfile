FROM nginx:1.11

ENV PHP_HOST phpfpm
ENV PHP_PORT 9000
ENV APP_MAGE_MODE default

# prepare entrypoint.d pattern
#RUN mkdir /entrypoint.d
#COPY ./files/entrypoint.sh /entrypoint.sh
#COPY ./entrypoint.d/* /entrypoint.d/
#RUN chmod 777 /entrypoint.sh && chmod 777 /entrypoint.d/*

## nginx stuff
COPY ./conf/nginx.conf /etc/nginx/conf.d/
COPY ./bin/default.conf /etc/nginx/conf.d/
COPY ./bin/start.sh /usr/local/bin/start.sh
COPY ./conf/sites/dev-shop-demo.conf /etc/nginx/sites-enabled/dev-shop-demo.conf

#ENTRYPOINT ["/entrypoint.sh"]

CMD ["/usr/local/bin/start.sh"]
