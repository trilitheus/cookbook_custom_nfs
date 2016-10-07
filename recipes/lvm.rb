include_recipe 'lvm'

node['custom_nfs']['pvs'].each do |pv|
  lvm_physical_volume pv
end

lvm_volume_group node['custom_nfs']['vg']['name'] do
  physical_volumes node['custom_nfs']['pvs']
end

lvm_logical_volume node['custom_nfs']['lv']['name'] do
  group node['custom_nfs']['vg']['name']
  size node['custom_nfs']['lv']['size']
  filesystem node['custom_nfs']['lv']['fs_type']
  mount_point location: node['custom_nfs']['nfs_share'], options: node['custom_nfs']['lv']['mount_options']
end
