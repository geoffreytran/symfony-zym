zym_database "#{node[:zym][:db][:name]}" do
  username node[:zym][:db][:user]
  password node[:zym][:db][:password]
end