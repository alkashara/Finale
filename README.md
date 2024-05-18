Тот же бот, только локально!

*Для установки вам требуется Ansible

Установите репозиторий и добавьте .env в корневую папку проекта

 cd /tmp        || Обязательно!!!

 git clone --branch ansible --single-branch https://github.com/alkashara/PT_START2024.git

Запустите playbook и все поставиться автоматически!

source .env

ansible-playbook -i hosts.ini playbook_tg_bot.yml --extra-vars "db_user=$DB_USER db_password=$DB_PASSWORD db_name=$DB_DATABASE db_host=$DB_HOST db_port=$DB_PORT bot_token=$TOKEN"

