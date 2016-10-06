include_recipe 'nfs::default'

firewalld_service 'nfs' unless node['virtualization']['system'] == 'docker'
