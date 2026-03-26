# Домашнее задание к занятию «Кластеризация и балансировка нагрузки»

### Задание 1

Запустите два simple python сервера на своей виртуальной машине на разных портах
Установите и настройте HAProxy, воспользуйтесь материалами к лекции по ссылке
Настройте балансировку Round-robin на 4 уровне.
На проверку направьте конфигурационный файл haproxy, скриншоты, где видно перенаправление запросов на разные серверы при обращении к HAProxy.


Решение:


![Описание скриншота](https://github.com/vasya436/gitlab-hw/blob/main/img/task1_screenshot.png)



![Описание скриншота задания 2](https://github.com/vasya436/gitlab-hw/blob/main/img/task2_screenshot.png)

конфигурационный файл haproxy:

https://raw.githubusercontent.com/netology-code/sys-pattern-homework/296a94dd35d031cf5adfebac1ca7c3e827a69307/haproxy.cfg

---

### Задание 2

Запустите три simple python сервера на своей виртуальной машине на разных портах
Настройте балансировку Weighted Round Robin на 7 уровне, чтобы первый сервер имел вес 2, второй - 3, а третий - 4
HAproxy должен балансировать только тот http-трафик, который адресован домену example.local
На проверку направьте конфигурационный файл haproxy, скриншоты, где видно перенаправление запросов на разные серверы при обращении к HAProxy c использованием домена example.local и без него.


    
![Скриншот задания 3: перенос VIP‑адреса](https://github.com/vasya436/gitlab-hw/blob/main/img/task3_screenshot.png)

![Скриншот задания 5](https://github.com/vasya436/gitlab-hw/blob/main/img/task5_screenshot.png)

![Task 4 Screenshot](https://github.com/vasya436/gitlab-hw/blob/main/img/task4_screenshot.png)


конфигурационный файл haproxy:

https://raw.githubusercontent.com/netology-code/sys-pattern-homework/e51f2bd8e6738bb0d816be976b87f06d86a3f441/haproxy_2.cfg










```





