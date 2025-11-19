FROM node:18-bullseye

USER root

# Instalar dependencias necesarias para node-pty / Wetty
RUN apt-get update && apt-get install -y \
    python3 \
    make \
    g++ \
    git \
    openssh-server \
    nano \
    vim \
    curl

# Instalar Wetty globalmente
RUN npm install -g wetty@latest

# Configurar SSH
RUN mkdir /var/run/sshd
RUN echo "root:root" | chpasswd

# Railway asigna este puerto
ENV PORT=3000

EXPOSE 3000

# Comando de inicio
CMD sh -c "\
    service ssh start && \
    wetty --port=$PORT --ssh-host=localhost --ssh-user=root \
"


