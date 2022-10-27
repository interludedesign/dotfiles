# RabbitMQ

## Install
- Download from https://www.rabbitmq.com/install-generic-unix.html
- Move to ~/rabbitmq
- Start Server ($PATH already configured) - `rabbitmq-server`
- Install admin plugin:

```sh
cd ~/rabbitmq/sbin
rabbitmq-plugins enable rabbitmq_management
curl -o rabbitmqadmin http://localhost:15672/cli/rabbitmqadmin
chmod +x rabbitmqadmin
```

## Import Config
rabbitmqadmin import ~/.dotfiles/work/rabbitmq_config.json

## Export Config
rabbitmqadmin --username root --password $RABBITMQ_ROOT_PASSWORD export rabbitmq_config.json

## Reset Config
rabbitmqctl stop_app
rabbitmqctl reset

## Rabbit Cheatsheet
rabbitmq-diagnostics status

## Admin Web Server
http://localhost:15672/

## Refs
https://sleeplessbeastie.eu/2020/03/18/how-export-or-import-rabbitmq-configuration/
