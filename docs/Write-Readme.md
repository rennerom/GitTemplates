# Write-Readme
Scaffold a README file based on your input to a few cli prompts. You'll also have an option to create a LICENSE file in the process. 

# Parameters
### `-xtoc (-xt)` : switch
- Exclude Table Of Contents
- By default, your README file will include a Table of Contents (TOC). If you perfer to exclude a TOC, then supply a `-xtoc` or `-xt` tag. 

### `-Test (-t)` : switch
- Execute a dry run by appending `_test` to the file names for your README and LICENSE files.
- If you want avoid accidently overwriting exiting README or LICENSE files, do a dry run by supplying a `-Test` or `-t` tag. This will append `_test` to your README or LICENSE file names.

# Examples
## Example 1: Basic Use
```PowerShell
Write-Readme
```
Executing the command `Write-Readme` returns the cli prompt to get you started
```
Enter project title or name (or skip for default):
Enter a brief subtitle or synopsis for the project (or skip for default):
Enter a brief overview or for this project (or skip to exclude):
...
```

## Example 2: Exclude Table of Contents
```PowerShell
Write-Readme -xt
```
Add the `-xtoc` or `-xt` tag to generate the same README, but without a Table of Contents

## Example 3: Doing a test run
```PowerShell
Write-Readme -Test
```
Add the `-Test` or `-t` tag to do generate a README_test (and optional LICENSE_test) file. 

# Notes
## File Protection
:warning:__Overwriting existing README and LICENSE files__:warning:

Didn't realize you were in the wrong directory until it was too late? No sweat. If you create a README or LICENSE file in a directory where one already exists, you will be prompted to confirm that you intend to save over your old copy. You also have the option to save a unique copy if you don't want to redo all the work you just did. 

A unique copy is just the README.md or LICENSE.txt file name with a unique 7 digit number inserted with an underscore between the file name and the file extension. 
```
README_BB7E001.md
LICENSE_BB7E001.txt
```
The unique identifiers will always match both LICENSE and README files are saved as unique copies in the same Write-Readme call.

You also have the option of stopping all progress and exiting at this point too by choosing `Exit and save nothing`

## License upkeep
If you decide to add a license, you may want to edit the file after it's created. Some licenses have placeholders for the copywrite year and the copywrite holders name. The MIT license for exmaple starts with...

> Copyright (c) __[year] [fullname]__

You'd want to replace the year and full name appropriately.
## Readme Outline
This is by no means a final product. There are lots of inefficiencies epsecially with the menu select for choosing a license. The layout and template could also be refined. At some point, it would be a good idea to have more than one template option as not all projects require the same type or layout of documentation.

In any case, here is the basic outline...

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

