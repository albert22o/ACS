#include <stdio.h>
#include <signal.h>
#include <unistd.h>
#include <stdlib.h>

// Функция обработчика сигнала
void signal_handler(int signal) {
    if (signal == SIGQUIT) {
        printf("Получен сигнал SIGTERM, завершение работы.\n");
        exit(0);
    } else if (signal == SIGUSR1) {
        printf("Получен пользовательский сигнал SIGUSR1.\n");
    } else {
        printf("Получен сигнал: %d\n", signal);
    }
}

int main() {
    // Назначаем обработчики сигналов
    signal(SIGQUIT, signal_handler);
    signal(SIGUSR1, signal_handler);

    printf("Приложение запущено, PID: %d\n", getpid());

    // Бесконечный цикл для имитации работы
    while (1) {
        printf("Приложение работает...\n");
        sleep(5);
    }

    return 0;
}
