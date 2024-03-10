FROM postgres:16.1-alpine3.19

COPY ./db.init.sql /docker-entrypoint-initdb.d/

EXPOSE 5432
