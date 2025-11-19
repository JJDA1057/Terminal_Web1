FROM wettyoss/wetty:latest

USER root

# Instalar herramientas (ALPINE usa apk)
RUN apk update && apk add --no-cache \
    nano \
    vim \
    curl \
    git \
    shadow

# Crear password para root
RUN echo "root:root" | chpasswd

# Railway usa esta variable
ENV PORT=3000

EXPOSE 3000

# Iniciar wetty
CMD ["sh", "-c", "wetty --port=$PORT --ssh-user=root --ssh-host=localhost"]


