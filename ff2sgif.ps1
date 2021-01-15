$palname = $args[1]+'-palette.png'

if(![System.IO.File]::Exists($palname))
{
    ffmpeg -i $args[0] -vf fps=5,scale=-1:50:flags=lanczos,palettegen $palname
}

ffmpeg -i $args[0] -i $palname -filter_complex "fps=5,scale=-1:50:flags=lanczos[x];[x][1:v]paletteuse" $args[1]