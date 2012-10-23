define :zym_apache, :cookbook => "zym" do
  name     = params[:name]
  dir      = params[:dir]
  aliases  = params[:domain_aliases]
  env      = params[:environment]
  cookbook = params[:cookbook]
  
  web_app "#{params[:name]}" do
    template       "apache-site.conf.erb"
    docroot        "#{dir}/web"
    server_name    name
    server_aliases aliases
    environment    env
    
    if cookbook
      cookbook cookbook
    end
  end
end