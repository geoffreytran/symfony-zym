zym_queue_worker "#{node[:zym][:parameters][:app][:normalizedName]}" do
  dir node[:zym][:dir]

  user node[:zym][:user]

  environment node[:zym][:environment]
  debug       node[:zym][:debug]
end