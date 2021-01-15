$url = $args[0]

if ($url -eq $null)
 {
    $url = Read-Host -Prompt "Enter url"
 }

youtube-dl --extract-audio --audio-format wav --audio-quality 0 -i --output "%(title)s.%(ext)s" $url