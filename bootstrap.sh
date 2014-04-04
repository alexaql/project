apt-get update
apt-get install -y python
apt-get install -y python-pip
pip install -r /vagrant/requirements.txt

# install supervisord
command -v supervisord > /dev/null
if [ $? -ne 0 ]; then
    apt-get -y install supervisor
    cat > /etc/supervisor/conf.d/data.conf << EOF
[program:data]
directory=/vagrant/
command=/usr/bin/python app.py
autostart=true
autorestart=true
EOF
    service supervisor stop
    sleep 3
    service supervisor start
fi

