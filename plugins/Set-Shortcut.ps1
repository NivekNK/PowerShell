function Set-Shortcut {
    param (
        [Parameter(Mandatory=$true, HelpMessage="File to be linked.")]
        [string]$Source,

        [Parameter(Mandatory=$false, HelpMessage="Parameters used by the linked file.")]
        [string]$ArgumentList,

        [Parameter(Mandatory=$true, HelpMessage="Path to the linked file.")]
        [string]$Destination
    )
    Begin {
        $WshShell = New-Object -comObject WScript.Shell
    }
    Process {
        $Shortcut = $WshShell.CreateShortcut($Destination)
        $Shortcut.TargetPath = $Source
        $Shortcut.Arguments = $ArgumentList
    }
    End {
        $Shortcut.Save()
    }
}

if (-not (Get-Alias ln -ErrorAction SilentlyContinue) -and ($TheLinuxWay -eq $true)) {
    New-Alias -Name ln -Value Set-Shortcut
}
