#
# Cookbook Name:: custom_nfs
# Spec:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

require 'spec_helper'

describe 'custom_nfs::default' do
  context 'On  CentOS 7 NFS Server' do
    cached(:chef_run) do
      ChefSpec::ServerRunner.new do |node, server|
        node.automatic['virtualization']['system'] = 'vmware'
        node.automatic['platform'] = 'centos'
        node.automatic['platform_version'] = '7.2'
        node.chef_environment = 'kitchen'
        server.create_environment('kitchen')
        server.create_role('nfs_server')
      end.converge('role[nfs_server]', described_recipe)
    end

    it 'includes the custom_nfs::lvm recipe' do
      expect(chef_run).to include_recipe('custom_nfs::lvm')
    end

    it 'includes the nfs::default recipe' do
      expect(chef_run).to include_recipe('nfs::default')
    end

    it 'adds the nfs service to the firewall rules' do
      expect(chef_run).to add_firewalld_service('nfs')
    end

    it 'adds the mountd service to the firewall rules' do
      expect(chef_run).to add_firewalld_service('mountd')
    end

    it 'creates the LVM physical volume' do
      expect(chef_run).to create_lvm_physical_volume('/dev/sdb')
    end

    it 'create the LVM volume group' do
      expect(chef_run).to create_lvm_volume_group('datavg')
    end

    it 'creates the LVM logical volume' do
      expect(chef_run).to create_lvm_logical_volume('datavol1')
    end

    it 'creates the /data directory to export' do
      expect(chef_run).to create_directory('/data')
    end

    it 'creates the /data NFS export' do
      expect(chef_run).to create_nfs_export('/data')
    end
  end
end
