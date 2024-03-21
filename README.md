#  Курсовая работа на профессии "DevOps-инженер с нуля"

---------
## Задача
Ключевая задача — разработать отказоустойчивую инфраструктуру для сайта, включающую мониторинг, сбор логов и резервное копирование основных данных. Инфраструктура должна размещаться в [Yandex Cloud](https://cloud.yandex.com/).

### Сайт
Cоздаем Instance Group с двумя ВМ , для которой настроим следующие правила автоматического горизонтального масштабирования: минимальное количество ВМ на зону — 1, максимальный размер группы — 3.

![2.jpg](./img/2.jpg)
![3.jpg](./img/3.jpg)

Создаем Target Group, Backend Group, HTTP router, Application load balancer:

![4.jpg](./img/4.jpg)
![6.jpg](./img/6.jpg)
Протестируем сайт`curl -v <публичный IP балансера>:80`: 
Сайт доступен по ссылке - http://158.160.131.212

![5.jpg](./img/5.jpg)

### Логи
Cоздаем две ВМ - c Elasticsearch и с Kibana ( доступ по ссылке http://158.160.129.45:5601/ ). Устанавливаем и настраиваем filebeat на все ВМ согласно заданию.

![7.jpg](./img/7.jpg)

### Мониторинг
Для Zabbix реализуем разделение компонент - frontend(доступ по ссылке http://158.160.150.147/zabbix/ ), server, database. 

![8.jpg](./img/8.jpg)
![9.jpg](./img/9.jpg)
![13.jpg](./img/13.jpg)
### Сеть
Реализуем концепцию bastion host используя NAT instance:
![1.jpg](./img/1.jpg)
![10.jpg](./img/10.jpg)
![11.jpg](./img/11.jpg)

### Резервное копирование
![12.jpg](./img/12.jpg)








