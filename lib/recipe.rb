include_recipe 'recipe_helper'

node.reverse_merge!(user: ENV['USER'])

include_role node[:platform]
