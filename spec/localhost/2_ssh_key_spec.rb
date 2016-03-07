require 'spec_helper'

ssh_private_key_path = File.expand_path("~/.ssh/id_rsa")
ssh_exists = File.exist?(File.expand_path(ssh_private_key_path))

if ssh_exists 

  describe "ssh key length to be 4096" do
    describe command("ssh-keygen -lf #{ssh_private_key_path}") do
      its(:exit_status) { should eq 0 }
      its(:stdout) { should contain("4096") }
    end
  end

  describe "ssh key should be encrypted" do
    describe command("grep -L ENCRYPTED #{ssh_private_key_path}") do
      its(:exit_status) { should eq 0 }
    end
  end


end
