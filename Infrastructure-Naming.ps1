#Infrastructure Naming
Function Get-RIAzLocation{
[cmdletbinding()]
   param(
        [Parameter(Mandatory)]
        [string]
        $Region
                
        )
        $RegionAbbreviations = switch($Region)
           {
             "aea"{$RG_AUstraliaEast="australiaeast"}
           }

           If ($RegionAbbreviations="aea"){$Location="AustraliaEast" }
           $location
}


Function Get-RIAzResourceGroupName {
   [cmdletbinding()]
   param(
        [Parameter(Mandatory)]
        [string]
        $Region,
        [string]
        $System,
        [string]
        $ResourceType,
        [string]
        $Environment
        
        )

        "$Region-$System-$ResourceType-$Environment-RG"
}

Function Get-RIAzStorageAccountName {
   [cmdletbinding()]
   param(
        [Parameter(Mandatory)]
        [string]
        $Region,
        [string]
        $System,
        [string]
        $Environment
        
        
        
        
        )
        $StorageType="storageaccount"
        "$Region$System$Environment$StorageType"
}

Function Get-RIAzKeyVaultName {
   [cmdletbinding()]
   param(
        [Parameter(Mandatory)]
        [string]
        $Region,
        [string]
        $System,
        [string]
        $Environment
     
        
        
        
        )

        "$Region-$System-$Environment-keyvault"
}

Function Get-RIAzAutomationAccountName {
   [cmdletbinding()]
   param(
        [Parameter(Mandatory)]
        [string]
        $Region,
        [string]
        $System,
        [string]
        $Environment
     
        
        
        
        )

        "$Region-$System-$Environment-automation"
}


Function Get-RIAzServiceBusNamespaceName {
   [cmdletbinding()]
   param(
        [Parameter(Mandatory)]
        [string]
        $Region,
        [string]
        $System,
        [string]
        $Environment
     
        
        
        
        )

        "$Region$System$Environment" #sb has to be added
}

Function Get-RIAzApiManagementName {
   [cmdletbinding()]
   param(
        [Parameter(Mandatory)]
        [string]
        $Region,
        [string]
        $System,
        [string]
        $Environment
     
        
        
        
        )

        "$Region-$System-api-$Environment" 
}

Function Get-RIAzAppServicePlanName {
   [cmdletbinding()]
   param(
        [Parameter(Mandatory)]
        [string]
        $Region,
        [string]
        $System,
        [string]
        $Environment
     
        
        
        
        )

        "$Region-$System-$Environment-asp" 
}

Function Get-RIAzSqlServerName {
   [cmdletbinding()]
   param(
        [Parameter(Mandatory)]
        [string]
        $Region,
        [string]
        $System,
        [string]
        $Environment
     
        
        
        
        )

        "$Region-$System-$Environment-sqlserver" 
}

Function Get-RIAzSqlDatabaseName {
   [cmdletbinding()]
   param(
        [Parameter(Mandatory)]
        [string]
        $System,
        [string]
        $FunctionName,
        [string]
        $Environment
     
        
        
        
        )

        "$System-$FunctionName-$Environment" 
}


#function Get-SkuFor(OtherStuff)

