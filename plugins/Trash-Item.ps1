function Trash-Item {
    param (
        [Parameter(Mandatory=$true, HelpMessage="Filepath to be deleted (moved to trash can).")]
        [string]$Path
    )
    Begin {
        $WshShell = New-Object -comObject "Shell.Application"
    }
    Process {
        $Item = $WshShell.Namespace(0).ParseName($Path)
        $Item.InvokeVerb("delete")
    }
}

if (-not (Get-Alias trash -ErrorAction SilentlyContinue) -and ($TheLinuxWay -eq $true)) {
    New-Alias -Name trash -Value Trash-Item
}
