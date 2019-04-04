Import-Module "C:\Users\saman.a\OneDrive - Retail Insight Ltd\Azure Services\Azure Full Services Deployment\Infrastructure-Naming.ps1"
# Please Work on
Function Get-RIAzSqlDatabaseEdition {
    [cmdletbinding()]
    param ([parameter(Mandatory)]
        [string]
        [ValidateSet('Small','Medium','Large')]
        $Size,
        [string]
        [ValidateSet('Prod','Dev','Test')]
        $Environment
    )
    # some logic in here

    if($Size -eq "Small" -and $Environment -eq "Test") 
    {$Edition=Write-Output "Basic"}
    elseif($Size -eq "Medium" -and $Environment -eq "Dev")
    {$Edition=Write-Output "Standard"}
    $Edition
}


Function Get-RIAzSqlDatabaseDTU {
    [cmdletbinding()]
    param ([parameter(Mandatory)]
        [string]
        [ValidateSet('Small','Medium','Large')]
        $Size,
        [string]
        [ValidateSet('Prod','Dev','Test')]
        $Environment,
        [string]
        [ValidateSet('auth','master','order','planning')]
        $DatabaseType
    )
    # some logic in here

    if($Size -eq "Medium" -and $Environment -eq "Dev" -and $DatabaseType -eq "auth") 
    {$DTU=Write-Output "S0"}
    elseif($Size -eq "Medium" -and $Environment -eq "Prod" -and $DatabaseType -eq "master")
    {$DTU=Write-Output "P1"}
    $DTU
}



 

Function New-RIAzSqlServer {
    [cmdletbinding()]
    param ([parameter(Mandatory)]
        
        [string]
        $ResourceGroup,
        [string]
        $Region,
        [string]
        $KeyVaultName,
        [string]
        $System,
        [string]
        $Environment,
        [string]
        $UserNameSecretName,
        [string]
        $PasswordSecretName
        
    )
    # some logic in here
    $Location=Get-RIAzLocation -Region $Region
    $SqlServerName=Get-RIAzSqlServerName -Region $Region -System $System -Environment $Environment
    $Credential=Get-RIAzDatabaseCredential -KeyVaultName $KeyVaultName -UserNameSecretName $UserNameSecretName -PasswordSecretName $PasswordSecretName
    New-AzSqlServer -ServerName $SqlServerName -ResourceGroupName $ResourceGroup -SqlAdministratorCredentials $Credential -Location $Location
    
}

Function New-RIAzSqlAuthDatabase {
    [cmdletbinding()]
    param ([parameter(Mandatory)]
        
        [string]
        $ServerName,
        [string]
        $ResourceGroupName,
        [string]
        [ValidateSet('Small','Medium','Large')]
        $Size,
        [string]
        [ValidateSet('Prod','Dev','Test')]
        $Environment,
        [string]
        $System
    )
    # some logic in here
    $Edition = Get-RIAzSqlDatabaseEdition -Size $Size -Environment $Environment
    $Dtu = Get-RIAzSqlDatabaseDtu  -Size $Size -Environment $Environment -DatabaseType "auth"
    $DBName=Get-RIAzSqlDatabaseName -System $System -FunctionName "auth" -Environment $Environment
    New-AzSqlDatabase -DatabaseName $DBName -ServerName $ServerName -ResourceGroupName $ResourceGroupName -Edition $Edition -RequestedServiceObjectiveName $DTU 
}


