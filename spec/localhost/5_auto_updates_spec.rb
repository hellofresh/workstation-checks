require 'spec_helper'

describe "Autoupdate setting", :if => ['darwin'].include?(os[:family]) do
  describe command("defaults read /Library/Preferences/com.apple.commerce AutoUpdate") do
    its(:exit_status) { should eq 0 }
    its(:stdout) { should contain("1") }
  end

  describe command("defaults read /Library/Preferences/com.apple.commerce AutoUpdateRestartRequired") do
    its(:exit_status) { should eq 0 }
    its(:stdout) { should contain("1") }
  end

  # sudo softwareupdate --schedule on
  describe command("defaults read /Library/Preferences/com.apple.SoftwareUpdate AutomaticCheckEnabled") do
    its(:exit_status) { should eq 0 }
    its(:stdout) { should contain("1") }
  end

end
