Function Write-Readme{
    <#
        .SYNOPSIS
        Create a README.md file quickly
        .DESCRIPTION
        Answer the prompts to generate a README.md file
        .OUTPUTS
        a README.md file in the current directory
        .EXAMPLE
        Write-Readme
        Then answer the prompts as they come up
        .LINK
        https://www.github.com/rennerom/GitTemplates
    #>
    
    $mdTemp = @()
    $mdToc = @()

    Clear-Host

    # Project Name and Overview
    $ProjName = Read-Host -Prompt "Enter Project Title (or skip for default)"
    
    Clear-Host

    if (checkEntry($ProjName)) {
        $ProjOverview = Read-Host -Prompt "Enter a quick overview of the project"
        addToTemplate("# $ProjName")
        addToTemplate("`n$ProjOverview`n")
    } else {
        addToTemplate("# Project Name")
        addToTemplate("`nEnter a brief description here`n")
    }
    
    Clear-Host

    $requirements = Read-Host -Prompt "Brief description of any external requirements to start this project (skip if none)"
    if (checkEntry($requirements)) {
        addToTemplate("`n# Requirements")
        addToTemplate("`n$requirements`n")
    }

    Clear-Host

    $start = Read-Host -Prompt "Brief description of 'How To Start' this project (skip if none)"
    if (checkEntry($start)) {
        addToTemplate("`n# How to Start")
        addToTemplate("`n$start`n")
    }

    Clear-Host

    $use = Read-Host -Prompt "Brief description of this projects basic usage (or skip for default)"
    if (checkEntry($use)) {
        addToTemplate("`n# Usage")
        addToTemplate("`n$use`n")
    } else {
        addToTemplate("`n# Usage")
        addToTemplate("`nBrief description of usage goes here.`n")
    }

    Clear-Host

    $contact = Read-Host "Provide Contact (y/n)"

    while("y","n","yes","no" -notcontains $contact.ToLower())
    {
        Clear-Host
	    $contact = Read-Host "Provide Contact (y/n)"
    }

    if("y","yes" -contains $contact.ToLower()){
        $userName = Read-Host -Prompt "Name (first and last)?"
        $email = Read-Host  Prompt "What is your email?"
            addToTemplate("`n# Contact")
            addToTemplate("`nemail $userName at $email`n")
    }
    
    $license = Read-Host "Do you want to include a license for this project (y/n)?"

    while("y","n","yes","no" -notcontains $license.ToLower())
    {
        Clear-Host
	    $contact = Read-Host "Do you want to include a license for this project (y/n)?"
    }

    if("y","yes" -contains $contact.ToLower()){
        $userName = Read-Host -Prompt "Name (first and last)?"
        $email = Read-Host  Prompt "What is your email?"
            addToTemplate("`n# Contact")
            addToTemplate("`nemail $userName at $email`n")
    }

    Write-Output $Script:mdTemp
    $Script:mdTemp | Out-File -FilePath ./README2.md

}