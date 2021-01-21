#!/usr/bin/env bash

### usage
function usage {
  cat << HELP
  usage : $0 : simple ffmpeg frontend for musicians, with fixed picture.

  \$0 <output filename> <input Picture filename> <input MP3 filename>

  -h : show this help.
  \$1 : output Path with filename.
  \$2 : input Picture Path with filename.
  \$3 : input MP3 Path with filename.

  **Please rename already processed video file, before execute this script.**
HELP
  exit 254
}

function errq {
  echo $1
  exit $2
}

### show help
if [[ "$1" =~ [-]+[h]* ]] ; then usage; fi

### Number of arguments are must 3
if [ $# -ne 3 ] ; then usage; fi

### ffmpeg existing check
readonly EXIST_CHECK_CODE=$(command -v ffmpeg > /dev/null 2>&1)
if [ $EXIST_CHECK_CODE -ne 0 ] ; then usage ; fi

### input pict file existing check
readonly INPUT_PICT_FILE="$2"
if [ ! -f "$INPUT_PICT_FILE" ] ; then errq "Input file not found. quit." 253 ; fi

### input MP3 file existing check
readonly INPUT_MP3_FILE="$3"
if [ ! -f "$INPUT_MP3_FILE" ] ; then errq "Input file not found. quit." 252 ; fi

### output file not existing check
readonly OUTPUT_FILE="$1"
if [ -f "$OUTPUT_FILE" ] ; then errq "Output file already exists. quit." 251; fi

### convert process
readonly CMDLINEOPT="-shortest"
ffmpeg -loop 1 -i "$INPUT_PICT_FILE" -i "$INPUT_MP3_FILE" "$CMDLINEOPT" "$OUTPUT_FILE"
readonly RETVAL=$?

### notify to user ( use bell? )
if [ "$(uname)" == "Darwin" ] ; then ## is Mac
  say Convert is done.
fi

### end section

exit $RETVAL