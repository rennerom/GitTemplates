function Get-MenuSelection {
    [CmdletBinding()]
    [OutputType([string])]
    param
    (
        [Parameter(Mandatory = $true)]
        [String]$MenuPrompt,
        [Alias('t')]
        [bool]$Test = $false,
        [string]$hashValue
    )
    # store initial cursor position
    $cursorPosition = $host.UI.RawUI.CursorPosition
    $pos = 0 # current item selection

    #create licenseObject
    # These could be passed in maybe?
    $licenseObject = (Invoke-RestMethod -Uri https://api.github.com/licenses)
    $licenseObject = @(($licenseObject.spdx_id), ($licenseObject.name), ($licenseObject.url)) 
    $menuItems = $licenseObject[0]
    
    #==============
    # 1. Draw menu
    #==============
    function Write-Menu {
        param (
            [int]$selectedItemIndex
        )
        # reset the cursor position
        $Host.UI.RawUI.CursorPosition = $cursorPosition
        # Padding the menu prompt to center it
        $prompt = $MenuPrompt
        $maxLineLength = ($MenuItems | Measure-Object -Property Length -Maximum).Maximum + 4
        while ($prompt.Length -lt $maxLineLength + 4) {
            $prompt = " $prompt "
        }
        Write-Host $prompt -ForegroundColor Green
        # Write the menu lines
        for ($i = 0; $i -lt $MenuItems.Count; $i++) {
            $line = "    $($MenuItems[$i])" + (" " * ($maxLineLength - $MenuItems[$i].Length))
            if ($selectedItemIndex -eq $i) {
                Write-Host $line -ForegroundColor Blue -BackgroundColor Gray
            }
            else {
                Write-Host $line
            }
        }
    }
    
    Write-Menu -selectedItemIndex $pos
    $key = $null
    while ($key -ne 13) {
        #============================
        # 2. Read the keyboard input
        #============================
        $press = $host.ui.rawui.readkey("NoEcho,IncludeKeyDown")
        $key = $press.virtualkeycode
        if ($key -eq 38) {
            $pos--
        }
        if ($key -eq 40) {
            $pos++
        }
        #handle out of bound selection cases
        if ($pos -lt 0) { $pos = 0 }
        if ($pos -eq $MenuItems.count) { $pos = $MenuItems.count - 1 }
        
        #==============
        # 1. Draw menu
        #==============
        Write-Menu -selectedItemIndex $pos
        
    }
    # This will clear the menu from the consol after you make a selection
    clear-host
    
    if ($Test) {
        $FileName = "LICENSE_test.txt"
    }
    else {
        $FileName = "LICENSE.txt"
    }

    #test if file exits
    if (Test-Path $FileName) {
        $fileExistsResponse = Get-SaveMenuSelection -MenuPrompt "$FileName already exists" -filePath $FileName
        

        switch ($fileExistsResponse) {
            0 {
                (invoke-restmethod -Uri $licenseObject[2][$pos]).body | Out-File -FilePath $FileName
                $finalMessage = @(
                    "$FileName composed for $($licenseObject[1][$pos])!"
                    "`nBe sure to edit the file if needed to reflect the copyright year and owner"
                )
                break
            }
            1 {
                $baseName = (Split-Path -Path $FileName -Leaf).Split(".")[0]
                $extention = (Split-Path -Path $FileName -Leaf).Split(".")[1]
                $FileName = "$($baseName)_$hashValue.$extention"
                (invoke-restmethod -Uri $licenseObject[2][$pos]).body | Out-File -FilePath $FileName
                $finalMessage = @(
                    "$FileName composed for $($licenseObject[1][$pos])!"
                    "`nBe sure to edit the file if needed to reflect the copyright year and owner"
                )
                break
            }
            2 {
                $finalMessage = "License document not updated"
                break
            }
            default {
                $finalMessage = "Some error occured while selecting an option.`nExiting and discarding unsaved License document"
            }
        }
    }
    else {
        (invoke-restmethod -Uri $licenseObject[2][$pos]).body | Out-File -FilePath $FileName
    }
    
    # create LICENSE.txt file
    write-host "$finalMessage"

    return $licenseObject[1][$pos]
}
