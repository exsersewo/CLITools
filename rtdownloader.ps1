$url = $args[0]
$file = $args[1]

if($url -eq $null)
{
    $url = Read-Host -Prompt "Enter url that trails with .m3u8"
}

if($file -eq $null)
{
    $file = Read-Host -Prompt "Enter destination file+extension"
}

ffmpeg -i $url -c copy -bsf:a aac_adtstoasc $file