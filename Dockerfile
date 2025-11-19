FROM wettyoss/wetty:latest

# Instalar dependencias usando apk
RUN apk update && apk add openssh-server nano vim curl git shadow

# Crear directorio para SSH
RUN mkdir -p /var/run/sshd

# Establecer contraseña root
RUN echo "root:root" | chpasswd

# Activar login root y autenticación por contraseña
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config

# Exponer puertos necesarios
EXPOSE 22 3000

# Comando de inicio
CMD /usr/sbin/sshd && wetty --ssh-host=root@localhost
