Данные скрипты обеспечиввают автоматическое получение адресов для eth0 и делает проброс сети на eth1, перед этим создав отдельную подсеть для данного адаптера (nat+routing.sh)

Cкрипт eth0-eth1-routing.sh скорее для проверки первого, он просто прописывает маршруты с eth0 для eth1. 

Таким образом, применение run.sh превращает наш Rapsberry Pi в небольшой роутер (особенно если юзать свитч) с большим количеством ОЗУ, мощным процессором и Kali Linux на борту.

wap-config.sh (в разработке) - устанавливает hostapd, настраивает маршруты с wlan1 на eth0 (для раздачи интернета) и поднимает DHCP-сервер для выдачи IP-адресов клиентам точки доступа. После создает точку доступа WI-FI с помощью hostapd
На данный момент точка доступа работает не стабильно с адаптером awus036nha. Причину не выяснил, драйвера должны подходить из коробки. Возможно, стоит рассмотреть альтернативу hostapd, но в целом функция WI-FI Access Point не является приоритетной.

Usage

Для запуска достаточно сделать исполняемым файл run.sh
(chmod +x run.sh)

Запускать обязательно от sudo