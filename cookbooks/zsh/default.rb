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
package 'zsh-syntax-highlighting'
package 'zsh-autosuggestions'
package 'zsh-completions'

git "./pure" do
  repository "git@github.com:sindresorhus/pure.git"
end

if node[:platform] == 'darwin'
  link '/usr/local/share/zsh/site-functions/prompt_pure_setup' do
    to File.expand_path("../../../pure/pure.zsh", __FILE__)
    user node[:user]
    not_if { File.exists?(__FILE__) }
  end
  link '/usr/local/share/zsh/site-functions/async' do
    to File.expand_path("../../../pure/async.zsh", __FILE__)
    user node[:user]
    not_if { File.exists?(__FILE__) }
  end
end

ln '.zshrc'
ln '.zshenv'
