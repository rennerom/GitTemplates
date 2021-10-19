using namespace System.Management.Automation.Host

    $Title = "Choose License"
    $Question + "What License will you use for this project?"
    
    $MIT = [ChoiceDescription]::new('&MIT', 'MIT')
    $GNU = [ChoiceDescription]::new('&GNU', 'GNU')
    $Apache = [ChoiceDescription]::new('&Apache', 'Apache')

    $options = [ChoiceDescription[]]($MIT, $GNU, $Apache)

    $result = $host.ui.PromptForChoice($Title, $Question, $options, 0)

    switch ($result) {
        0 { "Adding MIT license" }
        1 { "Adding GNU license" }
        2 { "Adding Apache license" }
    }