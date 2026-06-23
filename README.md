# Домашнее задание к занятию  "Защита сети"  Василий Ткаченко


### Подготовка к выполнению заданий
Подготовка защищаемой системы:
установите Suricata,
установите Fail2Ban.
Подготовка системы злоумышленника: установите nmap и thc-hydra либо скачайте и установите Kali linux.
Обе системы должны находится в одной подсети.

Задание 1
Проведите разведку системы и определите, какие сетевые службы запущены на защищаемой системе:

sudo nmap -sA < ip-адрес >

sudo nmap -sT < ip-адрес >

sudo nmap -sS < ip-адрес >

sudo nmap -sV < ip-адрес >

По желанию можете поэкспериментировать с опциями: https://nmap.org/man/ru/man-briefoptions.html.

В качестве ответа пришлите события, которые попали в логи Suricata и Fail2Ban, прокомментируйте результат.


![Скриншот задания 2](https://raw.githubusercontent.com/vasya436/gitlab-hw/main/img/task02_screenshot.png)

![Скриншот задания 4](https://github.com/vasya436/gitlab-hw/blob/main/img/task04_screenshot.png)

![Скриншот задания 3](https://github.com/vasya436/gitlab-hw/blob/main/img/task03_screenshot%20(2).png)





sudo nmap -sA 10.0.2.15
sA (ACK scan) это тип сканирования, который проверяет, как хост реагирует на ACK-пакеты. Основная цель - определить, находится ли порт за файрволом
filtered для портов 80 и 443 означает, что файрвол или сетевой экран отбрасывает или блокирует входящие ACK-пакеты.

sudo nmap -sT 10.0.2.15
Это TCP Connect-сканирование (-sT) выявило открытые порты и службы на атакуемом хосте.

sudo nmap -sS 10.0.2.15
SYN-сканирование показало схожие результаты.
Suricata также выявила сканирование.

sudo nmap -sV 192.168.65.136
Version-сканирование показало детальную информацию о сервисах.
Порт Сервис Версия Детали
22/tcp SSH OpenSSH 9.9p1 Ubuntu 3ubuntu3.2
80/tcp HTTP 
53/tcp open domain dnsmask 2.91
Suricata обнаружила Nmap version-сканирование

Fail2ban по умолчанию не предназначен для обнаружения сканирования портов утилитой Nmap. Его основная задача — защита от атак подбора паролей путем анализа логов аутентификации. 
В текущей настройке (из коробки) сканирование Nmap хоста с помощью fai2ban выявлено не было.

    
Задание 2
Проведите атаку на подбор пароля для службы SSH:

hydra -L users.txt -P pass.txt < ip-адрес > ssh

Настройка hydra:
создайте два файла: users.txt и pass.txt;
в каждой строчке первого файла должны быть имена пользователей, второго — пароли. В нашем случае это могут быть случайные строки, но ради эксперимента можете добавить имя и пароль существующего пользователя.
Дополнительная информация по hydra: https://kali.tools/?p=1847.

Включение защиты SSH для Fail2Ban:
открыть файл /etc/fail2ban/jail.conf,
найти секцию ssh,
установить enabled в true.
Дополнительная информация по Fail2Ban:https://putty.org.ru/articles/fail2ban-ssh.html.

В качестве ответа пришлите события, которые попали в логи Suricata и Fail2Ban, прокомментируйте результат.

Настройка hydra. Создадим файлы 
nano users.txt
nano pass.txt

Включим защиту SSH для Fail2Ban в файле /etc/fail2ban/jail.conf на атакуемом хосте.
Осуществим атаку.
hydra -L users.txt -P pass.txt 10.0.2.15 ssh 

3.1. С выключенным fail2ban.
Hydra проверила сочетание всех логинов и паролей. В логе аутентификации атакуемого хоста видим перебор паролей. Suricata выявила сканирование.

![Скриншот задания 5](https://github.com/vasya436/gitlab-hw/blob/main/img/task05_screenshot.png)


С включенным fail2ban.
Соединение и сканирование были сброшены. Ошибка в Kali [ERROR] all children were disabled due too many connection errors. Suricata и Fail2ban обнаружили перебор.



![Скриншот задания 6](https://github.com/vasya436/gitlab-hw/blob/main/img/task06_screenshot.png)












    

---


