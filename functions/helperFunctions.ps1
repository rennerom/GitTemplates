function checkEntry() {

    Param (
        [string]$entry
        )

        if ($entry -ne [string]::empty) {
            return $true
        } else {
            return $false
        }
}

function addToTemplate() {

    Param (
        [string]$appendedString
        )

    $Script:mdTemp += $appendedString
}

function addToToc() {

    Param (
        [string]$appendedString
        )

    $Script:mdToc += $appendedString
}

function cleanAnchor ([string]$anchor) {
    $anchor.ToLower() -replace ' ','-'
}