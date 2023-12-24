#!/bin/bash

date=$(date "+%Y.%m.%d %H:%M:%S")
interface=$1
ip_address=$2
netmask=$3
gateway=$4
dns_server="8.8.8.8"
log_file="./log_file_network"

echo "Дата: $date" >> $log_file
echo "Параметры: $interface $ip_address $netmask $gateway" >> $log_file

if ! ifconfig "$interface" &> /dev/null; then
    echo "Ошибка: Интерфейс $interface не найден" >> $log_file
    exit 1
fi

if ! ifconfig "$interface" "$ip_address" netmask "$netmask" &> /dev/null ; then
    echo "Ошибка при установке IP-адреса и маски подсети" >> $log_file
    exit 1
fi

if ! ip route change default via $gateway dev $interface &> /dev/null ; then
    echo "Ошибка при установке шлюза" >> $log_file
    exit 1
fi

if ! echo "nameserver $dns_server" > /etc/resolv.conf; then
    echo "Oшибка при установке DNS-сервера" >> $log_file
    exit 1
fi

#service network-manager stop &> /dev/null

if ! ifconfig "$interface" down && ifconfig "$interface" up &> /dev/null ; then
    echo "Ошибка при перезапуске сетевого интерфейса" >> $log_file
    exit 1
fi

#service network-manager start &> /dev/null

echo "Состояние: Сетевые параметры успешно настроены" >> $log_file
exit 0


