### Hexlet tests and linter status:
[![Actions Status](https://github.com/kova05b/devops-engineer-from-scratch-project-76/actions/workflows/hexlet-check.yml/badge.svg)](https://github.com/kova05b/devops-engineer-from-scratch-project-76/actions)

## Task 1: Infrastructure Preparation

Проект для задания собран с максимальным переиспользованием уже существующей инфраструктуры в Yandex Cloud.

## What Is Reused

- Network: `project-devops-deploy-net`
- Subnet: `project-devops-deploy-subnet` (`10.10.0.0/24`)
- Two running servers:
  - `cl1nrh6jtcissullua9l-ebeh` (`10.10.0.30`)
  - `cl1nrh6jtcissullua9l-uzur` (`10.10.0.35`)
- PostgreSQL cluster: `project-devops-deploy-pg`

## What Was Created For The Task

- Security group for ALB: `devops-lvl2-alb-sg`
- Target group: `devops-lvl2-tg`
- Backend group: `devops-lvl2-bg`
- HTTP router: `devops-lvl2-router-default`
- Application Load Balancer: `devops-lvl2-alb`

Дополнительно ограничен доступ к PostgreSQL: убраны публичные правила `0.0.0.0/0`, оставлен доступ только из внутренней сети и с серверов кластера.

## URL

- Existing ingress IP: `http://158.160.239.126`
- ALB URL: `http://81.26.178.245`

Важно: текущее приложение за ingress отвечает на запросы с `Host: bulletin.local`, поэтому в ALB настроен `host rewrite` на `bulletin.local`.

## How To Check

Проверка ресурсов:

```powershell
yc compute instance list --folder-id b1gm6c5s7u190o7dg55s
yc managed-postgresql cluster list --folder-id b1gm6c5s7u190o7dg55s
yc alb load-balancer list --folder-id b1gm6c5s7u190o7dg55s
```

Проверка Kubernetes-приложения:

```powershell
yc managed-kubernetes cluster get-credentials --id catn45aml6o03r8mjomv --external --force
kubectl get nodes -o wide
kubectl get svc -A
kubectl get ingress -A
```

Проверка доступности приложения:

```powershell
curl.exe -I -H "Host: bulletin.local" http://158.160.239.126
```

Проверка нового ALB:

```powershell
yc alb load-balancer get devops-lvl2-alb --format yaml
curl.exe -I http://81.26.178.245
```