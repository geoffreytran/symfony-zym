define :zym_apache, :http_cache => false, :cookbook => "zym" do
  name       = params[:name]
  dir        = params[:dir]
  aliases    = params[:domain_aliases]
  env        = params[:environment]
  cookbook   = params[:cookbook]
  http_cache = params[:http_cache]
  
  web_app "#{params[:name]}" do
    template       "apache-site.conf.erb"
    docroot        "#{dir}/web"
    server_name    name
    server_aliases aliases
    environment    env
    http_cache     http_cache
    
    if cookbook
      cookbook cookbook
    end
  end
end