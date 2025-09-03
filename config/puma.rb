# config/puma.rb

# Threads
max_threads = Integer(ENV.fetch("RAILS_MAX_THREADS", 5))
min_threads = Integer(ENV.fetch("RAILS_MIN_THREADS", max_threads))
threads min_threads, max_threads

# Environment
env = ENV.fetch("RAILS_ENV", ENV.fetch("RACK_ENV", "production"))
environment env

# Workers (1 by default; override with WEB_CONCURRENCY)
workers Integer(ENV.fetch("WEB_CONCURRENCY", 1))
preload_app! if Integer(ENV.fetch("WEB_CONCURRENCY", 1)) > 1

# Longer timeout in dev so `rails s` doesn't die while idle
worker_timeout 3600 if env == "development"

# Listen — choose ONE way only. We bind explicitly and DO NOT also call `port`.
# This prevents EADDRINUSE on 0.0.0.0:3000.
bind "tcp://0.0.0.0:#{ENV.fetch('PORT', 3000)}"

# PID file
pidfile ENV.fetch("PIDFILE", "tmp/pids/server.pid")

# Allow `bin/rails restart`
plugin :tmp_restart

# Reconnect DB in each worker when using >1 worker
on_worker_boot do
  ActiveRecord::Base.establish_connection if defined?(ActiveRecord)
end
