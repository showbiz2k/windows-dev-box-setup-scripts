Disable-UAC
$ConfirmPreference = "None" #ensure installing powershell modules don't prompt on needed dependencies

# Get the base URI path from the ScriptToCall value

$helperScriptLocation = Get-PackageRoot($MyInvocation)
write-host "helper script base URI is $helperScriptLocation"

function executeScript {
    Param ([string]$script)
    write-host "executing $helperScriptLocation\scripts\$script ..."
    & "$helperScriptLocation\scripts\$script"
}

#--- Setting up Windows ---
executeScript "FileExplorerSettings.ps1";
executeScript "SystemConfiguration.ps1";
executeScript "RemoveDefaultApps.ps1";
executeScript "CommonDevTools.ps1";
executeScript "Browsers.ps1";

executeScript "HyperV.ps1";
RefreshEnv
executeScript "WSL.ps1";
RefreshEnv
executeScript "Docker.ps1";

# #--- Tools ---
choco install -y powershell-core

choco install -y vscode

choco install -y azure-cli
Install-Module -Force Az
c
hoco install -y microsoftazurestorageexplorer
choco install -y azure-data-studio

code --install-extension msjsdiag.debugger-for-chrome
code --install-extension msjsdiag.debugger-for-edge

choco install -y nodejs-lts

choco install -y visualstudio2019community
choco install -y visualstudio2019-workload-azure
choco install -y visualstudio2019-workload-azurebuildtools
choco install -y visualstudio2019-workload-data
choco install -y visualstudio2019-workload-databuildtools
choco install -y visualstudio2019-workload-datascience
choco install -y visualstudio2019-workload-netweb
choco install -y visualstudio2019-workload-webbuildtools

choco install -y microsoftwebdriver

choco install -y powertoys


Enable-UAC
Enable-MicrosoftUpdate
Install-WindowsUpdate -acceptEula