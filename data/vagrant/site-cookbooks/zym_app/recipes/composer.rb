include_recipe "composer"

composer "#{node[:zym_app][:dir]}" do
  action [:deploy, :install]
end