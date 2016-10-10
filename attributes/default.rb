default['custom_nfs']['nfs_share'] = '/data'
default['custom_nfs']['share_to'] = '33.33.33.1/24'
default['custom_nfs']['mount_from'] = '33.33.33.2'
default['custom_nfs']['writable'] = true
default['custom_nfs']['sync'] = true
default['custom_nfs']['share_options'] = ['no_root_squash']
default['custom_nfs']['mount_options'] = ['defaults','noatime','nodiratime','vers=4']
