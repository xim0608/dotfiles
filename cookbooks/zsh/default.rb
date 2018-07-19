package 'zsh'

if node[:platform] == 'darwin'
  execute 'echo /usr/local/bin/zsh | sudo tee -a /etc/shells' do
    not_if 'echo $SHELL | grep zsh'
  end

  execute 'chsh -s /usr/local/bin/zsh' do
    not_if 'echo $SHELL | grep zsh'
  end
end

package 'peco'
package 'fzf'
package 'zsh-syntax-highlighting'
package 'zsh-autosuggestions'
package 'zsh-completions'

zsh_theme_dir = "#{ENV['HOME']}/.zsh/themes"
git "#{zsh_theme_dir}/pure" do
  repository "https://github.com/sindresorhus/pure.git"
  not_if { File.exists?("#{zsh_theme_dir}/pure/pure.zsh") && File.exists?("#{zsh_theme_dir}/pure/async.zsh") }
end

if node[:platform] == 'darwin'
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
end

ln '.zshrc'
ln '.zshenv'
