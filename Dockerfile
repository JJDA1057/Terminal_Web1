FROM wettyoss/wetty:latest

USER root

# Instalar herramientas (Alpine usa apk)
RUN apk update && apk add --no-cache \
    nano \
    vim \
    curl \
    git \
    shadow

# Crear password root
RUN echo "root:root" | chpasswd

ENV PORT=3000

EXPOSE 3000

ENTRYPOINT sh -c "wetty --port=${PORT} --ssh-user=root --ssh-host=localhost"



