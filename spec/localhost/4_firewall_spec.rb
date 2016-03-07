require 'spec_helper'

describe "Firewall", :if => ['darwin'].include?(os[:family]) do
  describe command("/usr/libexec/ApplicationFirewall/socketfilterfw --getglobalstate") do
    its(:exit_status) { should eq 0 }
    its(:stdout) { should contain("Firewall is enabled.") }
  end
end
