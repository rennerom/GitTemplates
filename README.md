# Purose
A simple PowerShell module to generate .gitignore files from templates on the github/gitignore repo

# Requirements
This works on Windows. I haven't tested it on anything else since I primarily use PowerShell only on windows machines. But I think it's set up to work well on Mac/Linux. If you run into issues let me know.

# Use
Install Module from Github, or download this repo and import module
The `Write-Gig` cmdlet writes (or overwrites) a new .gitignore file. 

You need to supply the template name. If I'm working on a Python project and I want to create a .gitignore file from PowerShell, then execute the command
```PowerShell
Write-Gig Python
```

If you are running Windows, and for some reason want to make your .gitignore files visible, supply the `-Visible` or `-v` tag to your command. 
```PowerShell
Write-Gig Python -v
```
#Info
Contact: rennerom@gmail

# TODO
- [ ] Verify other OS compatibility
- [ ] Error handling for `-v` flag on non windows machines
