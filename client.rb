# This file is only used when running chef in local mode during image creation
# cd /home/vagrant/cookbooks/custom_nfs && sudo chef-client -z -c client.rb -o 'recipe[custom_nfs]'
cookbook_path '/home/vagrant/cookbooks'
role_path '/home/vagrant/cookbooks/custom_nfs/roles'
data_bag_path '/home/vagrant/cookbooks/custom_nfs/data_bags'
environment_path '/home/vagrant/cookbooks/custom_nfs/environments'
environment 'kitchen'
local_mode 'true'
log_level :info
