#!/bin/bash

# Build the Lazarus IDE with extra installed packages, targetting multiple
# widget sets. The suffix is what is after the - in the binary and
# configuration directories, so it will be 2.2.6+3.2.2 if the directory is
# e.g. /usr/local/share.lazarus/lazarus-2.2.6+3.2.2 .           MarkMLl

# PREREQUISITE: The FPC compiler's PPC symlink points to the correct version.

SUFFIX=stable

# USE_ANCHORDOCKING=1
USE_LAZMAPVIEWER=1
USE_RICHMEMO=1

# set -x

# ###########################################################################

make distclean
make LCL_PLATFORM=gtk2 bigide

if [ -d ~/.lazarus-$SUFFIX ]; then

  PACKAGEPATH=/usr/local/share.lazarus

  # This allows the packages to be specified as a comma-separated list. Assume
  # that ProjectGroups are always wanted, this is in fact why I started on
  # this script.

  PACKAGENAMES='--add-package lazprojectgroups'

  if [ -n "$USE_ANCHORDOCKING" ]; then
    PACKAGENAMES+=,anchordocking
#    PACKAGENAMES+=,anchordockingdsgn
  fi # USE_ANCHORDOCKING

# Note LazMapViewer revision number both here and in LMV (below) where symlinks are created.

  if [ -n "$USE_LAZMAPVIEWER" ]; then
    PACKAGENAMES+=,$PACKAGEPATH/r9394-components-lazmapviewer/lazmapviewer_bgra.lpk
    PACKAGENAMES+=,$PACKAGEPATH/r9394-components-lazmapviewer/lazmapviewerpkg.lpk
    PACKAGENAMES+=,$PACKAGEPATH/r9394-components-lazmapviewer/lazmapviewer_rgbgraphics.lpk
    PACKAGENAMES+=,$PACKAGEPATH/r9394-components-lazmapviewer/lazmapviewer_synapse.lpk

# Prequisite runtime-only packages need to be added individually. For
# consistency, I continue to use comma-separation.

    ADDLINKS=$PACKAGEPATH/laz_synapse/synapse-master/laz_synapse.lpk
    ADDLINKS+=,$PACKAGEPATH/rgbgraphics-v1.1/rgb_graphics.lpk
    ADDLINKS+=,$PACKAGEPATH/rgbgraphics-v1.1/lazrgbgraphics.lpk
    ADDLINKS+=,$PACKAGEPATH/bgrabitmap/bgrabitmap/bgrabitmappack.lpk

    # In the specific case of a project using Synaps and OpenSSL, these two files
    # need to be copied or symlinked:

    SYN=$PACKAGEPATH/laz_synapse
    LMV=$PACKAGEPATH/r9394-components-lazmapviewer
    ln -sf $SYN/synapse-master/ssl_openssl_lib.pas $LMV/source/addons/synapse_downloadengine/ssl_openssl_lib.pas
    ln -sf $SYN/synapse-master/ssl_openssl.pas $LMV/source/addons/synapse_downloadengine/ssl_openssl.pas
    ln -sf $SYN/synapse-master/jedi.inc $LMV/source/addons/synapse_downloadengine/jedi.inc
    cat > $LMV/source/addons/synapse_downloadengine/readme.txt <<EOT
This folder contains the sources of the download engine based on the Synapse
library.

Since the Synapse package (laz_synapse.lpk) does not contain the files needed
for ssl they were copied into this folder to be found for compilation.
EOT

    # WORKING NOTE: might not build for Qt5 on account of
    # /usr/local/share.lazarus/rgbgraphics-v1.1/./source/rgbqt5routines.pas(34,34) Fatal: (10022) Can't find unit Qt5Objects used by RGBQt5Routines
    #
    # See rgbgraphics-v1.1/source/rgbqt5routines.pas:  SysUtils, Types, LCLType, Qt5, Qt5Objects, Classes,
    #
    # Fix is to remove "5" from Qt5Objects.

  fi # USE_LAZMAPVIEWER

  if [ -n "$USE_RICHMEMO" ]; then
    ADDLINKS+=,$PACKAGEPATH/richmemo/richmemo-master/richmemopackage.lpk
    PACKAGENAMES+=,$PACKAGEPATH/richmemo/richmemo-master/ide/richmemo_design.lpk
  fi # USE_RICHMEMO

# ###########################################################################

# The --build-ide= option defaults to reading the existing configuration
# directory.

  for ADDLINK in "${ADDLINKS//,/ }"
    do
      lazbuild-$SUFFIX --no-write-project --add-package-link --build-ide= $ADDLINK
    done
  ADDPACKAGES=`sed -e 's/,/ --add-package /g' <<<$PACKAGENAMES`

  # Build for the target widget set(s). Preserve original file ownership etc. if possible.

  if lazbuild-$SUFFIX --no-write-project --widgetset=qt5 $ADDPACKAGES --build-ide= ; then
    cp -p lazarus lazarus-qt5
  else
    rm -f lazarus-qt5
  fi

  if lazbuild-$SUFFIX --no-write-project --widgetset=gtk2 $ADDPACKAGES --build-ide= ; then
    cp -p lazarus lazarus-gtk2
  else
    rm -f lazarus-gtk2
  fi

  echo
  ls -lt lazarus lazarus-* lazbuild lazbuild-* startlazarus startlazarus-* 2> /dev/null
  echo

else

  # No configuration directory exists.

  echo
  echo Run lazarus-$SUFFIX to establish the basic configuration. Do not install
  echo any extra packages, or recompile from inside the IDE for any other
  echo reason since doing so might mess up the widget set choice.
  echo

fi

