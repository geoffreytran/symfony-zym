define :zym_database do  
  mysql_connection_info = {
    :host     => node['mysql']['bind_address'], 
    :username => 'root', 
    :password => node['mysql']['server_root_password']
  }
  
  # Create the database
  mysql_database "#{params[:name]}" do
    connection mysql_connection_info
    action :create
  end
  
  # Create the user
  mysql_database_user "#{params[:username]}" do
    connection mysql_connection_info
    password params[:password]
    host '%'
    database_name params[:name]
    action [:create, :grant]
  end
  
  mysql_database_user "#{params[:username]}" do
    connection mysql_connection_info
    password params[:password]
    host '127.0.0.1'
    database_name params[:name]
    action [:create, :grant]
  end
end