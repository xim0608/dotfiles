# ghq
package 'ghq'

# gatsby-js
execute 'install gatsbyjs' do
  user ENV['USER']
  command 'npm install --global gatsby-cli'
  not_if {
    package_name = 'gatsby'
    result = run_command("type #{package_name}", error: false)
    result.exit_status == 0
  }
end

# fast-cli
execute 'install fast-cli' do
  user ENV['USER']
  command 'npm install --global fast-cli && ndenv rehash'
  not_if {
    package_name = 'fast'
    result = run_command("type #{package_name}", error: false)
    result.exit_status == 0
  }
end

# itunes-cli
execute 'install itunes-cli' do
  user ENV['USER']
  command 'GOPATH=$HOME/Works go get github.com/ktr0731/itunes-cli/itunes && GOPATH=$HOME/Works go install github.com/ktr0731/itunes-cli/itunes'
  not_if {
    package_name = 'itunes'
    result = run_command("type #{package_name}", error: false)
    result.exit_status == 0
  }
end
