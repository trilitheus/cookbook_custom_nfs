Vagrant.configure('2') do |c|
  c.vm.provider :virtualbox do |p|
    p.customize ['createhd', '--filename', 'disk2.vdi', '--size', '1024']
    p.customize ['storageattach', :id, '--storagectl', 'IDE Controller', '--medium', 'disk2.vdi', '--port', '1', '--device', '0', '--type', 'hdd']
  end
end
