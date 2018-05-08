tar_file_name = "./google-cloud-sdk-192.0.0-darwin-x86_64.tar.gz"
# base
base_target_dir = "$HOME"
shell_dir = "$HOME/google-cloud-sdk"
shell_file = "#{shell_dir}/install.sh"

execute "download gcloud sdk files" do
  command "curl -o #{tar_file_name} -fL https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-192.0.0-darwin-x86_64.tar.gz"
  not_if {
    result = run_command("type gcloud", error: false)
    File.exists?(tar_file_name) || result.exit_status == 0
  }
end

execute "extract and remove gcloud-sdk.tar.gz" do
  command "tar zxvf #{tar_file_name} -C $HOME && rm #{tar_file_name}"
  not_if {
    result = run_command("type gcloud", error: false)
    File.exists?("#{base_target_dir}/google-cloud-sdk/install.sh") || result.exit_status == 0
  }  
end

execute "install gcloud sdk" do
  command "sh #{shell_file} --usage-reporting false --command-completion true --path-update true --rc-path $HOME/.zshrc"
  not_if {
    result = run_command("type gcloud", error: false)
    result.exit_status == 0
  }
end
