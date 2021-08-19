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
        https://www.github.com/rennerom/GitignoreTemplates
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

Export-ModuleMember -function Write-Gig
