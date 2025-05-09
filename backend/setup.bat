@echo off
echo Running migrations...
python manage.py makemigrations
python manage.py migrate

echo Starting server...
python manage.py runserver 