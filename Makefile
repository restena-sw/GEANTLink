#
#    Copyright 1991-2018 Amebis
#    Copyright 2016 GÉANT
#
#    This file is part of GÉANTLink.
#
#    GÉANTLink is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    GÉANTLink is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with GÉANTLink. If not, see <http://www.gnu.org/licenses/>.
#

!INCLUDE "include\MSIBuildCfg.mak"

PRODUCT_NAME=GEANTLink
OUTPUT_DIR=output
PUBLISH_PACKAGE_DIR=..\dist

!IF "$(PROCESSOR_ARCHITECTURE)" == "AMD64"
PLAT=x64
REG_FLAGS=/f /reg:64
REG_FLAGS32=/f /reg:32
PROGRAM_FILES_32=C:\Program Files (x86)
!ELSEIF "$(PROCESSOR_ARCHITECTURE)" == "ARM64"
PLAT=ARM64
REG_FLAGS=/f /reg:64
REG_FLAGS32=/f /reg:32
PROGRAM_FILES_32=C:\Program Files (x86)
!ELSE
PLAT=Win32
REG_FLAGS=/f
PROGRAM_FILES_32=C:\Program Files
!ENDIF
MSBUILDFLAGS=/v:m /m

EVENT_CHANNEL_OPERATIONAL_ENABLED=0
EVENT_CHANNEL_ANALYTIC_ENABLED=0


All ::

Clean :: \
	CleanSetup

CleanSetup ::
	cd "MSI\MSIBuild\Version"
	$(MAKE) /f "Makefile" /$(MAKEFLAGS) Clean
	cd "$(MAKEDIR)"
	-if exist "$(OUTPUT_DIR)\Setup\CredWrite.exe"     del /f /q "$(OUTPUT_DIR)\Setup\CredWrite.exe"
	-if exist "$(OUTPUT_DIR)\Setup\MsiUseFeature.exe" del /f /q "$(OUTPUT_DIR)\Setup\MsiUseFeature.exe"


######################################################################
# Version info parsing
######################################################################

All \
Setup \
SetupDebug \
Publish :: "MSI\MSIBuild\Version\Version.mak"

"MSI\MSIBuild\Version\Version.mak" ::
	cd "MSI\MSIBuild\Version"
	$(MAKE) /f "Makefile" /$(MAKEFLAGS) Version
	cd "$(MAKEDIR)"


######################################################################
# Default target
######################################################################

All :: \
	Setup


######################################################################
# Private/public RSA key-pair generation
######################################################################

GenRSAKeypair :: \
	"include\KeyPrivate.bin" \
	"include\KeyPublic.bin"

"include\KeyPrivate.bin" :
	if exist $@ del /f /q $@
	if exist "$(@:"=).tmp" del /f /q "$(@:"=).tmp"
	openssl.exe genrsa 2048 | openssl.exe rsa -inform PEM -outform DER -out "$(@:"=).tmp"
	move /y "$(@:"=).tmp" $@ > NUL

"include\KeyPublic.bin" : "include\KeyPrivate.bin"
	if exist $@ del /f /q $@
	if exist "$(@:"=).tmp" del /f /q "$(@:"=).tmp"
	openssl.exe rsa -in $** -inform DER -outform DER -out "$(@:"=).tmp" -pubout
	move /y "$(@:"=).tmp" $@ > NUL


######################################################################
# Setup
######################################################################

Setup :: \
	"$(OUTPUT_DIR)\Setup" \
	"$(OUTPUT_DIR)\Setup\CredWrite.exe" \
	"$(OUTPUT_DIR)\Setup\MsiUseFeature.exe"

SetupDebug :: \
	"$(OUTPUT_DIR)\Setup"


######################################################################
# Publishing
######################################################################

Publish :: \
	"$(PUBLISH_PACKAGE_DIR)" \
	"$(PUBLISH_PACKAGE_DIR)\CredWrite.exe" \
	"$(PUBLISH_PACKAGE_DIR)\MsiUseFeature.exe"


######################################################################
# Registration
######################################################################

Register :: \
	StopServices \
	RegisterSettings \
	RegisterDLLs \
	StartServices \
	RegisterShortcuts

Unregister :: \
	UnregisterShortcuts \
	StopServices \
	UnregisterDLLs \
	UnregisterSettings \
	StartServices

StartServices ::
	cmd.exe /c <<"$(TEMP)\start_EapHost.bat"
