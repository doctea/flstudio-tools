#!/bin/sh

# Tristan ROwley 2021-04-24 -- migrates useful settings from one version of FL to another

INPUTVERSION=20
OUTPUTVERSION=21

reg.exe export "HKEY_CURRENT_USER\SOFTWARE\Image-Line\FL Studio ${INPUTVERSION}\Devices" devices.export.reg
reg.exe export "HKEY_CURRENT_USER\SOFTWARE\Image-Line\FL Studio ${INPUTVERSION}\Favorite dirs" favorites.export.reg
reg.exe export "HKEY_CURRENT_USER\SOFTWARE\Image-Line\FL Studio ${INPUTVERSION}\Search paths" searchpaths.export.reg
reg.exe export "HKEY_CURRENT_USER\SOFTWARE\Image-Line\FL Studio ${INPUTVERSION}\Windows" windows.export.reg

echo "Windows Registry Editor Version 5.00" > reimport.reg
cat *export.reg | tr -d '\000' > stageone.reg

iconv -f utf-8 -t ascii -c stageone.reg > stagetwo.reg

sed -ie "s/FL Studio ${INPUTVERSION}/FL Studio ${OUTPUTVERSION}/mg" stagetwo.reg

grep -v "^Windows Registry Editor Version 5.00$" stagetwo.reg >> reimport.reg

reg.exe import reimport.reg
