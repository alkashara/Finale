Тот же бот, только локально!

*Для установки вам требуется Ansible

Установите репозиторий и добавьте .env в корневую папку проекта

 git clone --branch ansible --single-branch https://github.com/alkashara/PT_START2024.git

Запустите playbook и все поставиться автоматически!

source .env
ansible-playbook -i inventory playbook_tg_bot.yml
