#region DEFINES: Delete if config is not required or needed.
$TheLinuxWay = ""
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
#endregion

# Import the Chocolatey Profile that contains the necessary code to enable
# tab-completions to function for `choco`.
# Be aware that if you are missing these lines from your profile, tab completion
# for `choco` will not function.
# See https://ch0.co/tab-completion for details.
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}

& ([ScriptBlock]::Create((oh-my-posh init pwsh --config "$ProfilePath\plugins\oh-my-posh\.poshthemes\nk.omp.json" --print) -join "`n"))

Clear-Host
