
$scriptdir = Split-Path -Parent $PSCommandPath
$InfrastructureName = "Infrastructure-Naming.ps1"
$InfrastructureDeployment="Infrastructure-Deployment.ps1"
$Database="Database.ps1"

$ModuleInfrastructureName = Join-Path $scriptdir $InfrastructureName
$ModuleInfrastructureDeployment= Join-Path $scriptdir $InfrastructureDeployment
$ModuleDatabase= Join-Path $scriptdir $Database
Write-Output $ModuleInfrastructureName
Write-Output $ModuleInfrastructureDeployment
Write-Output $ModuleDatabase


Import-Module $ModuleInfrastructureName
Import-Module $ModuleInfrastructureDeployment
Import-Module $ModuleDatabase
Get-RIAzResourceGroupName -Region "aea" -System "vmi" -ResourceType "db" -Environment "dev"
