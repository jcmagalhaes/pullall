require 'pullall/lib_trollop'
require 'pullall/actions'

class Pullall
  extend Actions
  
  SUB_COMMANDS = %w(add rm ls)
  help = <<HELP

  Pull all the repositories that belong to a group you created.

  Usage:

    pullall <group>                         # pull all the repos from <group>
    pullall ls                              # list all the groups
    pullall add <path> -g <group>           # add <path> to <group>. If <group> doesn't exist create it
    pullall add <path1> <path2> -g <group>  # add multiple paths to <group>
    pullall rm <path> -g <group>            # remove <path> from <group>
    pullall rm <path1> <path2> -g <group>   # remove multiple paths from <group>
    pullall rm -g <group>                   # remove entire group of repositories

  Examples: 

    # Add repository located in ~/iterar/projects/stethoscore to the group named iterar
    pullall add ~/iterar/projects/stethoscore -g iterar

    # Create empty group named savant
    pullall add -g savant 

    # Add all the repositories in the current directory to the group savant
    pullall add * -g savant 

    # Remove all the repositories included in group savant
    pullall rm * -g savant

HELP

  global_opts = Trollop::options do
    banner help
    stop_on SUB_COMMANDS
  end

  def self.run(*args)
    cmd = args.shift
    
    # Set options for each subcommand
    cmd_opts = case cmd
    when "add" 
      Trollop::options do
        opt :group, "Group that will contain all the given paths", short: "-g", type: :string
      end
    when "rm"
      Trollop::options do
        opt :group, "Group from which all the given paths will be deleted", short: "-g", type: :string
      end
    end
    
    case cmd
    when "add"
      group = cmd_opts[:group]
      if group
        group_opt_index = args.index('-g') || args.index('--group')
        paths = get_real_paths(args - args[group_opt_index..group_opt_index + 1])
        save_paths(*paths, cmd_opts[:group])
      else  
        Trollop::die "You must define a group name using -g option"
      end
    when "ls"
      list_groups
    when "rm"
      group = cmd_opts[:group]
      if group 
        group_opt_index = args.index('-g') || args.index('--group')
        paths = get_real_paths(args - args[group_opt_index..group_opt_index + 1])
        if paths.empty?
          remove_group(group)
        else
          remove_paths(*paths, group)
        end
      else  
        Trollop::die "You must define a group name using -g option"
      end
    else
      # pullall <group> 
      if args.size == 0 and cmd
        pull(cmd)
      else
        Trollop::die "Unknown subcommand"
      end
    end
  end
end