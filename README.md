# Домашнее задание к занятию  "Работа с данными (DDL/DML)"  Василий Ткаченко


### Задание можно выполнить как в любом IDE, так и в командной строке.

Задание 1
1.1. Поднимите чистый инстанс MySQL версии 8.0+. Можно использовать локальный сервер или контейнер Docker.

1.2. Создайте учётную запись sys_temp.

1.3. Выполните запрос на получение списка пользователей в базе данных. (скриншот)

1.4. Дайте все права для пользователя sys_temp.

1.5. Выполните запрос на получение списка прав для пользователя sys_temp. (скриншот)

1.6. Переподключитесь к базе данных от имени sys_temp.

Для смены типа аутентификации с sha2 используйте запрос:

ALTER USER 'sys_test'@'localhost' IDENTIFIED WITH mysql_native_password BY 'password';
1.6. По ссылке https://downloads.mysql.com/docs/sakila-db.zip скачайте дамп базы данных.

1.7. Восстановите дамп в базу данных.

1.8. При работе в IDE сформируйте ER-диаграмму получившейся базы данных. При работе в командной строке используйте команду для получения всех таблиц базы данных. (скриншот)

Результатом работы должны быть скриншоты обозначенных заданий, а также простыня со всеми запросами.
Решение:

1.1 Используем базу через Docker контейнер:

![Описание скриншота](https://github.com/vasya436/gitlab-hw/blob/main/img/task01_screenshot.png)

1.2 Создадим учётную запись sys_temp:

![Скриншот задания 2: результат выполнения](https://raw.githubusercontent.com/vasya436/gitlab-hw/main/img/task02_screenshot.png)

1.3 Выполним запрос на получение списка пользователей 
1.4 Назначим все права пользователю sys_temp:

![Скриншот задания 3](https://raw.githubusercontent.com/vasya436/gitlab-hw/main/img/task03_screenshot.png)

1.5 Выведем список прав для пользователя sys_temp:

![Скриншот задания 4](https://raw.githubusercontent.com/vasya436/gitlab-hw/main/img/task04_screenshot.png)

1.6 Переподключимся к базе от имени sys_temp:

![Скриншот задания 5](https://raw.githubusercontent.com/vasya436/gitlab-hw/main/img/task05_screenshot.png)

1.7 Восстановим базу:

![Скриншот задания 6](https://raw.githubusercontent.com/vasya436/gitlab-hw/main/img/task06_screenshot.png)

![Скриншот задания 7](https://raw.githubusercontent.com/vasya436/gitlab-hw/main/img/task07_screenshot.png)

1.8 Построим ER-диаграмму получившейся базы данных

![Скриншот задания 8](https://raw.githubusercontent.com/vasya436/gitlab-hw/main/img/task08_screenshot.png)


---

Задание 2
Составьте таблицу, используя любой текстовый редактор или Excel, в которой должно быть два столбца: в первом должны быть названия таблиц восстановленной базы, во втором названия первичных ключей этих таблиц. Пример: (скриншот/текст)

Название таблицы | Название первичного ключа
customer         | customer_id

Решение

| Название таблицы | Название первичного ключа |
|---------------|-----------------------|
| actor | actor_id |
| address | address_id |
| category | category_id |
| city | city_id |
| country | country_id |
| customer | customer_id |
| film | film_id |
| film_actor | actor_id |
| film_actor | film_id |
| film_category | film_id |
| film_category | category_id |
| film_text | film_id |
| inventory | inventory_id |
| language | language_id |
| payment | payment_id |
| rental | rental_id |
| staff | staff_id |
| store | store_id |







```





