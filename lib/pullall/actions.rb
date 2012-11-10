require 'rubygems'
require 'oj'

module Action

  STORAGE = "#{ENV['HOME']}/.pullall"

  def save_all(groups)
    Oj.to_file(STORAGE, groups)
    puts "Group successfully saved."
  end

  def save_path(path, group)
    File.new(STORAGE, "w") if not File.exists?(STORAGE)
    groups = load_all
    if groups
      # Use real path to allow the use of .(current directory) as an argument
      path = File.realpath(path)
      if groups.has_key?(group)
        groups[group] << path
      else
        groups[group] = [path]
      end
    else 
      groups = { group => [path] }
    end
    json = Oj.dump(groups)
    save_all(json)
  end

  def load_paths(group)
    groups = load_all
    if groups and groups.has_key?(group)
      groups[group]
    else
      Trollop::die "Group #{group} doesn't exist"
    end
  end

  def load_all
    begin
      json = Oj.load_file(STORAGE)
      Oj.load(json)
    rescue
      nil
    end
  end

  def pull(group)
    paths = load_paths(group)
    paths.each do |path|
      puts "Pulling from #{path}:"
      %x(git --git-dir #{group}/.git pull origin master)  
      puts "\n"
    end
  end
end