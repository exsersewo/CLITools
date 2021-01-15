$pfxLocation = $args[0]

if ($pfxLocation -eq $null) {
    $pfxLocation = Read-Host -Prompt "Enter PFX Location"
}

$password = Read-Host -AsSecureString -Prompt "Enter Password"
$password = ConvertFrom-SecureString -SecureString $password -AsPlainText

if(!$pfxLocation.EndsWith(".pfx")) {
    $pfxLocation = $pfxLocation+".pfx"
}

$pfxLocationWithoutExt = $pfxLocation.Replace(".pfx", "")

$pfxFilePath = "`"$($pfxLocation)`""

$caCrt = "`"$($pfxLocationWithoutExt)-ca.crt`""
$crt = "`"$($pfxLocationWithoutExt).crt`""
$encryptedKey = "`"$($pfxLocationWithoutExt)-encrypted.key`""
$key = "`"$($pfxLocationWithoutExt).key`""
$fullCrt = "`"$($pfxLocationWithoutExt)-full.crt`""

#ca-cert
openssl pkcs12 -in $pfxLocation -nodes -nokeys -cacerts -out $caCrt -passin pass:$password

#key file
openssl pkcs12 -in $pfxLocation -nocerts -out $encryptedKey -passin pass:$password -passout pass:$password

#key decrypt
openssl rsa -in $encryptedKey -out $key -passout pass:$password

#cert
openssl pkcs12 -in $pfxLocation -clcerts -nokeys -out $crt -passin pass:$password

$crt = "$($pfxLocationWithoutExt).crt"
$caCrt = "$($pfxLocationWithoutExt)-ca.crt"
$fullCrt = "$($pfxLocationWithoutExt)-full.crt"

#join files
Get-Content $crt, $caCrt | Set-Content $fullCrt