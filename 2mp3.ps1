$file = $args[0]

if ($file -eq $null)
{
   $file = Read-Host -Prompt "Enter filename"
}

$filenew = $file.Substring(0,$file.Length-4)

ffmpeg -i `"$file`" -vn -ar 44100 -ac 2 -ab 320k -f mp3 `"$filenew.mp3`"