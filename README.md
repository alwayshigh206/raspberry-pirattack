Данные скрипты обеспечиввают автоматическое получение адресов для eth0 и делает проброс сети на eth1, перед этим создав отдельную подсеть для данного адаптера (nat+routing.sh)

Cкрипт eth0-eth1-routing.sh скорее для проверки первого, он просто прописывает маршруты с eth0 для eth1. 

dhcp-setup.sh - устанавливает сервер dhcp на интерфейс eth1, соответственно клиент будет автоматически принимать настройки доступа в сеть.

Usage

Для запуска достаточно сделать исполняемым файл run.sh
(chmod +x run.sh)

Запускать обязательно от sudo

#TODO:
доработать dhcp-setup.sh. На данный момезнт скрипт ломает сеть, пока лучше не запускать