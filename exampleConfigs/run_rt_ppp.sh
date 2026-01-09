#!/bin/bash
# Скрипт для запуска PEA с учетными данными из .env файла

# Загружаем переменные окружения из .env файла
if [ -f ../.env ]; then
    export $(cat ../.env | grep -v '^#' | xargs)
else
    echo "Ошибка: Файл .env не найден в корне репозитория"
    echo "Создайте файл .env со следующим содержимым:"
    echo "NTRIP_USER=your_username"
    echo "NTRIP_PASS=your_password"
    exit 1
fi

# Заменяем плейсхолдеры на значения из переменных окружения
sed "s/your_ntrip_user/$NTRIP_USER/g; s/your_ntrip_pass/$NTRIP_PASS/g" rt_ppp_example.yaml > rt_ppp_example.yaml.tmp

# Запускаем программу
../bin/pea --config rt_ppp_example.yaml.tmp

# Удаляем временный файл
rm -f rt_ppp_example.yaml.tmp
