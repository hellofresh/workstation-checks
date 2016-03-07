require 'spec_helper'

describe "HD encryption", :if => ['darwin'].include?(os[:family]) do
  describe command("fdesetup status") do
    its(:exit_status) { should eq 0 }
    its(:stdout) { should match("FileVault is On.") }
  end
end


# Linux
# blkid `df -P /home/ | tail -1 | cut -d' ' -f 1`