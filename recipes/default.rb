include_recipe 'nfs::default'

# We need the directory created on both client and server
share = node['custom_nfs']['nfs_share']
directory share

if node['roles'].include? 'nfs_server'
  unless node['virtualization']['system'] == 'docker'
    include_recipe 'custom_nfs::lvm'
    firewalld_service 'nfs'
    firewalld_service 'mountd'
  end

  include_recipe 'nfs::server4'

  nfs_export share do
    network node['custom_nfs']['share_to']
    writeable node['custom_nfs']['writable']
    sync node['custom_nfs']['sync']
    options node['custom_nfs']['share_options']
  end
end

if node['roles'].include? 'nfs_client'
  include_recipe 'nfs::client4'

  mount share do
    device "#{node['custom_nfs']['mount_from']}:#{share}"
    fstype 'nfs'
    action [:mount, :enable]
    options node['custom_nfs']['mount_options']
    retries 3
    retry_delay 3
  end
end
