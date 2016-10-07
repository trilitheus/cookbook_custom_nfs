include_recipe 'nfs::default'

firewalld_service 'nfs' unless node['virtualization']['system'] == 'docker'

share = node['custom_nfs']['nfs_share']

# We need the directory created on both client and server
directory share

if node['roles'].include? 'nfs_server'
  include_recipe 'custom_nfs::lvm' unless node['virtualization']['system'] == 'docker'

  include_recipe 'nfs::server'

  nfs_export share do
    network node['custom_nfs']['share_to']
    writeable node['custom_nfs']['writable']
    sync node['custom_nfs']['sync']
    options node['custom_nfs']['share_options']
  end
end

if node['roles'].include? 'nfs_client'
  mount share do
    device "#{node['custom_mysql']['mount_from']}:#{share}"
    fstype 'nfs'
    action [:mount, :enable]
    options node['custom_nfs']['mount_options']
    retries 3
    retries_delay 3
  end
end
