FROM postgres:16.1-alpine3.19

ENV POSTGRES_DB=pricetrack
ENV POSTGRES_PASSWORD=1234

COPY ./*.sql /docker-entrypoint-initdb.d/

EXPOSE 5432
