$palname = $args[1]+'-palette.png'

if(![System.IO.File]::Exists($palname))
{
    ffmpeg -i $args[0] -vf fps=60,scale=480:-1:flags=lanczos,palettegen $palname
}

ffmpeg -i $args[0] -i $palname -filter_complex "fps=30,scale=400:-1:flags=lanczos[x];[x][1:v]paletteuse" $args[1]