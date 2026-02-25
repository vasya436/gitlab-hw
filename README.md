# Домашнее задание к занятию "GitLab" - Ткаченко Василий

### Задание 1

Задание 1

Что нужно сделать:

Разверните GitLab локально, используя Vagrantfile и инструкции, описанные в этом репозитории.
Создайте новый проект и пустой репозиторий в нём.
Зарегистрируйте gitlab-runner для этого проекта и запустите его в режиме Docker. Раннер можно зарегистрировать и запустить на той же виртуальной машине, на которой запущен GitLab.

В качестве ответа добавьте в репозиторий шаблона с решением скриншоты с настройками раннера в проекте.

Решение:

вход в GitLab
<img width="861" height="472" alt="task_result" src="https://github.com/user-attachments/assets/0ae657f4-399c-4935-9c8b-062aaf91bcaf" />

Настройка Runner

<img width="812" height="583" alt="task_result_v3" src="https://github.com/user-attachments/assets/76322b72-b3b6-43f4-854b-270210a8c482" />

<img width="717" height="590" alt="task_result_v2" src="https://github.com/user-attachments/assets/983f0d0f-49a4-47dc-92ea-cd54fd2f40dc" />



---

### Задание 2
Что нужно сделать:

Запустите репозиторий на GitLab, изменив origin. Это мы проходили на занятии по Git.
Создайте файл .gitlab-ci.yml, описав в нём все необходимые, на ваш взгляд, этапы.

В качестве ответа добавьте в шаблон с решением:

Создайте файл gitlab-ci.yml для своего проекта или вставьте код в соответствующее поле в шаблоне;
Скриншоты успешно собранных сборок.


<img width="625" height="302" alt="task_result_v4" src="https://github.com/user-attachments/assets/9fcfdc70-ecee-4e42-b5f4-5062da7dae9b" />
<img width="804" height="511" alt="task_result_v5" src="https://github.com/user-attachments/assets/f2d0d031-28e8-49e1-ac8b-368816082d06" />
<img width="802" height="337" alt="task_result_v6" src="https://github.com/user-attachments/assets/9e609d04-b7a1-4cea-9f1c-6c5b81ef4b89" />


```
stages:
  - test
  - build

test:
  stage: test
  image: golang:1.17
  script: 
   - go test .
  tags:
    - my-runner

build:
  stage: build
  image: docker:latest
  script:
   - docker build .
  tags:
     - my-runner



