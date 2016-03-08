require 'spec_helper'

# Current support OS Families
supported_os_families     = ["darwin", "ubuntu"]
supported_ubuntu_version  = ["14.04"]

# Version 10.10: "Yosemite" Version 10.11: "El Capitan"
supported_mac_version     = ["10.11.*", "10.10.*"]


describe "Your disterbution/OS should be supported" do
    describe supported_os_families do
        it { should include("darwin") }
    end
end

# describe "Your release should be supported for " do
#     describe "Mac" :if => ['darwin'].include?(os[:family]) do
#          command("sw_vers -productVersion").stdout
#         it { should contain() }
#         supported_os_families
#     end
# end
