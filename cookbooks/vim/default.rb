case node[:platform]
when 'darwin'
  package 'neovim/neovim/neovim'
  package 'global'
end

ln '.vimrc'
