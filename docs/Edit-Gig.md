# `Edit-Gig`
Add to an existing .gitignore file by appending text to it.

## Parameters
#### Parameter `-Pattern (-p)` : string
Define the pattern(s) you want to add to your .gitigore
- The `-Pattern` or `-p` tag can take a single pattern (ie. `".txt"`) , or multiple comma separated patterns (ie `".txt, .csv, node_modules/"`).

#### Parameter `-Comment (-c)` : string
Define a custom comment block above each `Edit-Gig` entry.
- The default comment is `# Appended on <datestamp>` but can be changed using the `-Comment` or `-c` tag followed by your comment string.

## Examples
#### Example 1: Append a single pattern
```PowerShell
Edit-Gig -p ".txt"
```
```
# Appended on <datestamp>
.txt
```

#### Example 2: Append multiple patterns
```PowerShell
Edit-Gig -p ".txt, .csv, /node_modules"
```
```
# Appended on <datestamp>
.txt
.csv
/node_modules
```

#### Example 3: Adding a comment
```PowerShell
Edit-Gig -p ".txt" -c "Ignore all txt files"
```
```
# Ignore all txt files
.txt
```