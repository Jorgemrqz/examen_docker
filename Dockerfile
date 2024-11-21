# Usa la imagen base de Debian
FROM debian:latest

# Actualiza el sistema e instala dependencias necesarias
RUN apt-get update && apt-get install -y \
apache2 \
curl \
build-essential \
&& apt-get clean

# Instala Node.js y npm
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - \
&& apt-get install -y nodejs

# Instala Angular CLI globalmente
RUN npm install -g @angular/cli

# Crea un directorio para la aplicación Angular
WORKDIR /usr/src/app

# Copia los archivos de la aplicación Angular al contenedor
COPY . /usr/src/app

# Construye la aplicación Angular
RUN npm install && ng build --prod

# Copia los archivos estáticos generados por Angular a la carpeta de Apache
RUN cp -r /usr/src/app/dist/* /var/www/html/

#puerto 80
EXPOSE 80

# Inicia Apache en el contenedor
CMD ["apachectl", "-D", "FOREGROUND"]