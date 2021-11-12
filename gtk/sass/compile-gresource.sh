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

# Usage: ./compile-gresource.sh GTK_VERSION
#
# Example:
#   ./compile-gresource.sh 3.22
#
#   compile gtk.gresouce for Gtk+ version 3.22

usage() {
    sed -rn '/^# Usage/,${/^#/!q;s/^# ?//;p}' "$0"
}

#############
# Compiling #
#############

xml="gtk.gresource.xml"
image_list="`grep -e '.png' ./$xml.in | cut -d'>' -f2 | cut -d'<' -f1 | \
           cut -d'/' -f2`"

for i in $image_list
do
    if [ ! -f ../asset/assets-gtk3/$i ]; then
        echo "Error: 'assets-gtk3/$i' not found, aborted..."
        exit 1
    fi
done

case "$1" in
    3.20|3.22|3.24|4.0)
        cp "$xml".in ../gtk-"$1"/"$xml"
        sed -i "s|@VERSION[@]|$1|g" ../gtk-"$1"/"$xml"
        cd ../gtk-"$1" && ln -sf ../asset/assets-gtk3 assets && cd ../sass
        $(command -v glib-compile-resources) --sourcedir=../gtk-"$1" \
                                             ../gtk-"$1"/"$xml"
        echo '@import url("resource:///org/adapta-project/gtk-'$1'/gtk-contained.css");' \
            > ../gtk-"$1"/gtk.css

        rm -f ../gtk-"$1"/"$xml"
        rm -rf ../gtk-"$1"/assets
        ;;
    *)
        usage && exit 1
        ;;
esac

exit 0
