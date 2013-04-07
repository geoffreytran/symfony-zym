define :zym_queue_worker, :cookbook => "zym" do
  name       = params[:name]
  dir        = params[:dir]
  env        = params[:environment]
  debug      = params[:debug]
  cookbook   = params[:cookbook]

  include_recipe "supervisor"

  supervisor_service "#{params[:name]}-worker" do
    process_name "%(program_name)s-%(process_num)s"

    command "#{params[:dir]}/bin/console zym:resque:worker --env=#{env} -v"

    directory "#{params[:dir]}"

    user params[:user]

    stdout_logfile "#{node[:supervisor][:log_dir]}/%(program_name)s-stdout.log"
    stderr_logfile "#{node[:supervisor][:log_dir]}/%(program_name)s-stderror.log"

    action [:enable]

    supports :restart => true
  end

  log "Configured the worker: #{params[:name]}-worker" do
    notifies :restart, "supervisor_service[#{params[:name]}-worker]", :delayed
  end
end