FROM ubuntu:22.04

# Instalar dependencias para poder usar repos oficiales de Node
RUN apt-get update && apt-get install -y curl openssh-server nano vim git

# Instalar Node 18 (necesario para Wetty)
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - \
    && apt-get install -y nodejs

# Crear directorio SSH
RUN mkdir /var/run/sshd

# Habilitar login root
RUN echo "root:root" | chpasswd \
    && sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# Instalar Wetty global
RUN npm install -g wetty@latest

# Exponer el puerto (Railway usa PORT)
EXPOSE 3000

# Inicializar SSH y luego Wetty
CMD service ssh start && \
    wetty --port $PORT --ssh-host=root@localhost --base-path /wetty


