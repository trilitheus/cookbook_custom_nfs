#
# Cookbook Name:: custom_nfs
# Spec:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

require 'spec_helper'

describe 'custom_nfs::default' do
  context 'When all attributes are default, on an unspecified platform' do
    cached(:chef_run) do
      runner = ChefSpec::ServerRunner.new
      runner.converge(described_recipe)
    end

    it 'includes the nfs::default recipe' do
      expect(chef_run).to include_recipe('nfs::default')
    end
  end
end
