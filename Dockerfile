# Usar Debian como base
FROM debian:latest

# Actualizar el sistema e instalar Apache y Node.js
RUN apt-get update && apt-get install -y \
apache2 \
nodejs \
npm \
&& apt-get clean

# Instalar Angular CLI globalmente
RUN npm install -g @angular/cli

# Copiar el código de la aplicación Angular al contenedor
WORKDIR /app
COPY . /app

# Construir la aplicación Angular
RUN npm install && ng build --prod --output-path=/var/www/html

# Exponer el puerto 80 para Apache
EXPOSE 80

# Iniciar el servicio Apache en el contenedor
CMD ["apachectl", "-D", "FOREGROUND"]