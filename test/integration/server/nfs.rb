%w(nfs-utils rpcbind).each do |pkg|
  describe package(pkg) do
    it { should be_installed }
  end
end

describe iptables(table:'filter', chain:'IN_public_allow') do
  it { should have_rule('-A IN_public_allow -p tcp -m tcp --dport 2049 -m conntrack --ctstate NEW -j ACCEPT') }
  it { should have_rule('-A IN_public_allow -p tcp -m tcp --dport 20048 -m conntrack --ctstate NEW -j ACCEPT') }
  it { should have_rule('-A IN_public_allow -p udp -m udp --dport 20048 -m conntrack --ctstate NEW -j ACCEPT') }
end

describe file('/etc/exports') do
  its('content') { should match %r(data 33.33.33.1/24\(rw,sync,no_root_squash\)) }
end

check_exports = command('exportfs -v')
describe check_exports do
  its('stdout') { should match %r(/data\s+33.33.33.1/24\(rw,wdelay,no_root_squash,no_subtree_check,sec=sys,rw,secure,no_root_squash,no_all_squash\)) }
end