@echo off
net.exe start EapHost
if errorlevel 3 exit %errorlevel%
if errorlevel 2 exit 0
exit %errorlevel%
<<NOKEEP
# Enable dot3svc service (Wired AutoConfig) and start it
	sc.exe config dot3svc start= auto
	cmd.exe /c <<"$(TEMP)\start_dot3svc.bat"
@echo off
net.exe start dot3svc
if errorlevel 3 exit %errorlevel%
if errorlevel 2 exit 0
exit %errorlevel%
<<NOKEEP
# Enable Wlansvc service (WLAN AutoConfig) and start it
	sc.exe config Wlansvc start= auto
	cmd.exe /c <<"$(TEMP)\start_Wlansvc.bat"
@echo off
net.exe start Wlansvc
if errorlevel 3 exit %errorlevel%
if errorlevel 2 exit 0
exit %errorlevel%
<<NOKEEP

StopServices ::
	-net.exe stop Wlansvc
	-net.exe stop dot3svc
	-net.exe stop EapHost

RegisterSettings ::
	reg.exe add "HKLM\Software\$(MSIBUILD_VENDOR_NAME)\$(MSIBUILD_PRODUCT_NAME)" /v "Language"                   /t REG_SZ /d "en_US"                           $(REG_FLAGS) > NUL
	reg.exe add "HKLM\Software\$(MSIBUILD_VENDOR_NAME)\$(MSIBUILD_PRODUCT_NAME)" /v "LocalizationRepositoryPath" /t REG_SZ /d "$(MAKEDIR)\$(OUTPUT_DIR)\locale" $(REG_FLAGS) > NUL
!IF "$(PROCESSOR_ARCHITECTURE)" == "AMD64" || "$(PROCESSOR_ARCHITECTURE)" == "ARM64"
	reg.exe add "HKLM\Software\$(MSIBUILD_VENDOR_NAME)\$(MSIBUILD_PRODUCT_NAME)" /v "Language"                   /t REG_SZ /d "en_US"                           $(REG_FLAGS32) > NUL
	reg.exe add "HKLM\Software\$(MSIBUILD_VENDOR_NAME)\$(MSIBUILD_PRODUCT_NAME)" /v "LocalizationRepositoryPath" /t REG_SZ /d "$(MAKEDIR)\$(OUTPUT_DIR)\locale" $(REG_FLAGS32) > NUL
!ENDIF

UnregisterSettings ::
	-reg.exe delete "HKLM\Software\$(MSIBUILD_VENDOR_NAME)\$(MSIBUILD_PRODUCT_NAME)" /v "Language"                   $(REG_FLAGS) > NUL
	-reg.exe delete "HKLM\Software\$(MSIBUILD_VENDOR_NAME)\$(MSIBUILD_PRODUCT_NAME)" /v "LocalizationRepositoryPath" $(REG_FLAGS) > NUL
!IF "$(PROCESSOR_ARCHITECTURE)" == "AMD64" || "$(PROCESSOR_ARCHITECTURE)" == "ARM64"
	-reg.exe delete "HKLM\Software\$(MSIBUILD_VENDOR_NAME)\$(MSIBUILD_PRODUCT_NAME)" /v "Language"                   $(REG_FLAGS32) > NUL
	-reg.exe delete "HKLM\Software\$(MSIBUILD_VENDOR_NAME)\$(MSIBUILD_PRODUCT_NAME)" /v "LocalizationRepositoryPath" $(REG_FLAGS32) > NUL
!ENDIF

RegisterDLLs :: \
	"$(OUTPUT_DIR)\$(PLAT).Debug\Events.dll" \
	"$(OUTPUT_DIR)\$(PLAT).Debug\EAPTTLS.dll" \
	"$(OUTPUT_DIR)\$(PLAT).Debug\EAPTTLSUI.dll"
