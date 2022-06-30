$product = Get-WmiObject win32_product | where{$_.name -eq "name of program"}

Write-Host $product.IdentifyingNumber
