#
# Cookbook Name:: custom_nfs
# Spec:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

require 'spec_helper'

describe 'custom_nfs::default' do
  context 'On CentOS 7 NFS Client' do
    cached(:chef_run) do
      ChefSpec::ServerRunner.new do |node, server|
        node.automatic['virtualization']['system'] = 'vmware'
        node.automatic['platform'] = 'centos'
        node.automatic['platform_version'] = '7.2'
        node.chef_environment = 'kitchen'
        server.create_environment('kitchen')
        server.create_role('nfs_client')
      end.converge('role[nfs_client]', described_recipe)
    end

    it 'includes the nfs::default recipe' do
      expect(chef_run).to include_recipe('nfs::default')
    end

    it 'creates the /data mountpoint' do
      expect(chef_run).to create_directory('/data')
    end

    it 'includes the NFS V4 client recipe' do
      expect(chef_run).to include_recipe('nfs::client4')
    end

    it 'mounts the /data NFS share' do
      expect(chef_run).to mount_mount('/data').with(
        fstype: 'nfs',
        retries: 3,
        retry_delay: 3,
        options: ['defaults', 'noatime', 'nodiratime', 'vers=4']
      )
    end

    it 'adds the /data NFS share to /etc/fstab' do
      expect(chef_run).to enable_mount('/data').with(
        fstype: 'nfs',
        retries: 3,
        retry_delay: 3,
        options: ['defaults', 'noatime', 'nodiratime', 'vers=4']
      )
    end
  end
end