#	wevtutil.exe im "lib\Events\res\EventsETW.man" /rf:"$(MAKEDIR)\$(OUTPUT_DIR)\$(PLAT).Debug\Events.dll" /mf:"$(MAKEDIR)\$(OUTPUT_DIR)\$(PLAT).Debug\Events.dll"
	reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WINEVT\Publishers\{3f65af01-ce8f-4c7d-990b-673b244aac7b}"                               /ve                           /t REG_SZ    /d "$(MSIBUILD_VENDOR_NAME)-$(MSIBUILD_PRODUCT_NAME)-EAPMethod"             /f > NUL
	reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WINEVT\Publishers\{3f65af01-ce8f-4c7d-990b-673b244aac7b}"                               /v "MessageFileName"          /t REG_SZ    /d "$(MAKEDIR)\$(OUTPUT_DIR)\$(PLAT).Debug\Events.dll"                      /f > NUL
	reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WINEVT\Publishers\{3f65af01-ce8f-4c7d-990b-673b244aac7b}"                               /v "ResourceFileName"         /t REG_SZ    /d "$(MAKEDIR)\$(OUTPUT_DIR)\$(PLAT).Debug\Events.dll"                      /f > NUL
	reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WINEVT\Publishers\{3f65af01-ce8f-4c7d-990b-673b244aac7b}"                               /v "Enabled"                  /t REG_DWORD /d 1                                                                        /f > NUL
	reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WINEVT\Channels\$(MSIBUILD_VENDOR_NAME)-$(MSIBUILD_PRODUCT_NAME)-EAPMethod/Operational" /v "OwningPublisher"          /t REG_SZ    /d "{3f65af01-ce8f-4c7d-990b-673b244aac7b}"                                 /f > NUL
	reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WINEVT\Channels\$(MSIBUILD_VENDOR_NAME)-$(MSIBUILD_PRODUCT_NAME)-EAPMethod/Operational" /v "Enabled"                  /t REG_DWORD /d "$(EVENT_CHANNEL_OPERATIONAL_ENABLED)"                                   /f > NUL
	reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WINEVT\Channels\$(MSIBUILD_VENDOR_NAME)-$(MSIBUILD_PRODUCT_NAME)-EAPMethod/Operational" /v "Isolation"                /t REG_DWORD /d 0                                                                        /f > NUL
	reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WINEVT\Channels\$(MSIBUILD_VENDOR_NAME)-$(MSIBUILD_PRODUCT_NAME)-EAPMethod/Operational" /v "ChannelAccess"            /t REG_SZ    /d "O:BAG:SYD:(A;;0xf0007;;;SY)(A;;0x7;;;BA)(A;;0x7;;;SO)(A;;0x3;;;IU)(A;;0x3;;;SU)(A;;0x3;;;S-1-5-3)(A;;0x3;;;S-1-5-33)(A;;0x1;;;S-1-5-32-573)" /f > NUL
	reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WINEVT\Channels\$(MSIBUILD_VENDOR_NAME)-$(MSIBUILD_PRODUCT_NAME)-EAPMethod/Operational" /v "MaxSize"                  /t REG_DWORD /d 1048576                                                                  /f > NUL
	reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WINEVT\Channels\$(MSIBUILD_VENDOR_NAME)-$(MSIBUILD_PRODUCT_NAME)-EAPMethod/Operational" /v "MaxSizeUpper"             /t REG_DWORD /d 0                                                                        /f > NUL
	reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WINEVT\Channels\$(MSIBUILD_VENDOR_NAME)-$(MSIBUILD_PRODUCT_NAME)-EAPMethod/Operational" /v "Retention"                /t REG_DWORD /d 0                                                                        /f > NUL
	reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WINEVT\Channels\$(MSIBUILD_VENDOR_NAME)-$(MSIBUILD_PRODUCT_NAME)-EAPMethod/Operational" /v "AutoBackupLogFiles"       /t REG_DWORD /d 0                                                                        /f > NUL
	reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WINEVT\Channels\$(MSIBUILD_VENDOR_NAME)-$(MSIBUILD_PRODUCT_NAME)-EAPMethod/Operational" /v "Type"                     /t REG_DWORD /d 1                                                                        /f > NUL
	reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WINEVT\Channels\$(MSIBUILD_VENDOR_NAME)-$(MSIBUILD_PRODUCT_NAME)-EAPMethod/Analytic"    /v "OwningPublisher"          /t REG_SZ    /d "{3f65af01-ce8f-4c7d-990b-673b244aac7b}"                                 /f > NUL
	reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WINEVT\Channels\$(MSIBUILD_VENDOR_NAME)-$(MSIBUILD_PRODUCT_NAME)-EAPMethod/Analytic"    /v "Enabled"                  /t REG_DWORD /d "$(EVENT_CHANNEL_ANALYTIC_ENABLED)"                                      /f > NUL
	reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WINEVT\Channels\$(MSIBUILD_VENDOR_NAME)-$(MSIBUILD_PRODUCT_NAME)-EAPMethod/Analytic"    /v "Isolation"                /t REG_DWORD /d 0                                                                        /f > NUL
	reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WINEVT\Channels\$(MSIBUILD_VENDOR_NAME)-$(MSIBUILD_PRODUCT_NAME)-EAPMethod/Analytic"    /v "ChannelAccess"            /t REG_SZ    /d "O:BAG:SYD:(A;;0xf0007;;;SY)(A;;0x7;;;BA)(A;;0x7;;;SO)(A;;0x3;;;IU)(A;;0x3;;;SU)(A;;0x3;;;S-1-5-3)(A;;0x3;;;S-1-5-33)(A;;0x1;;;S-1-5-32-573)" /f > NUL
	reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WINEVT\Channels\$(MSIBUILD_VENDOR_NAME)-$(MSIBUILD_PRODUCT_NAME)-EAPMethod/Analytic"    /v "MaxSize"                  /t REG_DWORD /d 1048576                                                                  /f > NUL
	reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WINEVT\Channels\$(MSIBUILD_VENDOR_NAME)-$(MSIBUILD_PRODUCT_NAME)-EAPMethod/Analytic"    /v "MaxSizeUpper"             /t REG_DWORD /d 0                                                                        /f > NUL
	reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WINEVT\Channels\$(MSIBUILD_VENDOR_NAME)-$(MSIBUILD_PRODUCT_NAME)-EAPMethod/Analytic"    /v "Retention"                /t REG_DWORD /d 4294967295                                                               /f > NUL
	reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WINEVT\Channels\$(MSIBUILD_VENDOR_NAME)-$(MSIBUILD_PRODUCT_NAME)-EAPMethod/Analytic"    /v "Type"                     /t REG_DWORD /d 2                                                                        /f > NUL
	reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WINEVT\Publishers\{3f65af01-ce8f-4c7d-990b-673b244aac7b}\ChannelReferences\0"           /ve                           /t REG_SZ    /d "$(MSIBUILD_VENDOR_NAME)-$(MSIBUILD_PRODUCT_NAME)-EAPMethod/Operational" /f > NUL
	reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WINEVT\Publishers\{3f65af01-ce8f-4c7d-990b-673b244aac7b}\ChannelReferences\0"           /v "Id"                       /t REG_DWORD /d 16                                                                       /f > NUL
	reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WINEVT\Publishers\{3f65af01-ce8f-4c7d-990b-673b244aac7b}\ChannelReferences\0"           /v "Flags"                    /t REG_DWORD /d 0                                                                        /f > NUL
	reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WINEVT\Publishers\{3f65af01-ce8f-4c7d-990b-673b244aac7b}\ChannelReferences\1"           /ve                           /t REG_SZ    /d "$(MSIBUILD_VENDOR_NAME)-$(MSIBUILD_PRODUCT_NAME)-EAPMethod/Analytic"    /f > NUL
	reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WINEVT\Publishers\{3f65af01-ce8f-4c7d-990b-673b244aac7b}\ChannelReferences\1"           /v "Id"                       /t REG_DWORD /d 17                                                                       /f > NUL
	reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WINEVT\Publishers\{3f65af01-ce8f-4c7d-990b-673b244aac7b}\ChannelReferences\1"           /v "Flags"                    /t REG_DWORD /d 0                                                                        /f > NUL
	reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WINEVT\Publishers\{3f65af01-ce8f-4c7d-990b-673b244aac7b}\ChannelReferences"             /v "Count"                    /t REG_DWORD /d 2                                                                        /f > NUL
	reg.exe add "HKLM\SYSTEM\CurrentControlSet\services\EapHost\Methods\67532"                                                                          /ve                           /t REG_SZ    /d "$(MSIBUILD_PRODUCT_NAME)"                                               /f > NUL
	reg.exe add "HKLM\SYSTEM\CurrentControlSet\services\EapHost\Methods\67532\21"                                                                       /v "PeerDllPath"              /t REG_SZ    /d "$(MAKEDIR)\$(OUTPUT_DIR)\$(PLAT).Debug\EAPTTLS.dll"                     /f > NUL
	reg.exe add "HKLM\SYSTEM\CurrentControlSet\services\EapHost\Methods\67532\21"                                                                       /v "PeerConfigUIPath"         /t REG_SZ    /d "$(MAKEDIR)\$(OUTPUT_DIR)\$(PLAT).Debug\EAPTTLSUI.dll"                   /f > NUL
	reg.exe add "HKLM\SYSTEM\CurrentControlSet\services\EapHost\Methods\67532\21"                                                                       /v "PeerIdentityPath"         /t REG_SZ    /d "$(MAKEDIR)\$(OUTPUT_DIR)\$(PLAT).Debug\EAPTTLSUI.dll"                   /f > NUL
	reg.exe add "HKLM\SYSTEM\CurrentControlSet\services\EapHost\Methods\67532\21"                                                                       /v "PeerInteractiveUIPath"    /t REG_SZ    /d "$(MAKEDIR)\$(OUTPUT_DIR)\$(PLAT).Debug\EAPTTLSUI.dll"                   /f > NUL
	reg.exe add "HKLM\SYSTEM\CurrentControlSet\services\EapHost\Methods\67532\21"                                                                       /v "PeerFriendlyName"         /t REG_SZ    /d "@$(MAKEDIR)\$(OUTPUT_DIR)\$(PLAT).Debug\EAPTTLS.dll,-1"                 /f > NUL
	reg.exe add "HKLM\SYSTEM\CurrentControlSet\services\EapHost\Methods\67532\21"                                                                       /v "PeerInvokePasswordDialog" /t REG_DWORD /d 0                                                                        /f > NUL
	reg.exe add "HKLM\SYSTEM\CurrentControlSet\services\EapHost\Methods\67532\21"                                                                       /v "PeerInvokeUsernameDialog" /t REG_DWORD /d 0                                                                        /f > NUL
	reg.exe add "HKLM\SYSTEM\CurrentControlSet\services\EapHost\Methods\67532\21"                                                                       /v "Properties"               /t REG_DWORD /d 389871807                                                                /f > NUL

