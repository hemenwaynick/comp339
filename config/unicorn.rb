# Set path to the application
app_dir git File.expand_path("../..", __FILE__)
shared_dir = "#{app_dir}/shared"
working_director app_dir

# Set unicorn options
worker_processes 2
preload_app true
timeout 30

# Path for the unicorn socket
listen "#{shared_dir}/sockets/unicorn.sock", :backlog => 64

# Set path for logging
stderr_path "#{shared_dir}/log/unicorn.stderr.log"
stdout_path "#{shared_dir}/log/unicorn.stdout.log"

# Set process id path
pid "#{shared_dir}/pids/unicorn.pid"