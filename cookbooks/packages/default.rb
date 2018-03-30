packages_json = File.read("./cookbooks/packages/files/#{node[:os]}.json")
node.reverse_merge!(JSON.load(packages_json))

node['packages'].each do |package_name|
  package package_name
end
