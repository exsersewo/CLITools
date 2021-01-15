$destinationHost = $args[0]

if ($destinationHost -eq $null)
{
   $destinationHost = Read-Host -Prompt "Enter Host (e.g. root@contoso.com)"
}

type $env:USERPROFILE\.ssh\id_rsa.pub | ssh $destinationHost '[ -d .ssh ] || mkdir .ssh; cat >> .ssh/authorized_keys'