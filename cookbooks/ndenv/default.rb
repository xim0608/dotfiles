package 'ndenv'

ndenv_root = "/#{ENV['USER']}/.ndenv/plugins/node-build"
git ndenv_root do
  repository 'https://github.com/riywo/node-build.git'
  not_if { Dir.exists?(ndenv_root)}
end

execute 'reloading shell' do
  user ENV['USER']
  command 'source ~/.zshenv'
end

execute 'install gatsbyjs' do
  user ENV['USER']
  command 'npm install --global gatsby-cli'
end
