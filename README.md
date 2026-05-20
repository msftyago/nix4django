# nix4django
Base template for Django development using Nix flakes. You are free to add nix shell or modify in any way you desire.

## Setup
After clone the repo:
```bash
cd nix4django/ && direnv allow
```
```bash
pip install django # or use pipenv
```

## To run:
```bash
cd m4lw4r3 # directory name was random
```
+ or just create your own using `django-admin startproject <project-name>`
```bash
python manage.py runserver
```
+ check [localhost:8000](http://127.0.0.1:8000/)
