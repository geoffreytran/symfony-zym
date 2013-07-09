zym_queue_worker "#{node[:zym][:parameters][:app][:normalized_name]}" do
  dir node[:zym][:dir]

  user node[:zym][:user]

  environment node[:zym][:environment]
  debug       node[:zym][:debug]
end