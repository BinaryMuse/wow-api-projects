#!/usr/bin/env ruby

require 'yaml'

unless api = ARGV[0]
  puts "You must specify an API as the first parameter"
  exit 1
end

data = YAML.load File.read(File.expand_path('./projects.yml'))
data = data.inject({}) do |memo, project|
  language = project["language"]
  memo[language] ||= []
  memo[language] << project
  memo
end

data.sort.each do |language, projects|
  next unless projects.any? { |p| p['apis'].include?(api) }
  puts "[b]#{language}[/b]"
  projects.sort{ |a, b| a['name'].downcase <=> b['name'].downcase }.each do |project|
    next unless project['apis'].include?(api)
    print "[ul]"
    print "[li][b]#{project['name']}[/b]"
    print " by #{project['author']}" if project['author']
    puts
    puts project['thread'] if project['thread']
    puts "#{project['project']}[/li][/ul]"
  end
  puts
end
