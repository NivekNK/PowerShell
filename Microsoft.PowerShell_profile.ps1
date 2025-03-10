#region DEFINES: Delete if config is not required or needed.
$TheLinuxWay = $true
#endregion

#region VARIABLES: Utility variables, don't delete.
$ENV:PYTHONIOENCODING = "utf-8"
$CurrentUserPath = [Environment]::GetFolderPath('UserProfile')
$ProfilePath = Split-Path $PROFILE -Parent
#endregion

#region PLUGINS
. "$ProfilePath\plugins\Set-Shortcut.ps1"
. "$ProfilePath\plugins\Trash-Item.ps1"

#Invoke-Expression "$(thefuck --alias)"
Invoke-Expression (& {
    $hook = if ($PSVersionTable.PSVersion.Major -lt 6) { 'prompt' } else { 'pwd' }
    (zoxide init --hook $hook powershell | Out-String)
})

#endregion

& ([ScriptBlock]::Create((oh-my-posh init pwsh --config "$ProfilePath\plugins\oh-my-posh\.poshthemes\nk.omp.json" --print) -join "`n"))

# Clear-Host