include_recipe 'nfs::default'

firewalld_service 'nfs' unless node['virtualization']['system'] == 'docker'

share = node['custom_nfs']['nfs_share']

directory share

include_recipe 'custom_nfs::lvm' unless node.chef_environment == 'kitchen'
