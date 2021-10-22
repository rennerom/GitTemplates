# Purpose
A simple PowerShell module to generate common files for git repos

# Requirements
This works on Windows. I haven't tested it on anything else since I primarily use PowerShell only on windows machines. But I think it's set up to work well on Mac/Linux. If you run into issues let me know.

As of 10/22/21, I added a Write-Readme function. Oddly enough, I did all the work on MacOS and haven't confirmed it's compatibility with Windows yet. Drop a PR or open an issue if you see something that's not working.

# Use
Install Module from Github, or download this repo and import module

### `Write-Gig`
The `Write-Gig` cmdlet writes (or overwrites) a new .gitignore file. 

You need to supply the template name. If I'm working on a Python project and I want to create a .gitignore file from PowerShell, then execute the command
```PowerShell
Write-Gig Python
```

If you are running Windows, and for some reason want to make your .gitignore files visible, supply the `-Visible` or `-v` tag to your command. 
```PowerShell
Write-Gig Python -v
```

### `Edit-Gig`
The `Edit-Gig` cmdlet edits an existing .gitignore file by appending text to it.

You need to supply a `-Pattern` or `-p` tag to define what patterns you want to ignore. If you want to add .txt files to a .gitignore file, then execute the command
```PowerShell
Edit-Gig -p ".txt"
```

This appends the following text to your .gitignore with the default comment block
```
# Appended on <datestamp>
.txt
```

You can also provide multiple files or directory patterns to ignore, and optionally a `-Comment` or `-c` tag to comment the appended patterns.
```PowerShell
Edit-Gig -p ".txt, .csv" -c "Ignore all txt and csv files"
```
This appends the following text to your .gitignore with your supplied comment block
```
# Ignore all txt and cvs files
.txt
.csv
```

### `Write-Readme`
The `Write-Readme` cmdlet scaffolds a README.md file based on your input to a few cli prompts. You'll also have an option to create a LICENSE.txt file in the proces. 

You can supply a `-xtoc` or `-xt` tag to exclude the Table of Contents from your README. If you want to do a dry run to test any output, supply a `-Test` or `-t` tag to append "_test" to your README or LICENSE file names. 

If you decide to add a license, you may want to edit the file after it's created. Some licenses have placeholders for the copywrite year and the copywrite holders name. The MIT license for exmaple starts with 

Copyright (c) __[year] [fullname]__

You'd want to replace the year and full name appropriately.

This is by no means a final product. There are lots of inefficiencies epsecially with the menu select for choosing a license. The layout and template could also be refined. At some point, it would be a good idea to have more than one template option as not all projects require the same type or layout of documentation.

In any case, basic outline this function follows is this...
* Title
  * subtitle
* Table of Contents (Optional)
  * toc 1
  * toc 2
  * toc 3
  * ...
* Overview (Optional)
  * Overview description
* Getting Started (Optional)
  * Describe any prerequisites needed
* Usage
  * Basic use guidance
* Notes (Optional)
  * Addtional notes provided
* TODO (Optional)
    - [ ] item 1
    - [ ] item 2
    - [ ] item 3
* Contact (Optional)
  * Name and email
* License (Optional)
  * License type

# Info
Contact: rennerom@gmail

# TODO
- [x] Add an Edit-Gig function
- [x] Add a Write-Readme function
- [x] Add a Write-License function (now part of Write-Readme)
- [ ] Verify other OS compatibility
- [ ] Error handling for `-v` flag on non windows machines
- [ ] Add other README template layouts
