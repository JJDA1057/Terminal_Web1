FROM node:18-alpine

USER root

# Instalar dependencias necesarias
RUN apk update && apk add --no-cache \
    nano \
    vim \
    curl \
    git \
    shadow \
    openssh

# Instalar Wetty global
RUN npm install -g wetty@latest

# Crear usuario root con contraseña
RUN echo "root:root" | chpasswd

# Habilitar SSH dentro del contenedor
RUN ssh-keygen -A

# Railway asigna PORT automáticamente
ENV PORT=3000

EXPOSE 3000

# Iniciar SSH y luego Wetty
CMD sh -c "\
    /usr/sbin/sshd && \
    wetty --port=${PORT} --ssh-user=root --ssh-host=localhost \
"



