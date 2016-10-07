#
# Cookbook Name:: custom_nfs
# Spec:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

require 'spec_helper'

describe 'custom_nfs::default' do
  context 'When all attributes are default, on an unspecified platform' do
    cached(:chef_run) do
      ChefSpec::ServerRunner.new do |node, server|
        node.automatic['virtualization']['system'] = 'vmware'
        node.chef_environment = 'kitchen'
        server.create_environment('kitchen')
      end.converge(described_recipe)
    end

    it 'includes the nfs::default recipe' do
      expect(chef_run).to include_recipe('nfs::default')
    end

    it 'adds the nfs service to the firewall rules' do
      expect(chef_run).to add_firewalld_service('nfs')
    end

    it 'creates the /data mountpoint' do
      expect(chef_run).to create_directory('/data')
    end
  end
end
