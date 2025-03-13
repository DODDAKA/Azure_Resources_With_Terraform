# Install IIS
Install-WindowsFeature -Name Web-Server -IncludeManagementTools

# Create a basic HTML file
$htmlContent = @"
<!DOCTYPE html>
<html>
<head>
    <title>My First Web Page</title>
</head>
<body>
    <h1>Hello, World!</h1>
    <p>This is a basic web page hosted on IIS.</p>
</body>
</html>
"@

Set-Content -Path "C:\inetpub\wwwroot\index.html" -Value $htmlContent

# Allow HTTP traffic through the firewall
New-NetFirewallRule -DisplayName "Allow HTTP" -Direction Inbound -Protocol TCP -LocalPort 80 -Action Allow