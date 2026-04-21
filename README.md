### Hexlet tests and linter status:
[![Actions Status](https://github.com/kova05b/devops-engineer-from-scratch-project-76/actions/workflows/hexlet-check.yml/badge.svg)](https://github.com/kova05b/devops-engineer-from-scratch-project-76/actions)

## Project

Redmine задеплоен в Yandex Cloud на 2 сервера за `Application Load Balancer`.

Рабочие адреса:

- [http://hexlet-tutorial.ru](http://hexlet-tutorial.ru)
- [https://hexlet-tutorial.ru](https://hexlet-tutorial.ru)
- [http://www.hexlet-tutorial.ru](http://www.hexlet-tutorial.ru)
- [https://www.hexlet-tutorial.ru](https://www.hexlet-tutorial.ru)

## Infrastructure

Используются:

- 2 сервера:
  - `111.88.248.195`
  - `62.84.114.155`
- `Application Load Balancer` с IP `81.26.178.245`
- `Managed PostgreSQL`
- публичная DNS-зона для `hexlet-tutorial.ru`
- managed certificate в Yandex Certificate Manager

## Project Files

Основные файлы проекта:

- `inventory.ini`
- `playbook.yml`
- `requirements.yml`
- `group_vars/all.yml`
- `group_vars/webservers/vars.yml`
- `group_vars/webservers/vault.yml`
- `templates/redmine.env.j2`
- `Makefile`

## Setup

Установка зависимостей:

```bash
make install
```

Проверка inventory и синтаксиса плейбука:

```bash
make check
```

Подготовка серверов:

```bash
make prepare
```

Деплой Redmine:

```bash
make deploy
```

Редактирование секретов:

```bash
make vault-edit
```

## Variables

Используются основные переменные:

- `redmine_port=80`
- образ `redmine:latest`
- домен `hexlet-tutorial.ru`
- PostgreSQL host `rc1a-2um369d35ms7bgbf.mdb.yandexcloud.net`
- PostgreSQL port `6432`

`.env` для контейнера создаётся из шаблона `templates/redmine.env.j2`.
Секреты хранятся в `group_vars/webservers/vault.yml` и зашифрованы через `Ansible Vault`.

## Checks

Проверка домена:

```powershell
nslookup hexlet-tutorial.ru 8.8.8.8
curl.exe -I http://hexlet-tutorial.ru
curl.exe -I https://hexlet-tutorial.ru
```

Проверка серверов:

```bash
ansible all -i inventory.ini -m ping
ansible all -i inventory.ini -a "docker --version"
curl.exe -I http://111.88.248.195
curl.exe -I http://62.84.114.155
```

Проверка балансировщика:

```powershell
yc alb load-balancer get devops-lvl2-alb --format yaml
curl.exe -I http://81.26.178.245
curl.exe -I https://81.26.178.245
```