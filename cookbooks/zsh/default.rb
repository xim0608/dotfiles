package 'zsh'

if node[:platform] == 'darwin'
  execute 'echo /usr/local/bin/zsh | sudo tee -a /etc/shells' do
    not_if 'echo $SHELL | grep zsh'
  end

  execute 'chsh -s /usr/local/bin/zsh' do
    not_if 'echo $SHELL | grep zsh'
  end
elsif node[:platform] == 'darwin'
  execute 'chsh -s /usr/bin/zsh' do
    not_if 'echo $SHELL | grep zsh'
  end
end

package 'fzf'
package 'zsh-syntax-highlighting'
package 'zsh-autosuggestions'
package 'zsh-completions'

zsh_theme_dir = "#{ENV['HOME']}/.zsh/themes"
git "#{zsh_theme_dir}/pure" do
  repository "https://github.com/sindresorhus/pure.git"
  not_if { File.exists?("#{zsh_theme_dir}/pure/pure.zsh") && File.exists?("#{zsh_theme_dir}/pure/async.zsh") }
end

link '/usr/local/share/zsh/site-functions/prompt_pure_setup' do
  to File.expand_path("#{zsh_theme_dir}/pure/pure.zsh", __FILE__)
  user node[:user]
  force true
end
link '/usr/local/share/zsh/site-functions/async' do
  to File.expand_path("#{zsh_theme_dir}/pure/async.zsh", __FILE__)
  user node[:user]
  force true
end

# show temparature
if node[:os] == 'darwin'
  tmp_dir = "#{ENV['HOME']}/osx-cpu-temp"
  git tmp_dir do
    repository "https://github.com/lavoiesl/osx-cpu-temp"
    not_if {
      package_name = 'osx-cpu-temp'
      result = run_command("type #{package_name}", error: false)
      result.exit_status == 0
    }
  end

  execute 'make osx-cpu-temp' do
    user ENV['USER']
    command "cd #{tmp_dir} && make"
    not_if {
      package_name = 'osx-cpu-temp'
      result = run_command("type #{package_name}", error: false)
      result.exit_status == 0
    }
  end

  execute 'install osx-cpu-temp' do
    user ENV['USER']
    command "cd #{tmp_dir} && make install"
    not_if {
      package_name = 'osx-cpu-temp'
      result = run_command("type #{package_name}", error: false)
      result.exit_status == 0
    }
  end
end

ln '.zshrc'
ln '.zshenv'
ln '.tmux.conf'
