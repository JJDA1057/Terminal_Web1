FROM wettyoss/wetty:latest

# Instalar herramientas útiles
USER root
RUN apt-get update && apt-get install -y \
    nano \
    vim \
    curl \
    git \
    passwd \
    && rm -rf /var/lib/apt/lists/*

# Crear contraseña del root (Wetty usa SSH interno)
RUN echo "root:root" | chpasswd

# Variable de puerto requerida por Railway
ENV PORT=3000

# Exponer el puerto
EXPOSE 3000

# Iniciar Wetty
CMD ["sh", "-c", "wetty --port=$PORT --ssh-user=root --ssh-host=localhost"]


