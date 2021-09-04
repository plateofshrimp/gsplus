#!/usr/bin/env bash
#
# RetroPie: GSplus launch wrapper.
#
# Interprets the input file and invokes GSplus based on that.
# Builds a config.txt on the fly, or copies one.
#
# TODO also use file magic to type the input;
# so often the file's extension is inaccurate.

exe=/opt/retropie/emulators/gsplus/bin/GSplus
configdir=/opt/retropie/configs/apple2
config=/tmp/config.txt
slot=7
rom="$1"
romdir=$(dirname "$rom")
echo rom=$rom romdir=$romdir

function run_with_config {
    echo rom=$rom cwd=$cwd
    
    # Do this copy so the original is not overwritten.
    cp "$rom" $config
    
    # Disk paths can be relative, let those work.
    pushd "$romdir"
    $exe -config $config
    popd
}

function run_with_template {
    echo rom=$rom cwd=$cwd
    
    # Build a config from the boot templates.
    template=/opt/retropie/configs/apple2/template-slot$slot
    sed -e "s|%ROM%|$rom|" $template > $config

    pushd "$romdir"
    $exe -config $config
    popd
}

ext=$(echo "$(basename "$rom")" | sed -E 's/^[^\.]+//')
case $ext in
.gsp)
    # A GSplus config.txt.
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

unset run_with_config
unset run_with_template
unset rom
unset config
unset configdir
unset slot
unset exe
