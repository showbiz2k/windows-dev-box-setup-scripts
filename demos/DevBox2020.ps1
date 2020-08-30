Disable-UAC
$ConfirmPreference = "None" #ensure installing powershell modules don't prompt on needed dependencies

# Get the base URI path from the ScriptToCall value
$bstrappackage = "-bootstrapPackage"
$helperUri = $Boxstarter['ScriptToCall']
$strpos = $helperUri.IndexOf($bstrappackage)
$helperUri = $helperUri.Substring($strpos + $bstrappackage.Length)
$helperUri = $helperUri.TrimStart("'", " ")
$helperUri = $helperUri.TrimEnd("'", " ")
$strpos = $helperUri.LastIndexOf("/demos/")
$helperUri = $helperUri.Substring(0, $strpos)
$helperUri += "/scripts"
write-host "helper script base URI is $helperUri"

function executeScript {
    Param ([string]$script)
    write-host "executing $helperUri/$script ..."
	iex ((new-object net.webclient).DownloadString("$helperUri/$script"))
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
choco install -y wsl-alpine

executeScript "Docker.ps1";

# #--- Tools ---
# choco --cacheLocation="c:\temp" install -y powershell-core

# choco --cacheLocation="c:\temp" install -y vscode

# choco --cacheLocation="c:\temp" install -y azure-cli
# Install-Module -Force Az
# choco --cacheLocation="c:\temp" install -y microsoftazurestorageexplorer
# choco  --cacheLocation="c:\temp"install -y azure-data-studio

# code --install-extension msjsdiag.debugger-for-chrome
# code --install-extension msjsdiag.debugger-for-edge

# choco  --cacheLocation="c:\temp" install -y nodejs-lts

# # choco install -y visualstudio2019community
# # choco install -y visualstudio2019-workload-azure
# # choco install -y visualstudio2019-workload-azurebuildtools
# # choco install -y visualstudio2019-workload-data
# # choco install -y visualstudio2019-workload-databuildtools
# # choco install -y visualstudio2019-workload-datascience
# # choco install -y visualstudio2019-workload-netweb
# # choco install -y visualstudio2019-workload-webbuildtools

# choco  --cacheLocation="c:\temp" install -y microsoftwebdriver

# choco  --cacheLocation="c:\temp" install -y powertoys


Enable-UAC
Enable-MicrosoftUpdate
Install-WindowsUpdate -acceptEula