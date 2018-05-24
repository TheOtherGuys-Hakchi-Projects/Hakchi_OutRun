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

if [ "$ok" == 1 ]; then
	decodepng "$OUTRUNTrueDir/Hakchi_OUTRUN_assets/doom1splash-min.png" > /dev/fb0;
	[ ! -L "$OUTRUNTrueDir/etc/libretro/roms" ] && ln -sf "$OUTRUNPortableFiles" "$OUTRUNTrueDir/etc/libretro/roms"
	exec retroarch-clover "../../..$OUTRUNPortableCore" #"$OUTRUNPortableFiles/<ROM>" I guess this is right? 
else
	decodepng "$OUTRUNTrueDir/Hakchi_OUTRUN_assets/doomerror_files-min.png" > /dev/fb0;
	sleep 5
fi
