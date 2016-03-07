require 'spec_helper'


describe "Nothing should be listening on 0.0.0.0" do
    
    describe command("netstat -atnl | grep LISTEN | grep 0.0.0.0") do
        its(:exit_status) { should eq 1 }
    end

    # describe command("netstat -atnl | grep LISTEN | grep ' *.[0-9]*'") do
    #     its(:exit_status) { should eq 1 }
    # end

end
