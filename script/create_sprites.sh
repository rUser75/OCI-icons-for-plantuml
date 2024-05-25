#!/bin/bash
# 
# (C) Copyright 2024, rUser75 
# first release of this script by (C) Copyright 2017, Anthony Gaudino
# 
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
# 
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
# 
#
# Batch creates sprite files for PlantUml
#
# Given a directory convert  all PNG files to PlantUml sprite files.
#
# The generated sprites files formats are based on the ones introduced in
# PlantUml 1.2017.19.
#
#
# Help usage message
usage="Batch creates sprite files for PlantUml.

$(basename "$0") [options] prefix

options:
    -p  directory path, under source to process  Default: ./
    -b  plantuml jar file
    -g  sprite graylevel                         Default: 16z
    
    prefix: a prefix that is added to the sprite name"



# Default arguments values
        dir="./soruce"  # Directory path to process     Default: ./
  graylevel=16z         # Number of grayscale colors    Default: 16

     prefix=""          # Prefix for sprites names, avoids having
prefixupper=""          # two sprites with same name on STDLIB


descr[VCN]="Virtual Cloud Network (VCN)|#f28500|dashed"
descr[Subnets]="Subnets|#f28533|dashed"


########################################
#
#    Main function
#
########################################
main () {
    # Get arguments
    while getopts p:b:h:g: option
    do
        case "$option" in
            p)        dir="$OPTARG";;
            g)  graylevel="$OPTARG";;
            b)  jarfile="$OPTARG";;
            :) echo "$usage"
               exit 1
               ;;
           \?) echo "$usage"
               exit 1
               ;;
        esac
    done

    # Get mandatory argument
    shift $(($OPTIND-1))
    prefix=$(     echo $1 | tr '[:upper:]' '[:lower:]')
    prefixupper=$(echo $1 | tr '[:lower:]' '[:upper:]')

    # Check mandatory argument
    if [ -z "$prefix" ]
    then
        echo "Please specify a prefix!"
        echo "$usage"
        exit 1
    fi



    # Change dir to where images are
    if [ ! -d "../source/${dir}" ]
    then
	echo ""
        echo "Please specify a valid directory"
        echo "$usage"
        exit 1
    fi

    if [ -n "$jarfile" -a -f "$jarfile" ]; then 
	plantumlBin="java -jar "$jarfile""
    else
    	if [ -z "$(which plantuml 2>/dev/null)" ]; then
	    echo ""
            echo "Please install plantuml under $PATH"
	    echo " or use the -b flag"
            echo "$usage"
	    exit 1
	    fi
    fi 
    process_png
}




########################################
#
#    Generate PlantUml sprite
#
########################################
process_png () {
	for file in $(find ../source/$dir/*.png)
	do
		[ -f "$file" ] || continue
		filename=$(echo $(basename $file) | sed -e 's/.png$//')                 # Filename without extension
		filenameupper=$(echo $filename | tr '[:lower:]' '[:upper:]')  # Filename without extension in uppercase
		spritename="${prefix}_$filename"                           # Sprite name is composed by prefix_filename
		spritenameupper="${prefixupper}_$filenameupper"                 # Sprite name in uppercase
		spritestereo="$prefixupper $filenameupper"                   # Sprite stereotype is uppercase prefix followed by uppercase filename
		stereowhites=$(echo $spritestereo | sed -e 's/./ /g')        # This is just whitespace to make output nicer
		dest=$(echo $file|sed 's/source/dist/'|sed -e 's/.png$//')
		category=$(dirname $file|sed 's/.*source\///')
		mkdir -p $(dirname $dest)
                base64IMG=$(base64 -w 0 $file)
                echo -e "'Image contente are Copyright Oracle, Inc. or its affiliates. All Rights Reserved. \n\n"                                                        >${dest}.puml
		echo -e "$($plantumlBin  -encodesprite $graylevel $file | sed '1!b;s/\$/$'${prefix}_'/')\n"                                                              >>${dest}.puml 
		if [ -n "$(echo $dest|grep Groups)" ]; then
			echo -e "!function \$${spritename}GroupIMG(\$scale=1)"                                                                                                        >>${dest}.puml
		else
			echo -e "!function \$${spritename}IMG(\$scale=1)"                                                                                                        >>${dest}.puml
		fi

		echo -e "!return \"<img data:image/png;base64,$base64IMG{scale=\"+\$scale+\"}>\""                                                                        >>${dest}.puml
		echo -e "!endfunction\n\n"                                                                                                                               >>${dest}.puml
		if [ -n "$(echo $dest|grep Groups)" ]; then
			color=$(echo ${descr[$spritenameupper]}|awk -F"|" '{print $2}')
			longdescr=$(echo ${descr[$spritenameupper]}|awk -F"|" '{print $1}')
			borderType=$(echo ${descr[$spritenameupper]}|awk -F"|" '{print $3}')

			echo "\$OCIGroupColoring(${spritename}Group,\"$color\", $borderType)"                                                                           >>${dest}.puml
			echo "!define ${spritename}Group(g_alias, g_label=\"$longdescr\") \$OCIDefineGroup(g_alias, g_label, ${spritename}Group, ${spritename}Group)" >>${dest}.puml
		else
			echo "OCIEntityColoring($spritename,\$OCIColor($category))"                                                                                                                   >>${dest}.puml
			echo "!define $spritename(e_alias, e_label, e_techn) OCIEntity(e_alias, e_label, e_techn, #ED7100, $spritename, $spritename)"                            >>${dest}.puml
      			echo "!define $spritename(e_alias, e_label, e_techn, e_descr) OCIEntity(e_alias, e_label, e_techn, e_descr, #ED7100, $spritename, $spritename)"          >>${dest}.puml
	                echo "!define $spritenameupper(_color)                                 SPRITE_PUT(          $stereowhites          $spritename, _color)"                 >>${dest}.puml
        		echo "!define $spritenameupper(_color, _scale)                         SPRITE_PUT(          $stereowhites          $spritename, _color, _scale)"         >>${dest}.puml
			echo "!define $spritenameupper(_color, _scale, _alias)                 SPRITE_ENT(  _alias, $spritestereo,         $spritename, _color, _scale)"         >>${dest}.puml
		        echo "!define $spritenameupper(_color, _scale, _alias, _shape)         SPRITE_ENT(  _alias, $spritestereo,         $spritename, _color, _scale, _shape)" >>${dest}.puml
			echo "!define $spritenameupper(_color, _scale, _alias, _shape, _label) SPRITE_ENT_L(_alias, $spritestereo, _label, $spritename, _color, _scale, _shape)" >>${dest}.puml
			echo "skinparam folderBackgroundColor<<$prefixupper $filenameupper>> White"                                                                              >>${dest}.puml
		fi
        
	done
	rm $(dirname $dest)/all.puml 2>/dev/null
	if [ "$dir" = "Groups" ]; then
		cp ../common/Groups/* ../dist/Groups/
	fi
	cat $(dirname $dest)/*.puml > $(dirname $dest)/all.puml
}

main "$@"
