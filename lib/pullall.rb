require 'lib_trollop'

SUB_COMMANDS = %w(add rm)
global_opts = Trollop::options do
  banner "Pull all the repos in a group"
  stop_on SUB_COMMANDS
end

cmd = ARGV.shift
cmd_opts = case cmd
  when "add"
    Trollop::options do
      opt :force, "Force deletion"
    end
  when "rm"
    Trollop::options do
      opt :group, "Copy twice for safety's sake", short: "-g"
    end
  else
    Trollop::die "Unknown subcommand #{cmd.inspect}"
  end

puts "Global options: #{global_opts.inspect}"
puts "Subcommand: #{cmd.inspect}"
puts "Subcommand options: #{cmd_opts.inspect}"
puts "Remaining arguments: #{ARGV.inspect}"
puts %x(git --git-dir #{ARGV[0]}/.git pull origin master)