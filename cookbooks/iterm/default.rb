# require 'zip'

# remote_file "/tmp/iterm2_latest.zip" do
#   source 'http://iterm2.com/downloads/stable/latest'
#   not_if { File.exists?('/Applications/iTerm.app') }
# end

# execute 

if node[:os] == 'darwin'
  iterm_setting = File.join(ENV['HOME'], 'Library/Preferences/com.googlecode.iterm2.plist')
  link iterm_setting do
    to File.expand_path("../../../config/com.googlecode.iterm2.plist", __FILE__)
    user node[:user]
    force true
  end
end
