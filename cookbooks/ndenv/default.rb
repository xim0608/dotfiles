package 'ndenv'

ndenv_root = "/Users/#{ENV['USER']}/.ndenv/plugins/node-build"
git ndenv_root do
  repository 'https://github.com/riywo/node-build.git'
  not_if { Dir.exists?(ndenv_root)}
end

execute 'reloading shell' do
  user ENV['USER']
  command 'source ~/.zshenv'
end

node_version = 'v8.11.1'
execute 'install node' do
  user ENV['USER']
  command "ndenv install #{node_version}"
  not_if {
    result = run_command('ndenv versions', error: false)
    result.stdout.include?(node_version)
  }
end

execute 'rehash ndenv' do
  user ENV['USER']
  command 'ndenv rehash'
end

execute 'global ndenv installed version' do
  user ENV['USER']
  command "ndenv global #{node_version}"
end

execute 'install gatsbyjs' do
  user ENV['USER']
  command 'npm install --global gatsby-cli'
end
