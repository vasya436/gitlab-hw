
# Домашнее задание к занятию «Продвинутые методы работы с Terraform»  Василий Ткаченко

### Задание 1

1. Возьмите из [демонстрации к лекции готовый код](https://github.com/netology-code/ter-homeworks/tree/main/04/demonstration1) для создания ВМ с помощью remote-модуля.
2. Создайте одну ВМ, используя этот модуль. В файле cloud-init.yml необходимо использовать переменную для ssh-ключа вместо хардкода. Передайте ssh-ключ в функцию template_file в блоке vars ={} .
Воспользуйтесь [**примером**](https://grantorchard.com/dynamic-cloudinit-content-with-terraform-file-templates/). Обратите внимание, что ssh-authorized-keys принимает в себя список, а не строку.
3. Добавьте в файл cloud-init.yml установку nginx.
4. Предоставьте скриншот подключения к консоли и вывод команды ```sudo nginx -t```.

### Решение 1

1. Склонировал код из демонстрации, изучал его.

2. Создаю одну ВМ используя модуль. Чтобы создать именно одну ВМ потребовалось указать параметр ```instance_count  = 1``` в модуле ```test-vm```.

Чтобы передать ssh-ключ используя функцию template_file пишу в блок vars следующий код:

![Img 1](https://github.com/vasya436/gitlab-hw/raw/main/img/img_1.png)

Использую такую конструкцию именно потому, что в задании указано условие, что переменная authorized-keys должна принимать в себя список, а не строку.

Сама переменная ssh-authorized-keys выглядит следующим образом:

![Img 2](https://github.com/vasya436/gitlab-hw/raw/main/img/img_2.png)

3. Чтобы установить nginx на хост используя cloud-init.yml, нужно в секцию ```packages``` добавить строку ``` - nginx```. В нашем случае после запуска виртуальной машины выполняются следующие действия: обновляется кэш пакетов системы, устанавливается текстовый редактор vim и устанавливается nginx.

Проверяю, что nginx установился:

![Img 4](https://github.com/vasya436/gitlab-hw/raw/main/img/img_4.png)

------

### Задание 2

1. Напишите локальный модуль vpc, который будет создавать 2 ресурса: **одну** сеть и **одну** подсеть в зоне, объявленной при вызове модуля, например: ```ru-central1-a```.
2. Вы должны передать в модуль переменные с названием сети, zone и v4_cidr_blocks.
3. Модуль должен возвращать в root module с помощью output информацию о yandex_vpc_subnet. Пришлите скриншот информации из terraform console о своем модуле. Пример: > module.vpc_dev  
4. Замените ресурсы yandex_vpc_network и yandex_vpc_subnet созданным модулем. Не забудьте передать необходимые параметры сети из модуля vpc в модуль с виртуальной машиной.
5. Откройте terraform console и предоставьте скриншот содержимого модуля. Пример: > module.vpc_dev.
6. Сгенерируйте документацию к модулю с помощью terraform-docs.    
 
Пример вызова

```
module "vpc_dev" {
  source       = "./vpc"
  env_name     = "develop"
  zone = "ru-central1-a"
  cidr = "10.0.1.0/24"
}
```

### Решение 2

1. Написал локальный модуль с одной сетью и одной подсетью в зоне ```ru-central1-a```.

2. В модуле используются переменные с именем сети, зоны и cidr блок:

![Img 5 (1)](https://github.com/vasya436/gitlab-hw/raw/main/img/img_5%20(1).png)

3. В terraform console проверю, какой output будет показан при вызове модуля ```module.vpc_dev```:

![Img 6](https://github.com/vasya436/gitlab-hw/raw/main/img/img_6.png)

4. Заменил сетевые ресурсы созданным модулем:

![Img 7 (1)](https://github.com/vasya436/gitlab-hw/raw/main/img/img_7%20(1).png)

5. В root модуле написал следующий output:

![Img 8 (2)](https://github.com/vasya436/gitlab-hw/raw/main/img/img_8%20(2).png)

Вывод ```module.vpc_dev``` не изменился:

![Img 9](https://github.com/vasya436/gitlab-hw/raw/main/img/img_9.png)

6. С помощью terraform-docs сгенерировал файл документации.

![Img 10](https://github.com/vasya436/gitlab-hw/raw/main/img/img_10.png)

### Задание 3
1. Выведите список ресурсов в стейте.
2. Полностью удалите из стейта модуль vpc.
3. Полностью удалите из стейта модуль vm.
4. Импортируйте всё обратно. Проверьте terraform plan. Изменений быть не должно.
Приложите список выполненных команд и скриншоты процессы.

### Решение 3

1. Текущий список ресурсов в стейте:

![Img 11 (1)](https://github.com/vasya436/gitlab-hw/raw/main/img/img_11%20(1).png)

2. Полностью удалил из стейта модуль vpc_dev:

![Img 12 (1)](https://github.com/vasya436/gitlab-hw/raw/main/img/img_12(1).png)

3. Полностью удалил из стейта модуль test-vm:

![Img 13](https://github.com/vasya436/gitlab-hw/raw/main/img/img_13.png)

4. Обратно импортирую удаленные стейты:

![Img 40](https://github.com/vasya436/gitlab-hw/raw/main/img/img_40.png)

Аналогично импортирую остальные стейты:

![Img 41 (1)](https://github.com/vasya436/gitlab-hw/raw/main/img/img_41%20(1).png)


![Img 42](https://github.com/vasya436/gitlab-hw/raw/main/img/img_42.png)

После импортирования модулей изменений не последовало.




