mas_json = File.read("./cookbooks/mas/files/#{node[:os]}.json")
node.reverse_merge!(JSON.load(mas_json))

node['mas_ids'].each do |mas_id|
  execute "install package" do
    user ENV['USER']
    command "mas install #{mas_id}"
    not_if {
      result = run_command("mas list | grep #{mas_id}", error: false)
      result.exit_status == 0
    }
  end
end
