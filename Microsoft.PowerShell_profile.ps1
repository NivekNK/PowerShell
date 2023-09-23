#region DEFINES: Delete if config is not required or needed.
$TheLinuxWay = ""
$ChangeAppsFolder = ""
#endregion

#region VARIABLES: Utility variables, don't delete.
$ENV:PYTHONIOENCODING = "utf-8"
$CurrentUserPath = [Environment]::GetFolderPath('UserProfile') 
$ProfilePath = Split-Path $PROFILE -Parent
#endregion

#region WRAPPER: Wrapper function to import plugins.
function Import-Plugin {
    param ([string]$PluginName)
    Begin {
        $PluginsPath = Join-Path $ProfilePath "plugins"
    }
    Process {
        . "$PluginsPath\$PluginName"
    }
}
#endregion

#region PLUGINS
Import-Plugin "Set-Shortcut.ps1"

Invoke-Expression "$(thefuck --alias)"
Invoke-Expression (& {
    $hook = if ($PSVersionTable.PSVersion.Major -lt 6) { 'prompt' } else { 'pwd' }
    (zoxide init --hook $hook powershell | Out-String)
})

if (Test-Path variable:\ChangeAppsFolder) {
    $ENV:SCOOP = "$CurrentUserPath\Apps\Scoop"
}

$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
    Import-Module "$ChocolateyProfile"
}
#endregion

& ([ScriptBlock]::Create((oh-my-posh init pwsh --config "$ProfilePath\plugins\oh-my-posh\.poshthemes\nk.omp.json" --print) -join "`n"))

Clear-Host
