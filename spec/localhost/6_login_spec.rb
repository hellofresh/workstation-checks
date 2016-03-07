require 'spec_helper'
require 'strong_password'
require 'read_password'

describe "User setting", :if => ['darwin'].include?(os[:family]) do
    describe "Autologin disabled" do
      describe command("defaults read /Library/Preferences/com.apple.loginwindow") do
        its(:exit_status) { should eq 0 }
        its(:stdout) { should_not contain("autoLoginUser") }
      end
    end

    describe "Guest login disabled" do
      describe command("defaults read /Library/Preferences/com.apple.loginwindow") do
        its(:exit_status) { should eq 0 }
        its(:stdout) { should contain("GuestEnabled = 0") }
      end
    end

    describe "Check your password" do
      password = get_password("Enter your password here to be check: ")
      checker = StrongPassword::StrengthChecker.new(password)
      password_length = password.length

      describe "it should be more than 8 char" do
        specify { expect(password_length).to be >= 8 }
      end

      describe "it should be strong" do
        specify { expect(checker.is_strong?).to be true }
      end
      
      describe "it should be not weak" do
        specify { expect(checker.is_weak?).to be false }
      end

      # Reset password
      password = nil
    end

    describe "Require pasword after sleep/screensaver" do
      describe command("defaults read com.apple.screensaver askForPassword") do
        its(:exit_status) { should eq 0 }
        its(:stdout) { expect contain("1") }
      end
    end

    describe "Password delay less than 30 sec" do
      delay_in_min = command("defaults read com.apple.screensaver askForPasswordDelay").stdout.to_i
      specify { expect(delay_in_min).to be <= 30 }
    end 

    describe "ScreenSaver starts after max 5 min" do
      delay_in_min = command("defaults -currentHost read com.apple.screensaver idleTime").stdout.to_i
      specify { expect(delay_in_min).to be <= 300 }
    end 

end
