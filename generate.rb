#!/usr/bin/env ruby

require 'yaml'

entries = File.expand_path("./#{ARGV[0]}.yml")
if File.exists?(entries)
  data = YAML.load File.read(entries)
  data = data.inject({}) do |memo, project|
    language = project["language"]
    memo[language] ||= []
    memo[language] << project
    memo
  end

  data.sort.each do |language, projects|
    puts "[b]#{language}[/b]"
    projects.sort{ |a, b| a['name'].downcase <=> b['name'].downcase }.each do |project|
      print "[ul]"
      print "[li][b]#{project['name']}[/b]"
      print " by #{project['author']}" if project['author']
      puts
      puts project['thread'] if project['thread']
      puts "#{project['project']}[/li][/ul]"
    end
    puts
  end
else
  print <<-EOF
Please provide a command name

Usage:
  generate wow
  generate diablo
EOF
end

