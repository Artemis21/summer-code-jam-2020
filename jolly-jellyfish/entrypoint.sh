#!/bin/bash
set -e

# install firefox and geckodriver
cd /app
wget 'http://download.mozilla.org/?product=firefox-20.0&os=linux&lang=en-US' -O firefox-20.0.tar.bz2
tar -xf firefox-20.0.tar.bz2
wget 'https://github.com/mozilla/geckodriver/releases/download/v0.27.0/geckodriver-v0.27.0-linux64.tar.gz' -O geckodriver-27.0.tar.gz
tar -xzf geckodriver-27.0.tar.gz
nohup /app/geckodriver -b firefox/firefox &
cd -

if [ "$1" = 'runserver' ]; then
    python manage.py migrate
    cat | python manage.py shell <<_EOF_
from django.contrib.auth import get_user_model
User = get_user_model()
User.objects.create_superuser('admin', 'admin@myproject.com', '$ADMIN_PASSWORD')
_EOF_
    python manage.py loaddata initial-themes.yaml
fi

exec python manage.py "$@"
