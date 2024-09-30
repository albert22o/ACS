# DoD на 3: 
# Вывод названия и версии ОС, версии и архитектуры ядра Linux
echo "Операционная система:"
OS_NAME=$(lsb_release -d | cut -f2-) # lsb_release -d выводит название и версию ОС
CORE_VERSION=$(uname -r) # uname -r версия ядра
ARCHITECTURE=$(uname -m) # uname -m архитектура ядра
echo "ОС и версия: $OS_NAME"
echo "Архитектура ядра: $ARCHITECTURE"
echo "Версия ядра: $CORE_VERSION"

echo  "Информация о процессоре:"
CPU_MODEL=$(lscpu | grep "Model name:" | sed 's/Model name:\s*//')
CPU_FREQ=$(cat /proc/cpuinfo | grep "MHz" | awk '{print $4}' | head -n 1)
CORES_NUM=$(lscpu | grep "^CPU(s):" | awk '{print $2}')
CACHE_SIZE=$(lscpu | grep "^L3 cache:" | sed 's/L3 cache:\s*//')
echo "Модель процессора: $CPU_MODEL"
echo "Частота: $CPU_FREQ MHz"
echo "Количество ядер: $CORES_NUM"
echo "Размер кэша (L3): $CACHE_SIZE"

echo  "Информация о памяти:"
MEMORY_TOTAL=$(free | grep "Mem:" | awk '{print $2}')
MEMORY_USED=$(free | grep "Mem:" | awk '{print $3}')
MEMORY_FREE=$(free | grep "Mem:" | awk '{print $4}')
echo "Общая память: $MEMORY_TOTAL килобайт"
echo "Использованная память: $MEMORY_USED килобайт"
echo "Свободная память: $MEMORY_FREE килобайт"

# DoD на 4: 
# Параметры сетевого соединения (имя, IP/MAC адрес, скорость)
# Создаем цикл для каждого сетевого интерфейса
# grep -oP '(?<=inet\s)\d+(\.\d+){3}' извлекает с помощью регулярного выражения ip
# В iface хранится информация в address о mac адресе, и в speed о скорости (если ничего то вывести unknown)
echo "Сетевые интерфейсы:"
for iface in $(ls /sys/class/net/); do
    echo "Интерфейс: $iface"
    IP_ADDRS=$(ip -4 addr show $iface | grep -oP '(?<=inet\s)\d+(\.\d+){3}')
    # Поддержка систем с более чем одним ip адресом на сетевом интерфейсе
    for ip in $IP_ADDRS; do
        echo "  IP-адрес: $ip"
    done

    MAC_ADDR=$(cat /sys/class/net/$iface/address)
    SPEED=$(cat /sys/class/net/$iface/speed 2>/dev/null || echo "unknown")

    echo "  MAC-адрес: $MAC_ADDR"
    echo "  Скорость: ${SPEED} Mbps"
done

# Информация о системных разделах
# --output=target,size,used,avail выведет информацию, требуемую по заданию 
# target - точка монтирования, size, used, avail - общий, исп., доступный размеры памяти
echo "Системные разделы: "
df -h --output=target,size,used,avail