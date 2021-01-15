$url = $args[0]

if ($url -eq $null)
 {
    $url = Read-Host -Prompt "Enter url"
 }

youtube-dl -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/bestvideo+bestaudio' -i --merge-output-format mp4 --output "%(title)s.%(ext)s" $url