%w(nfs-utils rpcbind).each do |pkg|
  describe package(pkg) do
    it { should be_installed }
  end
end

describe file('/data') do
  it { should exist }
  it { should be_directory }
end

describe mount('/data') do
  it { should be_mounted }
  its('device') { should eq '33.33.33.2:/data' }
  its('type') { should eq 'nfs4' }
  its('options') { should eq ['rw', 'noatime', 'nodiratime', 'vers=4.0', 'rsize=65536', 'wsize=65536', 'namlen=255', 'hard', 'proto=tcp', 'port=0', 'timeo=600', 'retrans=2', 'sec=sys', 'clientaddr=33.33.33.3', 'local_lock=none', 'addr=33.33.33.2'] }
end
