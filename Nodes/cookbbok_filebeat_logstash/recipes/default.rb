# recipes/filebeat.rb
package 'filebeat' do
    action :install
  end
  
  template node['filebeat']['config'] do
    source 'filebeat.yml.erb'
    notifies :restart, 'service[filebeat]'
  end
  
  service 'filebeat' do
    supports restart: true, reload: true
    action [:enable, :start]
  end

  # recipes/logstash.rb
package 'logstash' do
    action :install
  end
  
  template "#{node['logstash']['config']}/logstash.conf" do
    source 'logstash.conf.erb'
    notifies :restart, 'service[logstash]'
  end
  
  service 'logstash' do
    supports restart: true, reload: true
    action [:enable, :start]
  end
  