function checkEntry([string]$entry) {
    if ($entry -ne [string]::empty) {
        return $true
    }
    else {
        return $false
    }
}

function addToBody([string]$appendedString) {
    $Script:mdBody += "$appendedString"
}

function addToToc([string]$appendedString) {
    $Script:mdToc += "- [$appendedString](#$(CleanAnchor $appendedString))"
}

function cleanAnchor ([string]$anchor) {
    $anchor.ToLower() -replace ' ', '-'
}