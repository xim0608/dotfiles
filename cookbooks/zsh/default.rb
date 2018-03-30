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

ln '.zshrc'
ln '.zshenv'
