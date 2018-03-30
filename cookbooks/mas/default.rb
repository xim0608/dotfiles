mas_json = File.read("./cookbooks/mas/files/#{node[:os]}.json")
node.reverse_merge!(JSON.load(mas_json))

node['mas_ids'].each do |mas_id|
  execute "mas install #{mas_id}"
end
