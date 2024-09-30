# Используем официальный образ Ubuntu в качестве базы
FROM ubuntu:latest

# Устанавливаем необходимые пакеты для компиляции C-приложений
RUN apt-get update && apt-get install -y gcc make

# Копируем исходный код приложения в контейнер
COPY app.c /usr/src/app.c

# Переходим в рабочую директорию
WORKDIR /usr/src

# Компилируем приложение
RUN gcc -o app app.c

# Устанавливаем точку входа для контейнера
ENTRYPOINT ["/usr/src/app"]