UnregisterDLLs ::
	-reg.exe delete "HKLM\SYSTEM\CurrentControlSet\services\EapHost\Methods\67532"                                                              /f > NUL
	-reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WINEVT\Channels\$(MSIBUILD_VENDOR_NAME)-$(MSIBUILD_PRODUCT_NAME)-EAPMethod" /f > NUL
	-reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WINEVT\Publishers\{3f65af01-ce8f-4c7d-990b-673b244aac7b}"                   /f > NUL
#	-wevtutil.exe um "lib\Events\res\EventsETW.man"

RegisterShortcuts :: \
	"$(PROGRAMDATA)\Microsoft\Windows\Start Menu\Programs\$(MSIBUILD_PRODUCT_NAME)" \
	"$(PROGRAMDATA)\Microsoft\Windows\Start Menu\Programs\$(MSIBUILD_PRODUCT_NAME)\$(MSIBUILD_PRODUCT_NAME) Event Monitor.lnk"

UnregisterShortcuts ::
	-if exist "$(PROGRAMDATA)\Microsoft\Windows\Start Menu\Programs\$(MSIBUILD_PRODUCT_NAME)" rd /s /q "$(PROGRAMDATA)\Microsoft\Windows\Start Menu\Programs\$(MSIBUILD_PRODUCT_NAME)"


