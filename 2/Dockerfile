FROM ubuntu:latest

RUN apt-get update && apt-get install -y gcc make

WORKDIR /app

COPY app.c .

RUN gcc -o app app.c

CMD ["./app"]