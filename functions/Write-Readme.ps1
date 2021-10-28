Function Write-Readme {
    <#
        .SYNOPSIS
        Create a README.md file quickly
        .DESCRIPTION
        Answer the prompts to generate a README.md file
        .PARAMETER xtoc
        xtoc (-xt) is a switch parameter used when you want to exclude 
        a Table of Contents from your README.md file. By not providing 
        the switch parameter, a Table of Contents will be indlucded.
        .PARAMETER Test
        Test (-t) is a switch parameter used when you want to do a test run.
        When included, all README and LICENSE file outputs will have a 
        '_test' suffix. 
        .OUTPUTS
        a README.md file in the current directory 
        and if you choose to
        a LICENSE.txt file in the current directory
        .EXAMPLE
        Write-Readme
        Then answer the prompts as they come up to scaffold your README.md
        .EXAMPLE
        Write-Readme -t
        Scaffold a README_test.md (and optionally a LICENSE_test.txt)
        .Example
        Write-Readme -xt -t
        Scaffoled a README_test.md (and optionally a LICENSE_test.txt)
        without a Table of Contents in the README_test.txt file
        .LINK
        https://www.github.com/rennerom/GitTemplates
    #>

    param(
        [Alias('xt')]
        [switch]$xtoc,
        [Alias('t')]
        [switch]$Test
    )

    if ($Test) {
        $ReadmeFileName = "README_test.md"
    }
    else {
        $ReadmeFileName = "README.md"
    }

    if(test-Path $ReadmeFileName){
        $hashValue = $(uniqueHash)
    }

    $Script:mdToc = [System.Collections.ArrayList]@(
        "`n## Contents"
    )

    $Script:mdBody = [System.Collections.ArrayList]@()

    Clear-Host

    # Project Name and Overview
    $ProjName = Read-Host -Prompt "Enter project title or name (or skip for default)"
    
    Clear-Host

    if (checkEntry($ProjName)) {
        $ProjName = $ProjName
        $ProjOverview = Read-Host -Prompt "Enter a brief subtitle or synopsis for the project (or skip for default)"
    }
    else {
        $ProjName = "Project Name"
        $ProjOverview = "Enter a subtitle or synopsis here"
    }

    $mdHeader = [System.Collections.ArrayList]@(
        "# $ProjName"
        "$ProjOverview"
    )

    Clear-Host

    $overview = Read-Host -Prompt "Enter a brief overview or for this project (or skip to exclude)"
    if (checkEntry($overview)) {
        addToBody("`n# Overview")
        addToBody("$overview")
        addToToc("Overview")
    }
 
    Clear-Host

    $start = Read-Host -Prompt "Brief description of 'How To Start' this project (or skip to exclude)"
    if (checkEntry($start)) {
        addToBody("`n# Getting Started")
        addToBody("$start")
        addToToc("Getting Started")

    }

    Clear-Host

    $use = Read-Host -Prompt "Brief description of this projects basic usage (or skip for default)"
    if (checkEntry($use)) {
        addToBody("`n# Usage")
        addToBody("$use")
    }
    else {
        addToBody("`n# Usage")
        addToBody("Brief description of usage goes here")
    }
    addToToc("Usage")
 
    Clear-Host

    $notes = Read-Host -Prompt "Provide a brief summary of any notes for this project (or skip to exclude)"
    if (checkEntry($start)) {
        addToBody("`n# Notes")
        addToBody("$notes")
        addToToc("Notes")

    }
    
    Clear-Host

    $todo = Read-Host "Do you want to include a TODO segment (y/n)?"

    while ("y", "n", "yes", "no" -notcontains $todo.ToLower()) {
        Clear-Host
        $contact = Read-Host "Do you want to have a TODO segment (y/n)?"
    }

    if ("y", "yes" -contains $todo.ToLower()) {
        addToBody("`n# TODO")
        addToBody(@(
                "   - [ ] first"
                "`n   - [ ] second"
                "`n   - [ ] third"
            ))
        addToToc("TODO")
    }

    Clear-Host

    $contact = Read-Host "Do you want to have a Contact segment (y/n)?"

    while ("y", "n", "yes", "no" -notcontains $contact.ToLower()) {
        Clear-Host
        $contact = Read-Host "Do you want to have a Contact segment (y/n)?"
    }

    if ("y", "yes" -contains $contact.ToLower()) {
        $userName = Read-Host -Prompt "Name (first and last)?"
        $email = Read-Host -Prompt "What is your email?"
        addToBody("`n# Contact")
        addToBody("Email $userName at $email")
        addToToc("Contact")
    }

    Clear-Host

    $license = Read-Host "Do you want to include a license for this project (y/n)?"

    while ("y", "n", "yes", "no" -notcontains $license.ToLower()) {
        Clear-Host
        $contact = Read-Host "Do you want to include a license for this project (y/n)?"
    }

    if ("y", "yes" -contains $license.ToLower()) {
        $kind = Get-MenuSelection -MenuPrompt "Select License" -t $Test -hashValue $hashValue
        addToBody("`n# License")
        addToBody("[$kind](LICENSE.txt)")
        addToToc("License")
    }

    if ($xtoc) {
        $Script:mdToc = $null
    }

    $newOutput = @(
        $mdHeader
        $Script:mdToc
        $Script:mdBody
    )

    if (test-path $ReadmeFileName){
        $fileExistsResponse = Get-SaveMenuSelection -MenuPrompt "$ReadmeFileName already exists" -filePath $ReadmeFileName
        switch ($fileExistsResponse) 
        {
            0 {
                $newOutput | out-file -FilePath $ReadmeFileName
                $finalMessage = "$ReadmeFileName template compete!"
                break
            }
            1 {
                $baseName = (Split-Path -Path $ReadmeFileName -Leaf).Split(".")[0]
                $extention = (Split-Path -Path $ReadmeFileName -Leaf).Split(".")[1]
                $ReadmeFileName = "$($baseName)_$hashValue.$extention"
                $newOutput | out-file -FilePath $ReadmeFileName
                $finalMessage = "$ReadmeFileName template compete!"
                break
            }
            2 {
                $finalMessage = "Template discarded"
                break
            }
            default {
                $finalMessage = "Some error occured while selecting an option.`nExiting and discarding unsaved template"
            }
        }
    } else {
        $newOutput | out-file -FilePath $ReadmeFileName
    }
    write-output "$finalMessage"
}
