FROM wettyoss/wetty:latest

# Instalar utilidades opcionales
RUN apk update && apk add nano vim curl git shadow

# Crear contraseña root
RUN echo "root:root" | chpasswd

# Exponer puertos
EXPOSE 3000

# Iniciar Wetty (usa el ssh interno de la imagen base)
CMD wetty --ssh-host=root@localhost
