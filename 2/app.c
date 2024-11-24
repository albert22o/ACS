#include <stdio.h>
#include <signal.h>
#include <unistd.h>
#include <stdlib.h>

//обработчика сигнала
void signal_handler(int signal) {
    if (signal == SIGTERM) {
        printf("Получен сигнал SIGTERM\n");
        exit(0);
    } else if (signal == SIGINT) {
        printf("Получен сигнал SIGINT\n");
        exit(0);
    } else {
        printf("Получен сигнал: %d\n", signal);
    }
}

int main() {
    signal(SIGTERM, signal_handler);
    signal(SIGINT, signal_handler);

    printf("Приложение запущено, PID: %d\n", getpid());

    while (1) {
        sleep(1);
    }

    return 0;
}
