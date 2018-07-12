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
package 'ghq'
# TODO: add ghq setting

git "./pure" do
  repository "https://github.com/sindresorhus/pure.git"
  not_if { File.exists?("../../../pure/pure.zsh") && File.exists?("../../../pure/async.zsh") }
end

if node[:platform] == 'darwin'
  link '/usr/local/share/zsh/site-functions/prompt_pure_setup' do
    to File.expand_path("../../../pure/pure.zsh", __FILE__)
    user node[:user]
    force true
  end
  link '/usr/local/share/zsh/site-functions/async' do
    to File.expand_path("../../../pure/async.zsh", __FILE__)
    user node[:user]
    force true
  end
end

ln '.zshrc'
ln '.zshenv'
