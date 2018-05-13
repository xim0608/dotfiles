goenv_root = "/Users/#{ENV['USER']}/.goenv"
git goenv_root do
  repository "https://github.com/syndbg/goenv.git"
  not_if {Dir.exists?(goenv_root)}
end

go_version = '1.9.4'
execute 'install go' do
  user ENV['USER']
  command "goenv rehash && goenv install #{go_version}"
  not_if {
    result = run_command('goenv versions', error: false)
    result.stdout.include?(go_version)
  }
end

execute 'globalize go && reload shell' do
  user ENV['USER']
  command "exec $SHELL -l && goenv global #{go_version}"
  not_if {
    result = run_command('go version', error: false)
    result.stdout.include?(go_version)
  }
end

# execute 'install hugo && rehash' do
#   user ENV['USER']
#   command "go get hugo && goenv rehash"
#   not_if {
#     package_name = 'hugo'
#     result = run_command("type #{package_name}", error: false)
#     result.exit_status == 0
#   }
# end
