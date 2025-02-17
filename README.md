# DownloadStorageAccountContent
Smalll powershell script to allow the users to use the Azure CLI to download the content from an Azure storage container

# Useage

Use windows powershell

Run the following command

`az login`

This will allow you to set the correct subscription.

Run `Connect-AzAccount`

This will actually perform the login and allow you access to restrcited resources

Run the function passing in the correct values

`./DownloadStorageAccountContent.ps1 -StorageAccountName "<Storage Account Name>" -ResourceGroupName "<Resource Group Name>" -ContainerName "<Container Name>" -DestinationFolder "<Destination folder>"`