#!/usr/bin/env bash
while read -r
do
	# embed referenced scripts
	[[ $REPLY == *\<script* ]] && [[ $REPLY == *src=* ]] && {
		SRC=${REPLY#*src=\"}
		SRC=${SRC%%\"*}
		[ -r "$SRC" ] && {
			echo '<script>'
			esbuild --minify "$SRC"
			echo '</script>'
			continue
		}
	}
	# skip comments
	REPLY=${REPLY%%//*}
	# skip indent
	REPLY=${REPLY##*$'\t'}
	# skip empty lines
	[ "$REPLY" ] || continue
	echo "$REPLY"
done | sed -e 's/><\/circle>/\/>/g;s/><\/ellipse>/\/>/g;s/><\/line>/\/>/g;s/><\/path>/\/>/g;s/><\/polygon>/\/>/g;s/><\/polyline>/\/>/g;s/><\/rect>/\/>/g'
