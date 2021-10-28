# Write-Gig
Write (or overwrite) .gitignore files using existing .gitignore templates from the github/gitignore repo. 

# Parameters
### `-Template (-t)` : string
Define the .gitignore template you want to use.
- There are lots of templates for the majority of languages on the github/gitignore repo. C++, Java, Python, R, and so on. 
- If it's not in their repo, then you're out of luck. But you could always submit your own! 

# Examples
## Example 1: Create .gitnore for a python project
```PowerShell
Write-Gig Python
```

# Notes
If you already have a .gitignore in your current directory, you will be prompted to confirm that you intend to overwrite the existing .gitignore. 
```
There's already a .gitingore file in this directory 
Do you want overwrite it? (y/n): 
```
If you confirm with "y" you will see this confirmation message
```
".gitignore file composed for <TemplateName>"
```
If you choose not to overwrite your file you will see this message
```
Stopping process. 
No changes to .gitignore were made
```
If there was an issue getting an API response you will see this message
```
API request failed with error code <API Response Code>
Please check the template name. (It's case sensitive)
```
If this happens, ensure your spelling matches excatly the template name in the github/gitignore repo. If it does match, and errors are still being returned, open an issue or submit a PR.