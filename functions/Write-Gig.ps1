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
        .OUTPUTS
        a .gitignore file in the current directory
        .EXAMPLE
        Write-Gig Python
        Create .gitignore file for Python
        .LINK
        https://www.github.com/rennerom/GitTemplates
        .Notes
        This function was influenced by Senad Meskin's gist at
        https://github.com/senad-meskin/powerscripts/blob/master/git-ignore.ps1
    #>

    # ----------------------params
    param(
        # .gitignore template name
        [Alias('t')]
        [string]$Template
    )

    # Set .gitignore template url
    $url = "https://raw.githubusercontent.com/github/gitignore/master/$($Template).gitignore"

    Write-Host "Downloading .gitignore template from $($url)"
    
    try {
        # Grab web content and output it to a .gitignore file
        # Opted for API call via Invoke-RestMethod
        # and grepping any weirdness that comes back
        if (Test-Path .gitignore) {

            $prompt = @(
                "There's already a .gitingore file in this directory"
                "`nDo you want overwrite it? (y/n)"
            )

            $response = Read-Host -Prompt $prompt

            while ("y", "n", "yes", "no" -notcontains $response.ToLower()) {
                Clear-Host
                $response = Read-Host -Prompt $prompt
            }

            if ("y", "yes" -contains $response.ToLower()) {
                writeFile -url $url
                Write-Host ".gitignore file composed for $Template"
            }
            else {
                Write-Host @(
                    "Stopping process."
                    "`nNo changes to .gitignore were made"
                )
            }
        }
        else {
            writeFile -url $url
            Write-Host ".gitignore file composed for $Template"
        }
        
    }

    catch {
        $respCode = $_.Exception.Response.StatusCode.value__
        if ($respCode -ne 200) {
            Write-Host @(
                "API request failed with error code $respCode"
                "`nPlease check the template name. (It's case sensitive)") `
                -ForegroundColor Yellow
        } 
    }
}

function writeFile ([string]$url) {
    $content = (Invoke-RestMethod -Uri $url) -replace "\n{3,}"
    $content | Out-File .gitignore -noNewLine
}