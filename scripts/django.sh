#!/bin/bash

#BEGIN - Table of Contents ====================================

     #  Easy Django environment with Conda
     #  Django Bash Completion
   #  DJANGO Aliases

#END   - Table of Contents ====================================

#** Easy Django environment with Conda
# -- Make sure you have a "root" conda env activated for this to work
django_env_create() {
  # =========================================
  # Bash script for easy Django env creation.
  # =========================================
  # Create the Conda env
  echo "============================="
  echo "Creating Conda environment..."
  echo "============================="
  conda create -y --name $1 python=3.8 anaconda
  conda deactivate
  conda activate $1
  # Install Django
  echo "============================="
  echo "Installing Django..."
  echo "============================="
  conda install -y -c anaconda django
  # Update Django to latest
  python -m pip install --progress-bar pretty -U Django
  # Create Django project
  echo "============================="
  echo "Creating Django project..."
  echo "============================="
  django-admin startproject $1
  # Install livereload for easier dev
  echo "============================="
  echo "Installing livereload server..."
  echo "============================="
  pip install django-livereload-server
  cd $1
  # Make conda env .yml to auto-activate in this project dir
  conda env export > environment.yml
  # Build .gitignore
  echo "============================="
  echo "Building .gitignore..."
  echo "============================="
  echo "environment.yml" >> .gitignore
  echo "db.sqlite3" >> .gitignore
  echo "__pycache__/" >> .gitignore
  echo "**/__pycache__/" >> .gitignore
  echo "**/migrations/" >> .gitignore
  # Default settings
  echo "============================="
  echo "Setting up default settings..."
  echo "============================="
  echo "import os" >> $1/default_settings.py
  echo "from pathlib import Path" >> $1/default_settings.py
  echo "BASE_DIR = Path(__file__).resolve().parent.parent" >> $1/default_settings.py
  echo "ADDITIONAL_APPS = [ 'livereload', ]" >> $1/default_settings.py
  echo "ADDITIONAL_MIDDLEWARE = [ 'livereload.middleware.LiveReloadScript', ]" >> $1/default_settings.py
  echo "TEMPLATE_BASE = [ os.path.join(BASE_DIR, 'templates'), ]" >> $1/default_settings.py
  echo "STATICFILES_DIRS = ( os.path.join(BASE_DIR, 'static'), )" >> $1/default_settings.py
  echo "STATIC_ROOT = os.path.join(BASE_DIR, 'staticfiles')" >> $1/default_settings.py
  # Create Django project dirs
  # for static files and templates
  mkdir templates
  mkdir static
  cd ..
  conda deactivate
  conda activate base
  # Finishing setup, providing notice
  echo "============================="
  echo "Setup finished."
  echo "============================="
  echo "Please complete configuration by adding the following to 'settings.py':"
  echo "-----------------------------"
  echo "from .default_settings import ADDITIONAL_APPS, ADDITIONAL_MIDDLEWARE, STATIC_ROOT, STATICFILES_DIRS, TEMPLATE_BASE"
  echo ".................................."
  echo "...then at the bottom of the file:"
  echo ".................................."
  echo "INSTALLED_APPS += ADDITIONAL_APPS"
  echo "MIDDLEWARE += ADDITIONAL_MIDDLEWARE"
  echo "TEMPLATES[0]['DIRS'] += TEMPLATE_BASE"
}

#** Django Bash Completion
# https://github.com/django/django/blob/main/extras/django_bash_completion
source /etc/bash_completion.d/django.bash

#* DJANGO Aliases
# Go to Django Projects
alias projects='cd ~/projects'
# Make Migrations
alias djangoMM='python manage.py makemigrations'
# Migrate
alias djangoM='python manage.py migrate'
# Both
alias djangoMMM='python manage.py makemigrations; python manage.py migrate'
# Runserver
alias djangoRS='python manage.py runserver'
# Create superuser
alias djangoCSU='python manage.py createsuperuser'
