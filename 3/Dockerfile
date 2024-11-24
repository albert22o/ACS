# Используем официальный образ Ubuntu в качестве базового
FROM ubuntu:latest

# Устанавливаем необходимые пакеты
RUN apt-get update && apt-get install -y \
    openssh-server \
    python3 \
    python3-pip \
    sudo 

RUN useradd -m -s /bin/bash user && echo "user:password" | chpasswd \
&& mkdir /home/user/.ssh && chmod 700 /home/user/.ssh \
&& usermod -aG sudo user

# Копируем публичный ключ в контейнер
COPY id_rsa.pub /root/.ssh/authorized_keys
RUN chmod 600 /root/.ssh/authorized_keys \
    && chown -R user:root /home/user/.ssh


RUN echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config \
&& echo "PermitRootLogin no" >> /etc/ssh/sshd_config \
&& echo "AllowUsers user" >> /etc/ssh/sshd_config

RUN mkdir /var/run/sshd

# Открываем порт 22 для SSH
EXPOSE 22

# Запуск SSH сервера
CMD ["/usr/sbin/sshd", "-D"]
