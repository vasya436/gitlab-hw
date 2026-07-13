# Курсовая работа на профессии "DevOps-инженер с нуля"  Василий Ткаченко
Содержание
==========
* [Задача](#Задача)
* [Инфраструктура](#Инфраструктура)
    * [Сайт](#Сайт)
    * [Мониторинг](#Мониторинг)
    * [Логи](#Логи)
    * [Сеть](#Сеть)
    * [Резервное копирование](#Резервное-копирование)
    * [Дополнительно](#Дополнительно)
* [Выполнение работы](#Выполнение-работы)
* [Критерии сдачи](#Критерии-сдачи)
* [Как правильно задавать вопросы дипломному руководителю](#Как-правильно-задавать-вопросы-дипломному-руководителю) 

---------
## Задача
Ключевая задача — разработать отказоустойчивую инфраструктуру для сайта, включающую мониторинг, сбор логов и резервное копирование основных данных. Инфраструктура должна размещаться в [Yandex Cloud](https://cloud.yandex.com/).

**Примечание**: в курсовой работе используется система мониторинга Prometheus. Вместо Prometheus вы можете использовать Zabbix. Задание для курсовой работы с использованием Zabbix находится по [ссылке](https://github.com/netology-code/fops-sysadm-diplom/blob/diplom-zabbix/README.md).

**Перед началом работы над дипломным заданием изучите [Инструкция по экономии облачных ресурсов](https://github.com/netology-code/devops-materials/blob/master/cloudwork.MD).**   

## Инфраструктура
Для развёртки инфраструктуры используйте Terraform и Ansible. 

Параметры виртуальной машины (ВМ) подбирайте по потребностям сервисов, которые будут на ней работать. 

Ознакомьтесь со всеми пунктами из этой секции, не беритесь сразу выполнять задание, не дочитав до конца. Пункты взаимосвязаны и могут влиять друг на друга.

### Сайт
Создайте две ВМ в разных зонах, установите на них сервер nginx, если его там нет. ОС и содержимое ВМ должно быть идентичным, это будут наши веб-сервера.

Используйте набор статичных файлов для сайта. Можно переиспользовать сайт из домашнего задания.

Создайте [Target Group](https://cloud.yandex.com/docs/application-load-balancer/concepts/target-group), включите в неё две созданных ВМ.

Создайте [Backend Group](https://cloud.yandex.com/docs/application-load-balancer/concepts/backend-group), настройте backends на target group, ранее созданную. Настройте healthcheck на корень (/) и порт 80, протокол HTTP.

Создайте [HTTP router](https://cloud.yandex.com/docs/application-load-balancer/concepts/http-router). Путь укажите — /, backend group — созданную ранее.

Создайте [Application load balancer](https://cloud.yandex.com/en/docs/application-load-balancer/) для распределения трафика на веб-сервера, созданные ранее. Укажите HTTP router, созданный ранее, задайте listener тип auto, порт 80.

Протестируйте сайт
`curl -v <публичный IP балансера>:80` 

### Мониторинг
Создайте ВМ, разверните на ней Prometheus. На каждую ВМ из веб-серверов установите Node Exporter и [Nginx Log Exporter](https://github.com/martin-helmich/prometheus-nginxlog-exporter). Настройте Prometheus на сбор метрик с этих exporter.

Создайте ВМ, установите туда Grafana. Настройте её на взаимодействие с ранее развернутым Prometheus. Настройте дешборды с отображением метрик, минимальный набор — Utilization, Saturation, Errors для CPU, RAM, диски, сеть, http_response_count_total, http_response_size_bytes. Добавьте необходимые [tresholds](https://grafana.com/docs/grafana/latest/panels/thresholds/) на соответствующие графики.

### Логи
Cоздайте ВМ, разверните на ней Elasticsearch. Установите filebeat в ВМ к веб-серверам, настройте на отправку access.log, error.log nginx в Elasticsearch.

Создайте ВМ, разверните на ней Kibana, сконфигурируйте соединение с Elasticsearch.

### Сеть
Разверните один VPC. Сервера web, Prometheus, Elasticsearch поместите в приватные подсети. Сервера Grafana, Kibana, application load balancer определите в публичную подсеть.

Настройте [Security Groups](https://cloud.yandex.com/docs/vpc/concepts/security-groups) соответствующих сервисов на входящий трафик только к нужным портам.

Настройте ВМ с публичным адресом, в которой будет открыт только один порт — ssh. Настройте все security groups на разрешение входящего ssh из этой security group. Эта вм будет реализовывать концепцию bastion host. Потом можно будет подключаться по ssh ко всем хостам через этот хост.

### Резервное копирование
Создайте snapshot дисков всех ВМ. Ограничьте время жизни snaphot в неделю. Сами snaphot настройте на ежедневное копирование.

Выполненние курсовой работы

Инфраструктура

Для развёртывания инфраструктуры были использованны Terraform и Ansible.

При помощи terraform в yandex облаке была развёрнута сеть из шести виртуальных машин, 5 из которых ubuntu 22.04 и одна vm Debian 11. Названия vm ubuntu 22.04:

vm-1;

vm-2;

elstic-server;

kibana-server;

bastion;

vm Debian 11:

zabbix-server;

Виртуальные машины vm-1 и vm-2 располагаются в разных зонах
![task10_screenshot](https://raw.githubusercontent.com/vasya436/gitlab-hw/main/img/task10_screenshot.png)

Затем через ansible устанавливаю на сервера vm-1, vm-2 nginx и статические файлы сайта:

![task11_screenshot](https://raw.githubusercontent.com/vasya436/gitlab-hw/main/img/task11_screenshot.png)

Настраиваю файл /etc/nginx/sites-available/

![task12_screenshot](https://raw.githubusercontent.com/vasya436/gitlab-hw/main/img/task12_screenshot.png)

С применением ansible устанавливаю на сервера приложения соответствующие их названиям:

![task13_screenshot](https://raw.githubusercontent.com/vasya436/gitlab-hw/main/img/task13_screenshot.png)

![task14_screenshot](https://raw.githubusercontent.com/vasya436/gitlab-hw/main/img/task14_screenshot.png)

Устанавливаю через ansible, java на vm elastic-server, kibana-server

![task15_screenshot](https://raw.githubusercontent.com/vasya436/gitlab-hw/main/img/task15_screenshot.png)

Использую ansible для установки filebeat на серврера vm-1, vm-2

![task16_screenshot](https://raw.githubusercontent.com/vasya436/gitlab-hw/main/img/task16_screenshot.png)


Установка zabbix на сервере:

Установка PostgreSQL: sudo apt install postgresql

Установка репозиторий Zabbix:

wget https://repo.zabbix.com/zabbix/6.0/debian/pool/main/z/zabbix-release/zabbix-release_6.0-4+debian11_all.deb

dpkg -i zabbix-release_6.0-4+debian11_all.deb

apt update

Установка Zabbix сервера, веб-интерфейса и агента:

apt install zabbix-server-pgsql zabbix-frontend-php php7.4-pgsql zabbix-apache-conf zabbix-sql-scripts zabbix-agent

Создаём базу данных:

sudo -u postgres createuser --pwprompt zabbix
sudo -u postgres createdb -O zabbix zabbix
На хосте Zabbix сервера импортируйте начальную схему и данные. 

Вам будет предложено ввести недавно созданный пароль:

zcat /usr/share/zabbix-sql-scripts/postgresql/server.sql.gz | sudo -u zabbix psql zabbix

Настраиваем базу данных для Zabbix сервера Отредактируем файл /etc/zabbix/zabbix_server.conf: DBPassword=password

Запускаем процессы Zabbix сервера и агента Запускаем процессы Zabbix сервера и агента и настраиваем их запуск при загрузке ОС.

Открываем веб-страницу Zabbix: http://host/zabbix

![task17_screenshot](https://raw.githubusercontent.com/vasya436/gitlab-hw/main/img/task17_screenshot.png)

Устанавливаю на серверах vm-1,vm-2 репозиторий zabbix и устанавливаю zabbix-agent.

Используя terraform настраиваю сеть в соответствии с заданием: Развёрнут один VPC. Сервера web, Elasticsearch помещены в приватные подсети. Сервера Zabbix, Kibana, application load balancer определенны в публичную подсеть.

![task18_screenshot](https://raw.githubusercontent.com/vasya436/gitlab-hw/main/img/task18_screenshot.png)


При помощи системы terraform устанавливаю в созданной инфраструктуре: Target Group, Backend Group, HTTP router, Application load balancer В Target Group включаю две созданных ВМ vm-1, vm-2

![task19_screenshot](https://raw.githubusercontent.com/vasya436/gitlab-hw/main/img/task19_screenshot.png)

![task20_screenshot](https://raw.githubusercontent.com/vasya436/gitlab-hw/main/img/task20_screenshot.png)


С применением terraform настраиваю Security Groups соответствующих сервисов на входящий трафик только к нужным портам

![task21_screenshot](https://raw.githubusercontent.com/vasya436/gitlab-hw/main/img/task21_screenshot.png)

![task22_screenshot](https://raw.githubusercontent.com/vasya436/gitlab-hw/main/img/task22_screenshot.png)

![task23_screenshot](https://raw.githubusercontent.com/vasya436/gitlab-hw/main/img/task23_screenshot.png)

Состояние балансировщика

![task24_screenshot](https://raw.githubusercontent.com/vasya436/gitlab-hw/main/img/task24_screenshot.png)

При введении в браузер публичного адреса балансировщика открывается сайт (статические файлы сайта на vm-1, vm-2)

![task25_screenshot](https://raw.githubusercontent.com/vasya436/gitlab-hw/main/img/task25_screenshot.png)

Через bastion, подключаюсь к виртуальным машинам по их внутренним IP адресам, для настройки конфигурационных файлов:

Настройка конфигурационных файлов ELK и filebeat на серверах


