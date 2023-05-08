#!/bin/sh
# Uninstaller for FPC 3.2.x and Lazarus 2.0.11, 2.0.12 and 2.2.0
#
bin=/usr/local/bin
share=/usr/local/share
lib=/usr/local/lib
receipts=/private/var/db/receipts
private=/private/etc
fpcdoc="/Users/Shared/Free Pascal Compiler"
manpages=/usr/local/share/man

rm -fv $bin/ptop.rsj
rm -fv $bin/unitdiff.rsj
rm -fv $bin/fpclasschart.rsj
rm -fv $bin/makeskel.rsj
rm -fv $bin/fpcsubst.rsj
rm -fv $bin/rstconv.rsj
rm -fv $bin/fpcmkcfg.rsj
rm -fv $bin/pas2ut.rsj
rm -fv $bin/fd2pascal
rm -fv $bin/h2paspp
rm -fv $bin/postw32
rm -fv $bin/mkarmins
rm -fv $bin/mka64ins
rm -fv $bin/data2inc
rm -fv $bin/msg2inc
rm -fv $bin/mkx86ins
rm -fv $bin/ppdep
rm -fv $bin/mkinsadd
rm -fv $bin/chmls
rm -fv $bin/rmcvsdir
rm -fv $bin/fpc
rm -fv $bin/mkz80ins
rm -fv $bin/delp
rm -fv $bin/h2paschk
rm -fv $bin/plex
rm -fv $bin/pyacc
rm -fv $bin/eawparser
rm -fv $bin/gbpparser
rm -fv $bin/ppufiles
rm -fv $bin/ppumove
rm -fv $bin/chmcmd
rm -fv $bin/fpcsubst
rm -fv $bin/mkx86inl
rm -fv $bin/fprcp
rm -fv $bin/wasmtool
rm -fv $bin/instantfpc
rm -fv $bin/bin2obj
rm -fv $bin/h2pas
rm -fv $bin/wasa
rm -fv $bin/fpcreslipo
rm -fv $bin/fpcmake
rm -fv $bin/unihelper
rm -fv $bin/rstconv
rm -fv $bin/fpcjres
rm -fv $bin/pas2jni
rm -fv $bin/fpcres
rm -fv $bin/fpcmkcfg
rm -fv $bin/ppudump
rm -fv $bin/unitdiff
rm -fv $bin/makeskel
rm -fv $bin/cldrparser
rm -fv $bin/ihxutil
rm -fv $bin/ptop
rm -fv $bin/fpclasschart
rm -fv $bin/webidl2pas
rm -fv $bin/json2pas
rm -fv $bin/pas2fpm
rm -fv $bin/pas2ut
rm -fv $bin/fppkg
rm -fv $bin/pas2js
rm -fv $bin/compileserver
rm -fv $bin/fpdoc
rm -fv $bin/ppca64
rm -fv $bin/ppcx64
rm -fv $bin/ppc386

rm -rfv $private/lazarus
rm -rfv /Applications/Lazarus
rm -rfv $share/fpcsrc
rm -rfv $share/src/fpc-*
rm -rfv $share/doc/fpc-*
rm -rfv $lib/fpc

rm -rfv $receipts/org.lazarus*
rm -rfv $receipts/org.freepascal*

rm -rfv "$fpcdoc"

rm -fv $manpages/man1/bin2obj.1.gz
rm -fv $manpages/man1/chmcmd.1.gz
rm -fv $manpages/man1/chmls.1.gz
rm -fv $manpages/man1/data2inc.1.gz
rm -fv $manpages/man1/delp.1.gz
rm -fv $manpages/man1/fd2pascal.1.gz
rm -fv $manpages/man1/fpc.1.gz
rm -fv $manpages/man1/fpcjres.1.gz
rm -fv $manpages/man1/fpclasschart.1.gz
rm -fv $manpages/man1/fpcmake.1.gz
rm -fv $manpages/man1/fpcmkcfg.1.gz
rm -fv $manpages/man1/fpcres.1.gz
rm -fv $manpages/man1/fpcsubst.1.gz
rm -fv $manpages/man1/fpdoc.1.gz
rm -fv $manpages/man1/fppkg.1.gz
rm -fv $manpages/man1/fprcp.1.gz
rm -fv $manpages/man1/grab_vcsa.1.gz
rm -fv $manpages/man1/h2pas.1.gz
rm -fv $manpages/man1/h2paspp.1.gz
rm -fv $manpages/man1/makeskel.1.gz
rm -fv $manpages/man1/pas2fpm.1.gz
rm -fv $manpages/man1/pas2jni.1.gz
rm -fv $manpages/man1/pas2ut.1.gz
rm -fv $manpages/man1/plex.1.gz
rm -fv $manpages/man1/postw32.1.gz
rm -fv $manpages/man1/ppc386.1.gz
rm -fv $manpages/man1/ppcarm.1.gz
rm -fv $manpages/man1/ppcppc.1.gz
rm -fv $manpages/man1/ppcsparc.1.gz
rm -fv $manpages/man1/ppcx64.1.gz
rm -fv $manpages/man1/ppdep.1.gz
rm -fv $manpages/man1/ppudump.1.gz
rm -fv $manpages/man1/ppufiles.1.gz
rm -fv $manpages/man1/ppumove.1.gz
rm -fv $manpages/man1/ptop.1.gz
rm -fv $manpages/man1/pyacc.1.gz
rm -fv $manpages/man1/rmcvsdir.1.gz
rm -fv $manpages/man1/rstconv.1.gz
rm -fv $manpages/man1/unitdiff.1.gz
rm -fv $manpages/man5/fpc.cfg.5.gz
rm -fv $manpages/man5/fpcmake.5.gz
rm -fv $manpages/man5/ptop.cfg.5.gz

rm -fv /etc/fpc.cfg
rm -fv ~/.fpc.cfg
rm -rfv ~/.fppkg