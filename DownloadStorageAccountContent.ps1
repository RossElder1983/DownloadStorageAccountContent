param (
    [Parameter(Mandatory=$true)][string]$StorageAccountName,
    [Parameter(Mandatory=$true)][string]$ResourceGroupName,
    [Parameter(Mandatory=$true)][string]$ContainerName, 
    [Parameter(Mandatory=$true)][string]$DestinationFolder
)

$StorageAccount = Get-AzStorageAccount -ResourceGroupName $ResourceGroupName -Name $StorageAccountName
$Context = $StorageAccount.Context
 
if(! (test-path -PathType container $DestinationFolder))
{
    Write-Host "Creating a new directory at: $DestinationFolder"
    New-Item -ItemType Directory -Path $DestinationFolder
}
 
# Get all the blobs in the container
$Blobs = Get-AzStorageBlob -Container $ContainerName -Context $Context 
 
# Download each blob to the specified local directory
foreach ($Blob in $Blobs) {
    $BlobName = $Blob.Name

    $OutputFilePath = Join-Path -Path $DestinationFolder -ChildPath $BlobName

    #Get the folder path from the full path
    $OutputFileFolder = Split-Path $OutputFilePath

    #Create that directory if it doesnt already exist
    if(! (test-path -PathType container $OutputFileFolder))
    {
        Write-Host "Creating new directory: $OutputFileFolder"
        New-Item -ItemType Directory -Path $OutputFileFolder
    }    
    
    Get-AzStorageBlobContent -Blob $BlobName -Container $ContainerName -Destination $OutputFilePath -Context $Context
    Write-Host "Downloaded file $BlobName to $OutputFilePath"
}