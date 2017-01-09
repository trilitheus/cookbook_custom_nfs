default['custom_nfs']['pvs'] = ['/dev/sdb']
default['custom_nfs']['vg']['name'] = 'datavg'
default['custom_nfs']['lv']['name'] = 'datavol1'
default['custom_nfs']['lv']['size'] = '100%VG'
default['custom_nfs']['lv']['fs_type'] = 'ext4'
default['custom_nfs']['lv']['options'] = 'noatime,nodiratime'

default['lvm']['chef-ruby-lvm']['version'] = '0.2.2'
default['lvm']['chef-ruby-lvm-attrib']['version'] = '0.0.28'
default['lvm']['cleanup-old-gems']['version'] = true
