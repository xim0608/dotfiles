pyenv_root = "#{ENV['HOME']}/.pyenv"
git pyenv_root do
  repository "https://github.com/pyenv/pyenv.git"
  not_if {Dir.exists?(pyenv_root)}
end

python_version = '3.6.5'
execute 'install python' do
  user ENV['USER']
  command "pyenv install #{node_version}"
  not_if {
    result = run_command('pyenv versions', error: false)
    result.stdout.include?(python_version)
  }
end

execute 'rehash pyenv && globalize pyenv version' do
  user ENV['USER']
  command "pyenv rehash && pyenv global #{node_version}"
  not_if {
    result = run_command('python --version', error: false)
    result.exit_status == 0
  }
end
