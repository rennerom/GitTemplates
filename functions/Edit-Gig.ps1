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

        # Create text string
        $TextString = "# $Comment"
        $PatternString = $Pattern
        $OutputText = "$TextString,$PatternString"
        $FullOutputText = $OutputText.Split(",").Trim()

        write-host("Appending to .gitignore`n--------------------`n$FullOutputText")
        Add-Content -Path .gitignore -Value "`n$FullOutputText"
    }
}