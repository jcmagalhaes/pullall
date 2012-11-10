require 'rubygems'
require 'oj'

module Action

  STORAGE = "#{ENV['HOME']}/.pullall"

  def get_real_paths(paths)
    paths.collect! do |path|
      if File.exists?(path)
        File.realpath(path)
      else
        Trollop::die "The path #{path} doesn't exist"
      end  
    end
    paths
  end

  def list_groups
    groups = load_all
    groups.each do |group, paths|
      puts "#{group} - #{paths}"
    end
  end

  def save_all(groups)
    json = Oj.dump(groups)
    Oj.to_file(STORAGE, json)
  end

  def save_paths(*paths, group)
    groups = load_all
    
    # Use real path to allow the use of .(current directory) as an argument
    if groups.has_key?(group)
      paths.each do |path|
        if groups[group].include?(path)
          Trollop::die "Path #{path} already exists in group #{group}"
        end
      end
      groups[group].push(*paths)
    else
      groups[group] = [*paths]
    end
    save_all(groups)
    puts "Path successfully saved"
  end

  def load_paths(group)
    groups = load_all
    if groups.has_key?(group)
      groups[group]
    else
      Trollop::die "Group #{group} doesn't exist"
    end
  end

  def load_all
    begin
      if not File.exists?(STORAGE)
        # Initiate file with valid json
        File.new(STORAGE, "w")
        Oj.to_file(STORAGE, Oj.dump({}))
      end
      json = Oj.load_file(STORAGE)
      Oj.load(json)
    rescue
      Trollop::die "~/.pullall has invalid JSON. If you changed that file then 
                    fix it so that it has valid json. If this problem persists
                    remove the file (rm ~/.pullall)."
    end
  end

  def remove_group(group)
    groups = load_all
    deleted = groups.delete(group)
    msg = deleted ? "Group successfully deleted" : "Group doesn't exist"
    save_all(groups)
    puts msg
  end

  def remove_paths(*paths, group)
    groups = load_all

    if groups.has_key?(group)
      paths = groups[group]
      if not paths.delete(path)
        Trollop::die "Given path doesn't belong to group #{group}" 
      end
      save_all(groups)
      puts "Path successfully removed from group #{group}"
    else
      Trollop::die "Group #{group} doesn't exist"
    end
  end

  def pull(group)
    paths = load_paths(group)
    paths.each do |path|
      puts "Pulling from #{path}:"
      %x(git --git-dir #{path}/.git pull origin master)  
      puts "\n"
    end
  end
end