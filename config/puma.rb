max_threads = Integer(ENV.fetch("RAILS_MAX_THREADS", 5))
min_threads = Integer(ENV.fetch("RAILS_MIN_THREADS", max_threads))
threads min_threads, max_threads

env = ENV.fetch("RAILS_ENV", ENV.fetch("RACK_ENV", "production"))
environment env

workers Integer(ENV.fetch("WEB_CONCURRENCY", 1))
preload_app! if Integer(ENV.fetch("WEB_CONCURRENCY", 1)) > 1

worker_timeout 3600 if env == "development"

bind "tcp://0.0.0.0:#{ENV.fetch('PORT', 3000)}"

pidfile ENV.fetch("PIDFILE", "tmp/pids/server.pid")

plugin :tmp_restart

on_worker_boot do
  ActiveRecord::Base.establish_connection if defined?(ActiveRecord)
end