######################################################################
# Folder creation
######################################################################

"$(OUTPUT_DIR)" \
"$(OUTPUT_DIR)\locale" \
"$(OUTPUT_DIR)\Setup" \
"$(PUBLISH_PACKAGE_DIR)" \
"$(PROGRAMDATA)\Microsoft\Windows\Start Menu\Programs\$(MSIBUILD_PRODUCT_NAME)" :
	if not exist $@ md $@

"$(OUTPUT_DIR)\locale" \
"$(OUTPUT_DIR)\Setup" : "$(OUTPUT_DIR)"


######################################################################
# File copy
######################################################################

"$(OUTPUT_DIR)\Setup\CredWrite.exe" \
"$(PUBLISH_PACKAGE_DIR)\CredWrite.exe" : "$(OUTPUT_DIR)\Win32.Release\CredWrite.exe"
	copy /y $** $@ > NUL

"$(OUTPUT_DIR)\Setup\MsiUseFeature.exe" \
"$(PUBLISH_PACKAGE_DIR)\MsiUseFeature.exe" : "$(OUTPUT_DIR)\Win32.Release\MsiUseFeature.exe"
	copy /y $** $@ > NUL


######################################################################
# Shortcut creation
######################################################################

"$(PROGRAMDATA)\Microsoft\Windows\Start Menu\Programs\$(MSIBUILD_PRODUCT_NAME)\$(MSIBUILD_PRODUCT_NAME) Event Monitor.lnk" : "$(OUTPUT_DIR)\$(PLAT).Debug\EventMonitor.exe"
	cscript.exe "bin\MkLnk.wsf" //Nologo $@ "$(MAKEDIR)\$(OUTPUT_DIR)\$(PLAT).Debug\EventMonitor.exe"


