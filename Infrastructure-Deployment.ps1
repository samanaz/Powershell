Function New-RIAzResourceGroup {
    [cmdletbinding()]
    param ([parameter(Mandatory)]
        [string]
        $Region,
        [string]
        $System,
        [string]
        $ResourceType,
        [string]
        $Environment
    )
    

     #$RegionAbbreviations = @{"australiaeast"="aea";"australiasoutheast"="ase"}
     $Array=@()
     $RG=Get-RIAzResourceGroupName -Region $Region -System $System -ResourceType $ResourceType -Environment $Environment
     $Location=Get-RIAzLocation -Region $Region
     New-AzResourceGroup -Name $RG -Location $Location
    

}

Function New-RIAzKeyVault {
    [cmdletbinding()]
    param ([parameter(Mandatory)]
        [string]
        $Region,
        [string]
        $System,
        [string]
        $Environment,
        [string]
        $ResourceGroupName,
        [string]
        $SKU
    )
    
    $KVName= Get-RIAzKeyVaultName -Region $Region -System $System -Environment $Environment
    $Location=Get-RIAzLocation -Region $Region
    New-AzKeyVault -Name $KVName -ResourceGroupName $ResourceGroupName -Location $Location -Sku $SKU -EnabledForDeployment

}


 Function New-RIAzSQLServerCredential{
 [cmdletbinding()]
    param ([parameter(Mandatory)]
    [string]
    $UserName,
    [string]
    $UserNameSecretName,
    [string]
    $Password,
    [string]
    $PasswordSecretName,
    [string]
    $KeyVaultName
    
    )
 $Secret=ConvertTo-SecureString -String $UserName -AsPlainText -Force
 Set-AzKeyVaultSecret -VaultName $KeyVaultName -Name $UserNameSecretName -SecretValue $Secret -ContentType SQL_Root_Account
 $Secret=ConvertTo-SecureString -String $Password -AsPlainText -Force
 Set-AzKeyVaultSecret -VaultName $KeyVaultName -Name $PasswordSecretName -SecretValue $Secret -ContentType SQL_Password
 }

 
 Function Get-RIAzDatabaseCredential{
 [cmdletbinding()]
    param ([parameter(Mandatory)]
    [string]
    $KeyVaultName,
    [string]
    $UserNameSecretName,
    [string]
    $PasswordSecretName
    )
$SQL_Admin_Account=Get-AzKeyVaultSecret -VaultName $KeyVaultName -Name $UserNameSecretName
$SQL_Admin_Account = Write-Output $SQL_Admin_Account.SecretValueText
$SQL_Admin_Password=Get-AzKeyVaultSecret -VaultName $KeyVaultName -Name $PasswordSecretName
$SQL_Admin_Password = Write-Output $SQL_Admin_Password.SecretValueText
$SQL_Admin_Password= ConvertTo-SecureString -String $SQL_Admin_Password -AsPlainText -Force
$Credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $SQL_Admin_Account, $SQL_Admin_Password
Return $Credential
 }

 Function New-RIAzStorageAccount {
    [cmdletbinding()]
    param ([parameter(Mandatory)]
        [string]
        $ResourceGroupName,
        [string]
        $Region,
        [string]
        $System,
        [string]
        $SkuName,
        [string]
        $Environment,
        [string]
        [ValidateSet('Cool','Hot')]
        $AccessTier
    )
    

     
     $StorageAccountName=Get-RIAzStorageAccountName -Region $Region -System $System -Environment $Environment
     $Location=Get-RIAzLocation -Region $Region
     New-AzStorageAccount -Name $StorageAccountName -ResourceGroupName $ResourceGroupName -Location $Location -SkuName $SkuName -Kind StorageV2 -AccessTier $AccessTier
    

}


Function New-RIAzAutomationAccount {
    [cmdletbinding()]
    param ([parameter(Mandatory)]
        [string]
        $ResourceGroupName,
        [string]
        $Region,
        [string]
        $System,
        [string]
        $Environment
        
    )
    

     
     $AutomationAccountName=Get-RIAzAutomationAccountName -Region $Region -System $System -Environment $Environment
     $Location=Get-RIAzLocation -Region $Region
     New-AzAutomationAccount -Name $AutomationAccountName -ResourceGroupName $ResourceGroupName -Location $Location
    

}
Function New-RIAzServiceBusNamespace {
    [cmdletbinding()]
    param ([parameter(Mandatory)]
        [string]
        $ResourceGroupName,
        [string]
        $Region,
        [string]
        $System,
        [string]
        $Environment
        
    )
    

     #Sku Function should be created
     $AutomationAccountName=Get-RIAzServiceBusNamespaceName -Region $Region -System $System -Environment $Environment
     $Location=Get-RIAzLocation -Region $Region
     New-AzServiceBusNamespace -Name $AutomationAccountName -ResourceGroupName $ResourceGroupName -Location $Location 
    

}
Function New-RIAzAppServicePlan {
    [cmdletbinding()]
    param ([parameter(Mandatory)]
        [string]
        $ResourceGroupName,
        [string]
        $Region,
        [string]
        $System,
        [string]
        $Environment,
        [string]
        $Tier,
        [string]
        $WorkerSize,
        [bool]
        $PerSiteScaling
        
    )
    

     #Tier Function should be created
     #WorkerSize Function should be created
     $AppServicePlanName=Get-RIAzServiceBusNamespaceName -Region $Region -System $System -Environment $Environment
     $Location=Get-RIAzLocation -Region $Region
     New-AzAppServicePlan -Name $AppServicePlanName -ResourceGroupName $ResourceGroupName -Location $Location -Tier $Tier -WorkerSize $WorkerSize -PerSiteScaling $PerSiteScaling
    

}

Function New-RIAzApiManagement {
    [cmdletbinding()]
    param ([parameter(Mandatory)]
        [string]
        $ResourceGroupName,
        [string]
        $Region,
        [string]
        $System,
        [string]
        $Environment,
        [string]
        $Organization,
        [string]
        $AdminEmail,
        [string]
        $Sku
        
    )
    

     #SKU Function should be created
     #Other information Function should be created
     $APIManagmentName=Get-RIAzServiceBusNamespaceName -Region $Region -System $System -Environment $Environment
     $Location=Get-RIAzLocation -Region $Region
     New-AzApiManagement -Name $APIManagmentName -ResourceGroupName $ResourceGroupName -Location $Location -Organization $Organization -AdminEmail $AdminEmail -Sku $Sku #-Capacity ?
    

}