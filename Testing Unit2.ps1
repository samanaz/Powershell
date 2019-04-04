Import-Module "C:\Users\saman.a\OneDrive - Retail Insight Ltd\Azure Services\Azure Full Services Deployment\Infrastructure-Naming.ps1"
Import-Module "C:\Users\saman.a\OneDrive - Retail Insight Ltd\Azure Services\Azure Full Services Deployment\Database.ps1"
Import-Module "C:\Users\saman.a\OneDrive - Retail Insight Ltd\Azure Services\Azure Full Services Deployment\Infrastructure-Deployment.ps1"
$RG_MGM=New-RIAzResourceGroup -Region $Region -System $System -ResourceType "mgm" -Environment $Environment
$RG_DB=New-RIAzResourceGroup -Region $Region -System $System -ResourceType "db" -Environment $Environment
$RG_Web=New-RIAzResourceGroup -Region $Region -System $System -ResourceType "web" -Environment $Environment
$KeyVault=New-RIAzKeyVault -Region $Region -System $System -Environment $Environment -ResourceGroupName $RG_MGM.ResourceGroupName -SKU Standard
New-RIAzSQLServerCredential -UserName "Saman" -UserNameSecretName "SQLServerRootAccount" -Password "P@ssw0rd" -PasswordSecretName "SQLServerRootPassword" -KeyVaultName $KeyVault.VaultName
$SQL_Server=New-RIAzSqlServer -ResourceGroup $RG_DB.ResourceGroupName -Region $Region -KeyVaultName $KeyVault.VaultName -System $System -Environment $Environment -UserNameSecretName "SQLServerRootAccount" -PasswordSecretName "SQLServerRootPassword"
$SQL_DB= New-RIAzSqlAuthDatabase -ServerName $SQL_Server.ServerName -ResourceGroupName $RG_DB.ResourceGroupName -Size Medium -Environment $Environment -System $System
$Storage_Account=New-RIAzStorageAccount -ResourceGroupName $RG_MGM.ResourceGroupName -Region $Region -System $System -SkuName Standard_LRS -Environment $Environment -AccessTier Cool
$AutomationAccount=New-RIAzAutomationAccount -ResourceGroupName $RG_MGM.ResourceGroupName -Region $Region -System $System -Environment $Environment
$ServiceBusNamespace = New-RIAzServiceBusNamespace -ResourceGroupName $RG_MGM.ResourceGroupName -Region $Region -System $System -Environment $Environment
$AppServicePlan=New-RIAzAppServicePlan -ResourceGroupName $RG_Web.ResourceGroupName -Region $Region -System $System -Environment $Environment -Tier "F1" -WorkerSize "Small" -PerSiteScaling $true
$APIManagement=New-RIAzApiManagement -ResourceGroupName $RG_MGM.ResourceGroupName -Region $Region -System $System -Environment $Environment -Organization "test" -AdminEmail "saman.a@ri-team.com" -Sku "Basic"