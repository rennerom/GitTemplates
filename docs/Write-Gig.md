# Write-Gig
Write (or overwrite) .gitignore files using existing .gitignore templates from the github/gitignore repo. 

# Parameters
### `-Template (-t)` : string
Define the .gitignore template you want to use.
- There are lots of templates for the majority of languages on the github/gitignore repo. C++, Java, Python, R, and so on. 
- If it's not in their repo, then you're out of luck. But you could always submit your own! 

### Parameter `-Visible (-v)` : switch
.gitignore files are hidden by default. Make your .gitignore visible instead, if that's what you're in to. 
:warning:_windows only_:warning:

# Examples
## Example 1: Create .gitnore for a python project
```PowerShell
Write-Gig Python
```

## Example 2: Make your .gitignore not hidden
```PowerShell
Write-Gig Python -v
```

# Notes
`-Visible` (`-v`) tags are dumb, and I don't know why I'm including them at all. I haven't tested what happens on a non-windows machine if you use this, but I'm confident it won't work. It would be a good idea to remove this outright, or add some error handling for the switch. 