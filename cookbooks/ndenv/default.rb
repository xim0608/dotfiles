# package 'ndenv'
ndenv_root = "#{ENV['HOME']}/.ndenv"
git ndenv_root do
  repository "https://github.com/riywo/ndenv.git"
  not_if {Dir.exists?(ndenv_root)}
end

node_build_root = "#{ENV['HOME']}/.ndenv/plugins/node-build"
git node_build_root do
  repository 'https://github.com/riywo/node-build.git'
  not_if { Dir.exists?(node_build_root)}
end

#node_version = 'v8.11.1'
#execute 'install node' do
#  user ENV['USER']
#  command "ndenv install #{node_version}"
#  not_if {
#    result = run_command('ndenv versions', error: false)
#    result.stdout.include?(node_version)
#  }
#end

#execute 'rehash ndenv && globalize ndenv version' do
#  user ENV['USER']
#  command "ndenv rehash && ndenv global #{node_version}"
#  not_if {
#    result = run_command('npm -v', error: false)
#    result.exit_status == 0
#  }
#end
