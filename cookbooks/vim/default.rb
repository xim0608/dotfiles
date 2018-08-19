case node[:platform]
when 'darwin'
  package 'neovim/neovim/neovim'
  package 'global'
else
  package 'vim'
end

ln '.vimrc'
