#!/bin/sh
#
# This file is part of adapta-gtk-theme
#
# Copyright (C) 2016-2018 Tista <tista.gma500@gmail.com>
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#

###############
# Print usage #
###############

# Usage: ./parse-sass.sh [ -a ]
#
# Optional arguments:
#    -a        generates CSSs for all of Gtk+ versioned

usage() {
    sed -rn '/^# Usage/,${/^#/!q;s/^# ?//;p}' "$0"
}

if [ "$1" = '-h' ] || [ "$1" = '--help' ] || [ "$1" = 'help' ]; then
    usage
    exit 1
fi

##########################
# Check Gtk+-3.0 version #
##########################

PKG_CONFIG="`command -v pkg-config`"

# evenize minor version number of gtk+-3.0
major="`$PKG_CONFIG --modversion gtk+-3.0 | cut -d. -f1`"
minor="`$PKG_CONFIG --modversion gtk+-3.0 | cut -d. -f2`"
if [ $(expr "$minor" % 2) -ne 0 ]; then
    css_minor="$(expr $minor + 1)"
else
    css_minor="$minor"
fi

if [ ! -d ./"$major"."$css_minor" ]; then
    echo version "$major"."$minor".x is not supported.
    exit 1
fi

#################
# Generate CSSs #
#################

SASSC="`command -v sassc` -M -t compact"

case "$1" in
    -a)
        if [ ! -d ../gtk-3.20 ]; then
            mkdir -p ../gtk-3.20
        fi
        $SASSC 3.20/gtk.scss ../gtk-3.20/gtk-contained.css

        if [ ! -d ../gtk-3.22 ]; then
            mkdir -p ../gtk-3.22
        fi
        $SASSC 3.22/gtk.scss ../gtk-3.22/gtk-contained.css

        if [ ! -d ../gtk-3.24 ]; then
            mkdir -p ../gtk-3.24
        fi
        $SASSC 3.24/gtk.scss ../gtk-3.24/gtk-contained.css

        if [ ! -d ../gtk-4.0 ]; then
            mkdir -p ../gtk-4.0
        fi
        $SASSC 4.0/gtk.scss ../gtk-4.0/gtk-contained.css

        if [ ! -d ../xfce-notify-4.0 ]; then
            mkdir -p ../xfce-notify-4.0
        fi
        $SASSC common/xfce-notify-4.0.scss ../xfce-notify-4.0/gtk.css
        ;;
    *)
        if [ ! -d ../gtk-"$major"."$css_minor" ]; then
            mkdir -p ../gtk-"$major"."$css_minor"
        fi

        $SASSC \
            "$major"."$css_minor"/gtk.scss ../gtk-"$major"."$css_minor"/gtk-contained.css
        echo Wrote ../gtk-"$major"."$css_minor"/gtk-contained.css
        ;;
esac

exit 0
