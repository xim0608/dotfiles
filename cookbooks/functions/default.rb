node.reverse_merge!(
  os: run_command('uname').stdout.strip.downcase,
)

define :ln do
  dotfile = File.join(ENV['HOME'], params[:name])
  link dotfile do
    to File.expand_path("../../../config/#{params[:name]}", __FILE__)
    user node[:user]
  end
end
