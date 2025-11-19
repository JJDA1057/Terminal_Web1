FROM wettyoss/wetty:latest

# Instalar paquetes usando apk porque la imagen es Alpine
RUN apk update && apk add openssh nano vim curl git shadow

# Crear carpeta de SSH
RUN mkdir -p /var/run/sshd

# Crear contraseña root
RUN echo "root:root" | chpasswd

# Habilitar login root por SSH
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config

# Exponer puertos
EXPOSE 22 3000

# Iniciar SSH + Wetty
CMD service ssh start && wetty --ssh-host=root@localhost
