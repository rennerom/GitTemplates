# Purpose
A simple PowerShell module to generate common files for git repos

# Requirements
This works on Windows. I haven't tested it on anything else since I primarily use PowerShell only on windows machines. But I think it's set up to work well on Mac/Linux. If you run into issues let me know.

# Use
Install Module from Github, or download this repo and import module

## `Write-Gig`
The `Write-Gig` cmdlet writes (or overwrites) a new .gitignore file. 

You need to supply the template name. If I'm working on a Python project and I want to create a .gitignore file from PowerShell, then execute the command
```PowerShell
Write-Gig Python
```

If you are running Windows, and for some reason want to make your .gitignore files visible, supply the `-Visible` or `-v` tag to your command. 
```PowerShell
Write-Gig Python -v
```

## `Edit-Gig`
The `Edit-Gig` cmdlet edits an existing .gitignore file by appending text to it.

You need to supply the pattern, and optionally a comment to go along with what you are appending. If you want to add .txt files to a .git ignore file, then execute the command
```PowerShell
Edit-Gig -p ".txt"
```

This appends the following text to your .gitignore with the default comment block
```
# Appended on <datestamp>
.txt
```

You can also provide multiple files or directory patterns to ignore, in addition to adding your own comment to the appended text.
```PowerShell
Edit-Gig -p ".txt, .csv" -c "Ignore all txt and csv files"
```
This appends the following text to your .gitignore with your supplied comment block
```
# Ignore all txt and cvs files
.txt
.csv
```

# Info
Contact: rennerom@gmail

# TODO
- [ ] Add a Write-Readme function
- [ ] Add a Write-License function
- [ ] Verify other OS compatibility
- [ ] Error handling for `-v` flag on non windows machines
