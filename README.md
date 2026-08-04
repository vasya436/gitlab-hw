# Домашнее задание к занятию «Инструменты Git» 

Цель задания

В результате выполнения задания вы:

    научитесь работать с утилитами Git;
    потренируетесь решать типовые задачи, возникающие при работе в команде.

Инструкция к заданию

    Склонируйте репозиторий с исходным кодом Terraform.
    Создайте файл для ответов на задания в своём репозитории, после выполнения прикрепите ссылку на .md-файл с ответами в личном кабинете.
    Любые вопросы по решению задач задавайте в разделе "Вопросы по заданию".

Задание

В клонированном репозитории:

    Найдите полный хеш и комментарий коммита, хеш которого начинается на aefea.
    Ответьте на вопросы.

    Какому тегу соответствует коммит 85024d3?
    Сколько родителей у коммита b8d720? Напишите их хеши.
    Перечислите хеши и комментарии всех коммитов, которые были сделаны между тегами v0.12.23 и v0.12.24.
    Найдите коммит, в котором была создана функция func providerSource, её определение в коде выглядит так: func providerSource(...) (вместо троеточия перечислены аргументы).
    Найдите все коммиты, в которых была изменена функция globalPluginDirs.
    Кто автор функции synchronizedWriters?

В качестве решения ответьте на вопросы и опишите, как были получены эти ответы.

    В личном кабинете отправьте на проверку ссылки на ваши репозитории.
    Любые вопросы по решению задач задавайте в разделе "Вопросы по заданию".
    
1. aefead2207ef7e2aa5dc81a34aedf0cad4c32545 хэш комментарий -Update CHANGELOG.md

   git log --format="%H %s" | grep "^aefea"

2. коммит 85024d3 соответствует тэгу v0.12.23
v0.12.24
v0.12.25
v0.12.26
v0.12.27
v0.12.28
v0.12.29
v0.12.30
v0.12.31
 
git tag --contains 85024d3

3. у коммита b8d720 2 родителей: b8d720
   
56cd7859e05c36c06b56d013b55a252d0bb7e158 9ea88f22fc6269854151c571162c5bcf958bee2b

git show --format="%P" -s b8d720

4. Перечислите хеши и комментарии всех коммитов, которые были сделаны между тегами v0.12.23 и v0.12.24

   git log v0.12.23..v0.12.24 --format="%H %s"
   
| Commit Hash | Message |
| --- | --- |
| `33ff1c03bb960b332be3af2e333462dde88b279e` | v0.12.24 |
| `b14b74c4939dcab573326f4e3ee2a62e23e12f89` | [Website] vmc provider links |
| `3f235065b9347a758efadc92295b540ee0a5e26e` | Update CHANGELOG.md |
| `6ae64e247b332925b872447e9ce869657281c2bf` | registry: Fix panic when server is unreachable |
| `5c619ca1baf2e21a155fcdb4c264cc9e24a2a353` | website: Remove links to the getting started guide's old location |
| `06275647e2b53d97d4f0a19a0fec11f6d69820b5` | Update CHANGELOG.md |
| `d5f9411f5108260320064349b757f55c09bc4b80` | command: Fix bug when using terraform login on Windows |
| `4b6d06cc5dcb78af637bbb19c198faff37a066ed` | Update CHANGELOG.md |
| `dd01a35078f040ca984cdd349f18d0b67e486c35` | Update CHANGELOG.md |
| `225466bc3e5f35baa5d07197bbc079345b77525e` | Cleanup after v0.12.23 release |

5. Найдите коммит, в котором была создана функция func providerSource(...)
   
 команда - git show $(git log -S "func providerSource" --format=%H | tail -1)

   8c928e83589d90a031f811fae52a81be7153e82f

6. Найдите все коммиты, в которых была изменена функция globalPluginDirs

   команда -  git log -p -S "globalPluginDirs"

   commit 7c4aeac5f30aed09c5ef3198141b033eea9912be

7. Кто автор функции synchronizedWriters

   найти коммит, где функция впервые появилась
   команда - git log -S "synchronizedWriters" --format="%H" | tail -1

commit 5ac311e2a91e381e2f52234668b49ba670aa0fe5

получить автора:

команда - git show --format="%an <%ae>" $(git log -S "synchronizedWriters" --format=%H | tail -1)
   
Martin Atkins <mart@degeneration.co.uk>
   







---------
## 
