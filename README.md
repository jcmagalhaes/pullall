# Pullall

This ruby gem allows you to get the most of Git by letting you pull all the repositories that belong to a group you created.

## Installation
All you need to do is install the gem and then you're ready to pull a group of repositories at once using the command *pullall*.
    
    gem install pullall

## How to use it

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

## Next steps

* Specify branch from which to pull
* Format output messages
* Add tests
* Code refactoring

## License

The MIT License

Copyright (c) 2012 Iterar, João Magalhães

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.