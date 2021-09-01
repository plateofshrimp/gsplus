#!/usr/bin/env bash
#
# RetroPie: GSplus launch wrapper.
#
# Interprets the input file and invokes GSplus based on that.
# Builds config.txt on the fly if required.
#
# TODO also use file magic to type the input.

rom="$1"
ext=$(echo "$(basename "$rom")" | sed -E 's/^[^\.]+//')
exe=/opt/retropie/emulators/gsplus/bin/gsplus
slot=7
config=/tmp/config.txt

function run_with_config {
	cp "$rom" $config
	$exe -config $config
}

function run_with_template {
	template=/opt/retropie/configs/apple2/template-slot$slot
	sed -e "s|%ROM%|$rom|" $template > $config
	$exe -config $config
}

case $ext in
.2gs)
	# A contrived extension for a GSplus config.txt.
	echo "RetroPie: $ext format, a config.txt, will use it directly."
	run_with_config
	;;
.txt)
	# Assume it's a config.txt.
	echo "RetroPie: $ext format, a config.txt, will use it directly."
	run_with_config
	;;
.dsk)
	slot=6
	echo "RetroPie: $ext format, will insert into slot $slot."
	run_with_template
	;;
*)
	echo "RetroPie: $ext format, will insert into slot $slot."
	run_with_template
	;;
esac

