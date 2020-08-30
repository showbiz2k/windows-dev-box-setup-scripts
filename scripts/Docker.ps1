Enable-WindowsOptionalFeature -Online -FeatureName containers -All
RefreshEnv
choco  --cacheLocation="c:\temp" install -y docker-desktop
choco  --cacheLocation="c:\temp" install -y vscode-docker
