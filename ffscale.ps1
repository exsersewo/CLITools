$file = $args[0]
$fileout = $args[1]
$scale = $args[2]

ffmpeg -i $file -filter:v scale=$scale -c:a copy -map 0 -preset veryfast -movflags +faststart $fileout