FROM mcr.microsoft.com/mssql/server:2017-latest-ubuntu

RUN mkdir -p /import
# RUN mkdir -p /var/opt/mssql/backup

WORKDIR /import

# copiar tot a import
COPY scripts.tar.gz /import/
# COPY Aliga3.bak /var/opt/mssql/backup

# Descomprimir els fitxers
RUN tar xvfz /import/scripts.tar.gz
RUN chmod +x /import/importar.sh
RUN chmod +x /import/entrypoint.sh

EXPOSE 1433

CMD ./entrypoint.sh
