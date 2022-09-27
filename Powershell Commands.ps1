$SubscriptionId = 'a2b3b6f2-e076-4c37-b7b6-cd8ebc3580ba'
# Set the resource group name and location for your server
$resourceGroupName = "Batch07"
$location = "westus"
# Set an admin login and password for your server
$adminSqlLogin = "SqlAdmin"
$password = "JaiHindDoston#5241"
# Set server name - the logical server name has to be unique in the system
$serverName = "ltiserverbatchsevenserver"
# The sample database name
$databaseName = "LtiBatch07Db"
# The ip address range that you want to allow to access your server
$startIp = "157.35.24.51"
$endIp = "157.35.24.51"

# Set subscription 
Set-AzContext -SubscriptionId $subscriptionId 

# Create a resource group
$resourceGroup = New-AzResourceGroup -Name $resourceGroupName -Location $location

# Create a server with a system wide unique server name
$server = New-AzSqlServer -ResourceGroupName $resourceGroupName `
    -ServerName $serverName `
    -Location $location `
    -SqlAdministratorCredentials $(New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $adminSqlLogin, $(ConvertTo-SecureString -String $password -AsPlainText -Force))

# Create a server firewall rule that allows access from the specified IP range
$serverFirewallRule = New-AzSqlServerFirewallRule -ResourceGroupName $resourceGroupName `
    -ServerName $serverName `
    -FirewallRuleName "ClientIPAddress_2022-9-23_16-47-30" -StartIpAddress $startIp -EndIpAddress $endIp

# Create a blank database with an S0 performance level
$database = New-AzSqlDatabase  -ResourceGroupName $resourceGroupName `
    -ServerName $serverName `
    -DatabaseName $databaseName `
    -RequestedServiceObjectiveName "S0" `
    -SampleName "AdventureWorksLT"
