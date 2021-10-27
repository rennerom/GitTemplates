# Purpose
A simple PowerShell module to generate common files for git repos

# Getting Started
Install Module from Github, or download this repo and import module

# How to Use
## .gitignores
- [`Write-Gig`](docs/Write-Gig.md)
  - Write (or overwrite) .gitignore files using existing .gitignore templates from the github/gitignore repo. 
- [`Edit-Gig`](docs/Edit-Gig.md)
  - Add to an existing .gitignore file by appending text to it.
## READMEs
- [`Write-Readme`](docs/Write-Readme.md)
  - Scaffold a README file based on your input to a few cli prompts. You'll also have an option to create a LICENSE file in the process. 

# Notes
I split a lot of my work between Windows, Mac, and Linux machines. Most of what I have in this repo has been testing on all three, but not everything. 

The gitignore functions were mainly built and tested on windows.

The readme function was mainly built and tested on Mac and Linux. 

Drop a PR or open an issue if you see something that's not working.

# Info
Contact: rennerom@gmail

# TODO
- [x] Add an Edit-Gig function
- [x] Add a Write-Readme function
- [x] Add a Write-License function (now part of Write-Readme)
- [ ] Verify other OS compatibility
- [ ] Error handling for `-v` flag on non windows machines
- [ ] Add other README template layouts
