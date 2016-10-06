%w(nfs-utils rpcbind).each do |pkg|
  describe package(pkg) do
    it { should be_installed }
  end
end
