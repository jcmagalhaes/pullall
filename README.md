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
