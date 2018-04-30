package 'ndenv'

ndenv_root = "/Users/#{ENV['USER']}/.ndenv/plugins/node-build"
git ndenv_root do
  repository 'https://github.com/riywo/node-build.git'
  not_if { Dir.exists?(ndenv_root)}
end

# execute 'reloading shell' do
#   user ENV['USER']
#   command 'source ~/.zshenv'
# end

node_version = 'v8.11.1'
execute 'install node' do
  user ENV['USER']
  command "ndenv install #{node_version}"
  not_if {
    result = run_command('ndenv versions', error: false)
    result.stdout.include?(node_version)
  }
end

execute 'rehash ndenv && globalize ndenv version' do
  user ENV['USER']
  command "ndenv rehash && ndenv global #{node_version}"
  not_if {
    result = run_command('npm -v', error: false)
    result.exit_status == 0
  }
end

execute 'install gatsbyjs' do
  user ENV['USER']
  command 'npm install --global gatsby-cli'
  not_if {
    package_name = 'gatsby'
    result = run_command("type #{package_name}", error: false)
    !result.stdout.include?('not found')
  }
end
