$file = $args[0]

#Audio Process
ffmpeg -i $file -vn -acodec libvorbis -ab 128k -dash 1 audio_128k.webm

#Video Process
ffmpeg -i $file -c:v libvpx-vp9 -keyint_min 150 -g 150 -tile-columns 4 -frame-parallel 1 -f webm -dash 1 -an -vf scale=640:480 -b:v 1000k -dash 1 -preset fast video_640x480_1000k.webm -an -vf scale=1280:720 -b:v 1500k -dash 1 -preset fast video_1280x720_1500k.webm

#Video Manifest
ffmpeg -f webm_dash_manifest -i video_640x480_1000k.webm -f webm_dash_manifest -i video_1280x720_1500k.webm -f webm_dash_manifest -i audio_128k.webm -c copy -map 0 -map 1 -map 2  -f webm_dash_manifest -adaptation_sets "id = 0, streams = 0, 1 id = 1, streams = 3" video_manifest.mpd