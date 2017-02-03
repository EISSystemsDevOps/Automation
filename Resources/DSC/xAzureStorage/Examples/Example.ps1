Configuration Example
{
    Import-DscResource -ModuleName xAzureStorage
    Node localhost
    {

        xAzureBlobFiles ExampleFiles {
        Path                    = "C:\temp\downloads"
        StorageAccountName      = "sairmcuploads01"
        StorageAccountContainer = "root"
        StorageAccountKey       = "9qDF6aQBp0zGAuq/mYIHuzGzpLLxUTeQ8dAV95kh4f1yziwkmTLKUIxsvN3/vky95SanWiokNgYTXIyS8tOtPQ=="
        }

    }
}

Example

Start-DscConfiguration -Path  c:\windows\system32\example -force