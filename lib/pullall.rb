require 'pullall/lib_trollop'
require 'pullall/actions'

class Pullall
  extend Action
  
  SUB_COMMANDS = %w(add rm)
  global_opts = Trollop::options do
    banner "Pull all the repos in a group"
    stop_on SUB_COMMANDS
  end

  def self.run(*args)
    cmd = args.shift
    
    cmd_opts = case cmd
    when "add"
      size = args.size
      if size == 2
        save_path(args[0], args[1])
      else
        Trollop::die "You must add one path to a group"
      end
    when "rm"
      Trollop::options do
        opt :group, "Copy twice for safety's sake", short: "-g"
      end
    else
      if args.size == 0
        pull(cmd)
      else
        Trollop::die "Unknown subcommand or invalid number of arguments"
      end
    end
  end

  #puts "Global options: #{global_opts.inspect}"
  #puts "Subcommand: #{cmd.inspect}"
  #puts "Subcommand options: #{cmd_opts.inspect}"
  #puts "Remaining arguments: #{ARGV.inspect}"
  #puts %x(git --git-dir #{ARGV[0]}/.git pull origin master)
end