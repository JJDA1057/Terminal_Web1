FROM node:18-bullseye

USER root

RUN apt-get update && apt-get install -y \
    python3 make g++ git openssh-server nano vim curl

RUN npm install -g wetty@latest

# --- SSH CONFIG ---
RUN mkdir /var/run/sshd
RUN echo "root:root" | chpasswd

# Habilitar root + password login
RUN sed -i 's/PermitRootLogin.*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config
RUN sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config

ENV PORT=3000

EXPOSE 3000

CMD sh -c "\
    service ssh start && \
    sleep 2 && \
    wetty --port=$PORT --ssh-host=127.0.0.1 --ssh-user=root "

