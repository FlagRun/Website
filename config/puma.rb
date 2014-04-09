#!/usr/bin/env puma
directory   '/var/www/flagrun.net/current'
environment  'production'


threads 8,32
workers 4
preload_app!

# Daemonize
daemonize true
pidfile     '/var/www/flagrun.net/current/tmp/puma.pid'
state_path  '/var/www/flagrun.net/current/tmp/puma.state'
bind        'unix:///var/www/flagrun.net/current/tmp/puma.sock'

on_worker_boot do
  ActiveSupport.on_load(:active_record) do
    ActiveRecord::Base.establish_connection
  end
end