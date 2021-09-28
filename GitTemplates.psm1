Function Write-Gig {
    <#
        .SYNOPSIS
        Download gitignore templates from the github/gitignore repo
        .DESCRIPTION
        Create a .gitignore file from templates found on the github/gitignore repo. 
        Simply provide a parameter for the template name (e.g 'Write-Gig Python')
        If a Python.gitignore template is in that repo (it is), Write-Gig will create a 
        new .gitignore file using that template.
        .PARAMETER Template
        Parameter Template is mandatory. By specifying the Template you are telling 
        Write-Gig what gitignore template to search for.
        .PARAMETER Visible
        Parameter Visible is optional and is intended for Windows use only. 
        You can use the -Visible (-v) switch to make your .gitignore visible
        instead of hidden, if that's what you're into.
        .OUTPUTS
        a .gitignore file in the current directory
        .EXAMPLE
        Write-Gig Python
        Create .gitignore file for Python
        .EXAMPLE
        Write-Gig Python -v
        Create a visible (non hidden file attribute) .gitignore file
        for Python (This will only work on Windows)
        .LINK
        https://www.github.com/rennerom/GitTemplates
    #>

    # ----------------------params
    param(
        # .gitignore template name
        [Alias('t')]
        [string]$Template,

        # set file attributes for .gitignore to visible (windows only)
        [Alias('v')]
        [switch]$Visible
        )

    # Set .gitignore template url
    $url = "https://raw.githubusercontent.com/github/gitignore/master/$($Template).gitignore"
    
    # Determin OS type (limited ability to test this out accross platforms)
    $os = [System.Environment]::OSVersion.Platform

    if ($os = "Win32NT") {
        $filePrefix =".\"
    } else {
        $filePrefix = ""
    }

    # Feedback
    Write-Host "Downloading .gitignore template from $($url)"
    
    try {
        # Grab web content and output it to a .gitignore file
        $file = Invoke-WebRequest -Uri $url | Select-Object -Expand Content | `
        Set-Content $filePrefix".gitignore" -Force -ErrorAction stop

    }
    catch {
        # Error handling
        Write-Host @("There was an error while downloading the $($Template)"
                ".gitignore template from a GitHub repository."
                "`nPlease check the template name. (It's case sensitive)") `
                -ForegroundColor Yellow
        break
    }

    # Set hidden attribute if needed else make visible
    if (-Not $Visible) {
        (Get-Item .\.gitignore -FORCE).Attributes = `
        (Get-Item .\.gitignore -FORCE).Attributes -bxor [io.fileattributes]::Hidden
    } else {
        write-host "Making .gitignore visible"
    }

    # Wrap up
    Write-Host "Done"
    }

Function Edit-Gig{
    <# 
        .SYNOPSIS
        Edit an existing .gitignore file by appending text to it.
        .DESCRIPTION
        Add files or directories to existing .gitignore file. 
        Supply your ignore string (or multiple separated with a comma)
        and a comment (optional) to append to your .gitignore.
        .PARAMETER Pattern
        Parameter (p) is mandatory. By specifying the pattern 
        you are telling Edit-Gig what patterns for files/directories 
        to append to your .gitignore.
        .PARAMETER Comment
        Parameter Comment (c) is optional. You can suppply a comment to help
        organize/document your .gitignore file. The comment line will appear 
        before your appended .gitingore patterns. The default is 
        "Appended on <datestamp>"
        .EXAMPLE
        Edit-Gig -p ".txt" -c "Ignore all .txt files"

        Appends the following text to your .gitigore file.
        -------------------------------------------------
        |# Ignore all .txt files                        |
        |.txt                                           |

        .EXAMPLE
        Edit-Gig -p ".txt, .csv"

        Appends the following text to your .gitigore file.
        -------------------------------------------------
        |# Appended on <datestamp>                      |
        |.txt                                           |
        |.csv                                           |

        .LINK
        https://www.github.com/rennerom/GitTemplates
    #>
    
    # ----------------------params
    param(
        # pattern for file/dir (can be a list)
        [Alias('p')]
        [string]$Pattern,

        # Comment line
        [Parameter(Mandatory=$false)]
        [Alias('c')]
        [string]$Comment = "Appended on $(Get-Date -Format M/d/yy)"
        )

    # Check if .gitignore is there

    if(-not(Test-Path -Path .gitignore -PathType Leaf)) {  

        Write-Host "`nNo .gitignore file found in this directory`n"
        
    } else {

        # Set Comment String and list string
        $CommentString = "# $Comment"
        $PatternString = $Pattern.Split(",").Trim()

        $FullOutputText = "$CommentString`n$PatternString"

        write-host("Appending to .gitignore`n--------------------`n$FullOutputText")
        Add-Content -Path .gitignore -Value "`n$FullOutputText"
    }
}