######################################################################
# Building
######################################################################

!IFDEF MANIFESTCERTIFICATETHUMBPRINT

.SUFFIXES : .cab

.cab.sign :
	-if exist $@ del /f /q $@
	-if exist "$(@:"=).tmp" del /f /q "$(@:"=).tmp"
	signtool.exe sign /sha1 "$(MANIFESTCERTIFICATETHUMBPRINT)" /fd sha256 /tr "$(MANIFESTTIMESTAMPRFC3161URL)" /d "$(MSIBUILD_PRODUCT_NAME)" /q $** > "$(@:"=).tmp"
	move /y "$(@:"=).tmp" $@ > NUL

!ENDIF


######################################################################
# Platform Specific
######################################################################

PLAT=Win32
PLAT_SUFFIX=-x86
PLAT_SLN=x86
!INCLUDE "MakefilePlat.mak"

PLAT=x64
PLAT_SUFFIX=-x64
PLAT_SLN=x64
!INCLUDE "MakefilePlat.mak"

PLAT=ARM64
PLAT_SUFFIX=-ARM64
PLAT_SLN=ARM64
!INCLUDE "MakefilePlat.mak"


######################################################################
# Language Specific
######################################################################

LANG=bg_BG
LANG_BASE=bg
!INCLUDE "MakefileLang.mak"

LANG=ca_ES
LANG_BASE=ca
!INCLUDE "MakefileLang.mak"

LANG=cs_CZ
LANG_BASE=cs
!INCLUDE "MakefileLang.mak"

LANG=cy_UK
LANG_BASE=cy
!INCLUDE "MakefileLang.mak"

LANG=de_DE
LANG_BASE=de
!INCLUDE "MakefileLang.mak"

LANG=el_GR
LANG_BASE=el
!INCLUDE "MakefileLang.mak"

LANG=en_US
LANG_BASE=en
!INCLUDE "MakefileLang.mak"

LANG=es_ES
LANG_BASE=es
!INCLUDE "MakefileLang.mak"

LANG=et_EE
LANG_BASE=et
!INCLUDE "MakefileLang.mak"

LANG=eu_ES
LANG_BASE=eu
!INCLUDE "MakefileLang.mak"

LANG=fi_FI
LANG_BASE=fi
!INCLUDE "MakefileLang.mak"

LANG=fr_FR
LANG_BASE=fr
!INCLUDE "MakefileLang.mak"

LANG=fr_CA
LANG_BASE=fr
!INCLUDE "MakefileLang.mak"

LANG=gl_ES
LANG_BASE=gl
!INCLUDE "MakefileLang.mak"

LANG=hr_HR
LANG_BASE=hr
!INCLUDE "MakefileLang.mak"

LANG=hu_HU
LANG_BASE=hu
!INCLUDE "MakefileLang.mak"

LANG=is_IS
LANG_BASE=is
!INCLUDE "MakefileLang.mak"

LANG=it_IT
LANG_BASE=it
!INCLUDE "MakefileLang.mak"

LANG=ko_KR
LANG_BASE=ko
!INCLUDE "MakefileLang.mak"

LANG=lt_LT
LANG_BASE=lt
!INCLUDE "MakefileLang.mak"

LANG=nb_NO
LANG_BASE=nb
!INCLUDE "MakefileLang.mak"

LANG=nl_NL
LANG_BASE=nl
!INCLUDE "MakefileLang.mak"

LANG=pl_PL
LANG_BASE=pl
!INCLUDE "MakefileLang.mak"

LANG=pt_PT
LANG_BASE=pt
!INCLUDE "MakefileLang.mak"

LANG=ru_RU
LANG_BASE=ru
!INCLUDE "MakefileLang.mak"

LANG=sk_SK
LANG_BASE=sk
!INCLUDE "MakefileLang.mak"

LANG=sl_SI
LANG_BASE=sl
!INCLUDE "MakefileLang.mak"

LANG=sr_RS
LANG_BASE=sr
!INCLUDE "MakefileLang.mak"

LANG=sv_SE
LANG_BASE=sv
!INCLUDE "MakefileLang.mak"

LANG=tr_TR
LANG_BASE=tr
!INCLUDE "MakefileLang.mak"

LANG=vi_VN
LANG_BASE=vi
!INCLUDE "MakefileLang.mak"
