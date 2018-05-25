#!/bin/sh

source /etc/preinit
script_init

WorkingDir=$(pwd)
GameName=$(echo $WorkingDir | awk -F/ '{print $NF}')
ok=0

if [ -f "/usr/share/games/$GameName/$GameName.desktop" ]; then
	OUTRUNTrueDir=$(grep /usr/share/games/$GameName/$GameName.desktop -e 'Exec=' | awk '{print $2}' | sed 's/\([/\t]\+[^/\t]*\)\{1\}$//')
	OUTRUNPortableCore="$OUTRUNTrueDir/etc/libretro/core/cannonball"
	OUTRUNPortableFiles="$OUTRUNTrueDir/OUTRUN_files"
	ok=1
fi

if [ ! -f "$OUTRUNPortableFiles/epr-10381a.132" ]; then
	ok=0
fi

if [ "$ok" == 1 ]; then
   decodepng "$OUTRUNTrueDir/Hakchi_OUTRUN_assets/outrunsplash-min.png" > /dev/fb0;
   [ -f "$rootfs/share/retroarch/assets/RAloading-min.png" ] && mount_bind "$OUTRUNTrueDir/Hakchi_OUTRUN_assets/outrunsplash-min.png" "$rootfs/share/retroarch/assets/RAloading-min.png"
   exec retroarch-clover "../../..$OUTRUNPortableCore" "$OUTRUNPortableFiles/outrun.game"
else
	decodepng "$OUTRUNTrueDir/Hakchi_OUTRUN_assets/outrunerror_files-min.png" > /dev/fb0;
	sleep 5
fi
