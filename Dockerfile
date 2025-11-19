FROM ubuntu:22.04

# Actualizar e instalar dependencias
RUN apt-get update && apt-get install -y \
    openssh-server \
    nodejs \
    npm \
    curl \
    nano \
    vim \
    git

# Crear directorio para SSH
RUN mkdir /var/run/sshd

# Crear contraseña root
RUN echo "root:root" | chpasswd

# Permitir login con root
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# Instalar Wetty
RUN npm install -g wetty@latest

# Exponer puerto web
EXPOSE 3000

# Iniciar SSH + Wetty
CMD service ssh start && \
    wetty --port $PORT --ssh-host=root@localhost

