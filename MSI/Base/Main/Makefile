#
#    Copyright 1991-2016 Amebis
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

!INCLUDE "..\..\..\include\MSIBuildCfg.mak"

!IFNDEF MSIBUILD_PRODUCT_NAME
!ERROR Parameter MSIBUILD_PRODUCT_NAME is undefined.
!ENDIF

!IFNDEF MSIBUILD_PRODUCT_NAME_ID
!ERROR Parameter MSIBUILD_PRODUCT_NAME_ID is undefined.
!ENDIF

!IFNDEF MSIBUILD_PRODUCT_NAME_UC
!ERROR Parameter MSIBUILD_PRODUCT_NAME_UC is undefined.
!ENDIF

!IFNDEF MSIBUILD_PRODUCT_NAME_8_3
!ERROR Parameter MSIBUILD_PRODUCT_NAME_8_3 is undefined.
!ENDIF

MSIBUILD_IS_LOCALIZEABLE=1


######################################################################
# AppSearch

All :: "$(LANG).$(PLAT).$(CFG).AppSearch-1.idt"

"$(LANG).$(PLAT).$(CFG).AppSearch-1.idt" : "Makefile" "..\..\..\include\MSIBuildCfg.mak"
	-if exist $@ del /f /q $@
	move /y << $@ > NUL
Property	Signature_
s$(MSIBUILD_LENGTH_ID)	s$(MSIBUILD_LENGTH_ID)
AppSearch	Property	Signature_
LANGREG	rlLanguage.Win32
!IF "$(PLAT)" == "x64" || "$(PLAT)" == "ARM64"
LANGREG	rlLanguage.$(PLAT)
!ENDIF
<<NOKEEP


######################################################################
# Component

All :: "$(LANG).$(PLAT).$(CFG).Component-1.idt"

"$(LANG).$(PLAT).$(CFG).Component-1.idt" : "Makefile" "..\..\..\include\MSIBuildCfg.mak"
	-if exist $@ del /f /q $@
	move /y << $@ > NUL
Component	ComponentId	Directory_	Attributes	Condition	KeyPath
s$(MSIBUILD_LENGTH_ID)	S38	s$(MSIBUILD_LENGTH_ID)	i2	S255	S$(MSIBUILD_LENGTH_ID)
Component	Component
compLocalizationRepositoryPath	{6551BCAB-3558-4A73-A8F2-D5A17E85481B}	$(MSIBUILD_PRODUCT_NAME_UC)LOCDIR	$(MSIBUILD_COMPONENT_ATTRIB_REGISTRY)		regLocalizationRepositoryPath
compLanguage	{187A7FE1-A380-4281-9FB6-456B161CDF36}	$(MSIBUILD_PRODUCT_NAME_UC)LOCDIR	$(MSIBUILD_COMPONENT_ATTRIB_REGISTRY)		regLanguage
!IF "$(LANG)" == "bg_BG"
compwxstd.mo.bg_BG	{5BFC819A-8A84-42D8-9A72-3733450235E4}	$(MSIBUILD_PRODUCT_NAME_UC)LOCBGBGDIR	$(MSIBUILD_COMPONENT_ATTRIB_FILE)		filewxstd.mo.bg_BG
!ENDIF
!IF "$(LANG)" == "ca_ES"
compwxstd.mo.ca_ES	{13A6BB65-A94A-4099-BDD9-6ABA1E671315}	$(MSIBUILD_PRODUCT_NAME_UC)LOCCAESDIR	$(MSIBUILD_COMPONENT_ATTRIB_FILE)		filewxstd.mo.ca_ES
!ENDIF
!IF "$(LANG)" == "cs_CZ"
compwxstd.mo.cs_CZ	{9B02DD2B-087E-471D-BE45-6791AFC02AEE}	$(MSIBUILD_PRODUCT_NAME_UC)LOCCSCZDIR	$(MSIBUILD_COMPONENT_ATTRIB_FILE)		filewxstd.mo.cs_CZ
!ENDIF
!IF "$(LANG)" == "cy_UK"
compwxstd.mo.cy_UK	{D7861D12-136F-4F17-B641-B16DC6B8E59D}	$(MSIBUILD_PRODUCT_NAME_UC)LOCCYUKDIR	$(MSIBUILD_COMPONENT_ATTRIB_FILE)		filewxstd.mo.cy_UK
!ENDIF
!IF "$(LANG)" == "de_DE"
compwxstd.mo.de_DE	{8876257E-802F-49C6-A034-889B141AD1E9}	$(MSIBUILD_PRODUCT_NAME_UC)LOCDEDEDIR	$(MSIBUILD_COMPONENT_ATTRIB_FILE)		filewxstd.mo.de_DE
!ENDIF
!IF "$(LANG)" == "el_GR"
compwxstd.mo.el_GR	{055F433E-67DA-46AF-9BD6-B2583FCD4A4E}	$(MSIBUILD_PRODUCT_NAME_UC)LOCELGRDIR	$(MSIBUILD_COMPONENT_ATTRIB_FILE)		filewxstd.mo.el_GR
!ENDIF
!IF "$(LANG)" == "es_ES"
compwxstd.mo.es_ES	{7D5190B8-1995-4A14-A35D-97E6A9FE760B}	$(MSIBUILD_PRODUCT_NAME_UC)LOCESESDIR	$(MSIBUILD_COMPONENT_ATTRIB_FILE)		filewxstd.mo.es_ES
!ENDIF
!IF "$(LANG)" == "et_EE"
compwxstd.mo.et_EE	{C1D29EB8-4868-482F-B26C-6D4EE971DBD3}	$(MSIBUILD_PRODUCT_NAME_UC)LOCETEEDIR	$(MSIBUILD_COMPONENT_ATTRIB_FILE)		filewxstd.mo.et_EE
!ENDIF
!IF "$(LANG)" == "eu_ES"
compwxstd.mo.eu_ES	{8C95290F-0C97-46F8-B902-742FAFB6DC05}	$(MSIBUILD_PRODUCT_NAME_UC)LOCEUESDIR	$(MSIBUILD_COMPONENT_ATTRIB_FILE)		filewxstd.mo.eu_ES
!ENDIF
!IF "$(LANG)" == "fi_FI"
compwxstd.mo.fi_FI	{A428F879-7336-408E-AF85-D88EF8F4DE05}	$(MSIBUILD_PRODUCT_NAME_UC)LOCFIFIDIR	$(MSIBUILD_COMPONENT_ATTRIB_FILE)		filewxstd.mo.fi_FI
!ENDIF
!IF "$(LANG)" == "fr_CA"
compwxstd.mo.fr_CA	{E8DAB2AF-B822-48A3-861F-9CD991E5053B}	$(MSIBUILD_PRODUCT_NAME_UC)LOCFRCADIR	$(MSIBUILD_COMPONENT_ATTRIB_FILE)		filewxstd.mo.fr_CA
!ENDIF
!IF "$(LANG)" == "fr_FR"
compwxstd.mo.fr_FR	{16F8D005-0BFA-4F5F-AAAB-97E9DF8956F1}	$(MSIBUILD_PRODUCT_NAME_UC)LOCFRFRDIR	$(MSIBUILD_COMPONENT_ATTRIB_FILE)		filewxstd.mo.fr_FR
!ENDIF
!IF "$(LANG)" == "gl_ES"
compwxstd.mo.gl_ES	{DFD6C558-693E-446C-86F4-45F69C72F7E7}	$(MSIBUILD_PRODUCT_NAME_UC)LOCGLESDIR	$(MSIBUILD_COMPONENT_ATTRIB_FILE)		filewxstd.mo.gl_ES
!ENDIF
!IF "$(LANG)" == "hr_HR"
compwxstd.mo.hr_HR	{97F287F3-A48F-4DB5-A991-0D9D0DD63334}	$(MSIBUILD_PRODUCT_NAME_UC)LOCHRHRDIR	$(MSIBUILD_COMPONENT_ATTRIB_FILE)		filewxstd.mo.hr_HR
!ENDIF
!IF "$(LANG)" == "hu_HU"
compwxstd.mo.hu_HU	{7DE47314-7BE3-434E-A662-081FA8B2F683}	$(MSIBUILD_PRODUCT_NAME_UC)LOCHUHUDIR	$(MSIBUILD_COMPONENT_ATTRIB_FILE)		filewxstd.mo.hu_HU
!ENDIF
!IF "$(LANG)" == "is_IS"
compwxstd.mo.is_IS	{4F2FC4FE-B7B6-48AD-AF8E-4588C065E707}	$(MSIBUILD_PRODUCT_NAME_UC)LOCISISDIR	$(MSIBUILD_COMPONENT_ATTRIB_FILE)		filewxstd.mo.is_IS
!ENDIF
!IF "$(LANG)" == "it_IT"
compwxstd.mo.it_IT	{5700AEF2-4A85-4053-B189-A157CFE5B6CE}	$(MSIBUILD_PRODUCT_NAME_UC)LOCITITDIR	$(MSIBUILD_COMPONENT_ATTRIB_FILE)		filewxstd.mo.it_IT
!ENDIF
!IF "$(LANG)" == "ko_KR"
compwxstd.mo.ko_KR	{013706B2-4B3B-4DDF-8C3E-12D5D1F197E9}	$(MSIBUILD_PRODUCT_NAME_UC)LOCKOKRDIR	$(MSIBUILD_COMPONENT_ATTRIB_FILE)		filewxstd.mo.ko_KR
!ENDIF
!IF "$(LANG)" == "lt_LT"
compwxstd.mo.lt_LT	{1DE26F70-E106-4D17-8AB0-82898D4F1E8D}	$(MSIBUILD_PRODUCT_NAME_UC)LOCLTLTDIR	$(MSIBUILD_COMPONENT_ATTRIB_FILE)		filewxstd.mo.lt_LT
!ENDIF
!IF "$(LANG)" == "nb_NO"
compwxstd.mo.nb_NO	{0FA88290-30D6-42FA-AF0F-7CF6E5B4679C}	$(MSIBUILD_PRODUCT_NAME_UC)LOCNBNODIR	$(MSIBUILD_COMPONENT_ATTRIB_FILE)		filewxstd.mo.nb_NO
!ENDIF
!IF "$(LANG)" == "nl_NL"
compwxstd.mo.nl_NL	{126CDD88-0F61-41B5-B3E8-77AC18640B29}	$(MSIBUILD_PRODUCT_NAME_UC)LOCNLNLDIR	$(MSIBUILD_COMPONENT_ATTRIB_FILE)		filewxstd.mo.nl_NL
!ENDIF
!IF "$(LANG)" == "pl_PL"
compwxstd.mo.pl_PL	{4E84CF72-3CC8-492B-9CF4-E613B215C154}	$(MSIBUILD_PRODUCT_NAME_UC)LOCPLPLDIR	$(MSIBUILD_COMPONENT_ATTRIB_FILE)		filewxstd.mo.pl_PL
!ENDIF
!IF "$(LANG)" == "pt_PT"
compwxstd.mo.pt_PT	{66672B0A-9A2E-4504-AFFD-106207B4FD6A}	$(MSIBUILD_PRODUCT_NAME_UC)LOCPTPTDIR	$(MSIBUILD_COMPONENT_ATTRIB_FILE)		filewxstd.mo.pt_PT
!ENDIF
!IF "$(LANG)" == "ru_RU"
compwxstd.mo.ru_RU	{83D0E628-566D-457C-925B-0449910235BE}	$(MSIBUILD_PRODUCT_NAME_UC)LOCRURUDIR	$(MSIBUILD_COMPONENT_ATTRIB_FILE)		filewxstd.mo.ru_RU
!ENDIF
!IF "$(LANG)" == "sk_SK"
compwxstd.mo.sk_SK	{B360A234-C99A-4C5A-B3AE-4908B2AEF7F0}	$(MSIBUILD_PRODUCT_NAME_UC)LOCSKSKDIR	$(MSIBUILD_COMPONENT_ATTRIB_FILE)		filewxstd.mo.sk_SK
!ENDIF
!IF "$(LANG)" == "sl_SI"
compwxstd.mo.sl_SI	{55E6434F-3176-486A-AAE5-1BB28ABD6FDA}	$(MSIBUILD_PRODUCT_NAME_UC)LOCSLSIDIR	$(MSIBUILD_COMPONENT_ATTRIB_FILE)		filewxstd.mo.sl_SI
!ENDIF
!IF "$(LANG)" == "sr_RS"
compwxstd.mo.sr_RS	{F5BEFEC3-BD60-4AB1-B74C-6ACBA827D572}	$(MSIBUILD_PRODUCT_NAME_UC)LOCSRRSDIR	$(MSIBUILD_COMPONENT_ATTRIB_FILE)		filewxstd.mo.sr_RS
!ENDIF
!IF "$(LANG)" == "sv_SE"
compwxstd.mo.sv_SE	{FB45E220-1E5A-4967-86B5-81612D38E325}	$(MSIBUILD_PRODUCT_NAME_UC)LOCSVSEDIR	$(MSIBUILD_COMPONENT_ATTRIB_FILE)		filewxstd.mo.sv_SE
!ENDIF
!IF "$(LANG)" == "tr_TR"
compwxstd.mo.tr_TR	{5110DB7C-065E-4088-A215-FC336F549E19}	$(MSIBUILD_PRODUCT_NAME_UC)LOCTRTRDIR	$(MSIBUILD_COMPONENT_ATTRIB_FILE)		filewxstd.mo.tr_TR
!ENDIF
!IF "$(LANG)" == "vi_VN"
compwxstd.mo.vi_VN	{CF3596E8-B1CC-4BD5-9802-5AC0F97F9764}	$(MSIBUILD_PRODUCT_NAME_UC)LOCVIVNDIR	$(MSIBUILD_COMPONENT_ATTRIB_FILE)		filewxstd.mo.vi_VN
!ENDIF
<<NOKEEP


######################################################################
# CustomAction

All :: "$(LANG).$(PLAT).$(CFG).CustomAction-1.idt"

"$(LANG).$(PLAT).$(CFG).CustomAction-1.idt" : "Makefile" "..\..\..\include\MSIBuildCfg.mak"
	-if exist $@ del /f /q $@
	move /y << $@ > NUL
Action	Type	Source	Target
s$(MSIBUILD_LENGTH_ID)	i2	S$(MSIBUILD_LENGTH_ID)	S255
CustomAction	Action
caSet$(MSIBUILD_PRODUCT_NAME_UC)DIR1	35	$(MSIBUILD_PRODUCT_NAME_UC)DIR	[OLD$(MSIBUILD_PRODUCT_NAME_UC)DIR]
caSet$(MSIBUILD_PRODUCT_NAME_UC)DIR2	35	$(MSIBUILD_PRODUCT_NAME_UC)DIR	[INSTALLDIR]
caSetLANGUAGE1	307	LANGUAGE	[LANGREG]
caSetLANGUAGE2	307	LANGUAGE	[LANG]
<<NOKEEP


######################################################################
# Directory

All :: "$(LANG).$(PLAT).$(CFG).Directory-1.idt"

"$(LANG).$(PLAT).$(CFG).Directory-1.idt" : "Makefile" "..\..\..\include\MSIBuildCfg.mak"
	-if exist $@ del /f /q $@
	move /y << $@ > NUL
Directory	Directory_Parent	DefaultDir
s$(MSIBUILD_LENGTH_ID)	S$(MSIBUILD_LENGTH_ID)	l255
Directory	Directory
TARGETDIR		SourceDir
ProgramFilesFolder	TARGETDIR	.
!IF "$(PLAT)" == "x64" || "$(PLAT)" == "ARM64"
ProgramFiles64Folder	TARGETDIR	.
PROGRAMFILESDIR	ProgramFiles64Folder	.
!ELSE
PROGRAMFILESDIR	ProgramFilesFolder	.
!ENDIF
ProgramMenuFolder	TARGETDIR	.
$(MSIBUILD_PRODUCT_NAME_ID)ShortcutDir	ProgramMenuFolder	$(MSIBUILD_PRODUCT_NAME_8_3)|$(MSIBUILD_PRODUCT_NAME):.
$(MSIBUILD_PRODUCT_NAME_UC)DIR	PROGRAMFILESDIR	$(MSIBUILD_PRODUCT_NAME_8_3)|$(MSIBUILD_PRODUCT_NAME):.
!IF     "$(PLAT)" == "Win32" && "$(CFG)" == "Debug"
$(MSIBUILD_PRODUCT_NAME_UC)BINDIR	$(MSIBUILD_PRODUCT_NAME_UC)DIR	.:WIN32~1.DEB|Win32.Debug
!ELSEIF "$(PLAT)" == "Win32" && "$(CFG)" == "Release"
$(MSIBUILD_PRODUCT_NAME_UC)BINDIR	$(MSIBUILD_PRODUCT_NAME_UC)DIR	.:WIN32~1.REL|Win32.Release
!ELSEIF "$(PLAT)" == "x64"   && "$(CFG)" == "Debug"
$(MSIBUILD_PRODUCT_NAME_UC)BINDIR	$(MSIBUILD_PRODUCT_NAME_UC)DIR	.:X64~1.DEB|x64.Debug
!ELSEIF "$(PLAT)" == "x64"   && "$(CFG)" == "Release"
$(MSIBUILD_PRODUCT_NAME_UC)BINDIR	$(MSIBUILD_PRODUCT_NAME_UC)DIR	.:X64~1.REL|x64.Release
!ELSEIF "$(PLAT)" == "ARM64"   && "$(CFG)" == "Debug"
$(MSIBUILD_PRODUCT_NAME_UC)BINDIR	$(MSIBUILD_PRODUCT_NAME_UC)DIR	.:ARM64~1.DEB|ARM64.Debug
!ELSEIF "$(PLAT)" == "ARM64"   && "$(CFG)" == "Release"
$(MSIBUILD_PRODUCT_NAME_UC)BINDIR	$(MSIBUILD_PRODUCT_NAME_UC)DIR	.:ARM64~1.REL|ARM64.Release
!ENDIF
$(MSIBUILD_PRODUCT_NAME_UC)LOCDIR	$(MSIBUILD_PRODUCT_NAME_UC)DIR	locale
!IF "$(LANG)" == "bg_BG"
$(MSIBUILD_PRODUCT_NAME_UC)LOCBGBGDIR	$(MSIBUILD_PRODUCT_NAME_UC)LOCDIR	bg_BG
!ENDIF
!IF "$(LANG)" == "ca_ES"
$(MSIBUILD_PRODUCT_NAME_UC)LOCCAESDIR	$(MSIBUILD_PRODUCT_NAME_UC)LOCDIR	ca_ES
!ENDIF
!IF "$(LANG)" == "cs_CZ"
$(MSIBUILD_PRODUCT_NAME_UC)LOCCSCZDIR	$(MSIBUILD_PRODUCT_NAME_UC)LOCDIR	cs_CZ
!ENDIF
!IF "$(LANG)" == "cy_UK"
$(MSIBUILD_PRODUCT_NAME_UC)LOCCYUKDIR	$(MSIBUILD_PRODUCT_NAME_UC)LOCDIR	cy_UK
!ENDIF
!IF "$(LANG)" == "de_DE"
$(MSIBUILD_PRODUCT_NAME_UC)LOCDEDEDIR	$(MSIBUILD_PRODUCT_NAME_UC)LOCDIR	de_DE
!ENDIF
!IF "$(LANG)" == "el_GR"
$(MSIBUILD_PRODUCT_NAME_UC)LOCELGRDIR	$(MSIBUILD_PRODUCT_NAME_UC)LOCDIR	el_GR
!ENDIF
!IF "$(LANG)" == "es_ES"
$(MSIBUILD_PRODUCT_NAME_UC)LOCESESDIR	$(MSIBUILD_PRODUCT_NAME_UC)LOCDIR	es_ES
!ENDIF
!IF "$(LANG)" == "et_EE"
$(MSIBUILD_PRODUCT_NAME_UC)LOCETEEDIR	$(MSIBUILD_PRODUCT_NAME_UC)LOCDIR	et_EE
!ENDIF
!IF "$(LANG)" == "eu_ES"
$(MSIBUILD_PRODUCT_NAME_UC)LOCEUESDIR	$(MSIBUILD_PRODUCT_NAME_UC)LOCDIR	eu_ES
!ENDIF
!IF "$(LANG)" == "fi_FI"
$(MSIBUILD_PRODUCT_NAME_UC)LOCFIFIDIR	$(MSIBUILD_PRODUCT_NAME_UC)LOCDIR	fi_FI
!ENDIF
!IF "$(LANG)" == "fr_CA"
$(MSIBUILD_PRODUCT_NAME_UC)LOCFRCADIR	$(MSIBUILD_PRODUCT_NAME_UC)LOCDIR	fr_CA
!ENDIF
!IF "$(LANG)" == "fr_FR"
$(MSIBUILD_PRODUCT_NAME_UC)LOCFRFRDIR	$(MSIBUILD_PRODUCT_NAME_UC)LOCDIR	fr_FR
!ENDIF
!IF "$(LANG)" == "gl_ES"
$(MSIBUILD_PRODUCT_NAME_UC)LOCGLESDIR	$(MSIBUILD_PRODUCT_NAME_UC)LOCDIR	gl_ES
!ENDIF
!IF "$(LANG)" == "hr_HR"
$(MSIBUILD_PRODUCT_NAME_UC)LOCHRHRDIR	$(MSIBUILD_PRODUCT_NAME_UC)LOCDIR	hr_HR
!ENDIF
!IF "$(LANG)" == "hu_HU"
$(MSIBUILD_PRODUCT_NAME_UC)LOCHUHUDIR	$(MSIBUILD_PRODUCT_NAME_UC)LOCDIR	hu_HU
!ENDIF
!IF "$(LANG)" == "is_IS"
$(MSIBUILD_PRODUCT_NAME_UC)LOCISISDIR	$(MSIBUILD_PRODUCT_NAME_UC)LOCDIR	is_IS
!ENDIF
!IF "$(LANG)" == "it_IT"
$(MSIBUILD_PRODUCT_NAME_UC)LOCITITDIR	$(MSIBUILD_PRODUCT_NAME_UC)LOCDIR	it_IT
!ENDIF
!IF "$(LANG)" == "ko_KR"
$(MSIBUILD_PRODUCT_NAME_UC)LOCKOKRDIR	$(MSIBUILD_PRODUCT_NAME_UC)LOCDIR	ko_KR
!ENDIF
!IF "$(LANG)" == "lt_LT"
$(MSIBUILD_PRODUCT_NAME_UC)LOCLTLTDIR	$(MSIBUILD_PRODUCT_NAME_UC)LOCDIR	lt_LT
!ENDIF
!IF "$(LANG)" == "nb_NO"
$(MSIBUILD_PRODUCT_NAME_UC)LOCNBNODIR	$(MSIBUILD_PRODUCT_NAME_UC)LOCDIR	nb_NO
!ENDIF
!IF "$(LANG)" == "nl_NL"
$(MSIBUILD_PRODUCT_NAME_UC)LOCNLNLDIR	$(MSIBUILD_PRODUCT_NAME_UC)LOCDIR	nl_NL
!ENDIF
!IF "$(LANG)" == "pl_PL"
$(MSIBUILD_PRODUCT_NAME_UC)LOCPLPLDIR	$(MSIBUILD_PRODUCT_NAME_UC)LOCDIR	pl_PL
!ENDIF
!IF "$(LANG)" == "pt_PT"
$(MSIBUILD_PRODUCT_NAME_UC)LOCPTPTDIR	$(MSIBUILD_PRODUCT_NAME_UC)LOCDIR	pt_PT
!ENDIF
!IF "$(LANG)" == "ru_RU"
$(MSIBUILD_PRODUCT_NAME_UC)LOCRURUDIR	$(MSIBUILD_PRODUCT_NAME_UC)LOCDIR	ru_RU
!ENDIF
!IF "$(LANG)" == "sk_SK"
$(MSIBUILD_PRODUCT_NAME_UC)LOCSKSKDIR	$(MSIBUILD_PRODUCT_NAME_UC)LOCDIR	sk_SK
!ENDIF
!IF "$(LANG)" == "sl_SI"
$(MSIBUILD_PRODUCT_NAME_UC)LOCSLSIDIR	$(MSIBUILD_PRODUCT_NAME_UC)LOCDIR	sl_SI
!ENDIF
!IF "$(LANG)" == "sr_RS"
$(MSIBUILD_PRODUCT_NAME_UC)LOCSRRSDIR	$(MSIBUILD_PRODUCT_NAME_UC)LOCDIR	sr_RS
!ENDIF
!IF "$(LANG)" == "sv_SE"
$(MSIBUILD_PRODUCT_NAME_UC)LOCSVSEDIR	$(MSIBUILD_PRODUCT_NAME_UC)LOCDIR	sv_SE
!ENDIF
!IF "$(LANG)" == "tr_TR"
$(MSIBUILD_PRODUCT_NAME_UC)LOCTRTRDIR	$(MSIBUILD_PRODUCT_NAME_UC)LOCDIR	tr_TR
!ENDIF
!IF "$(LANG)" == "vi_VN"
$(MSIBUILD_PRODUCT_NAME_UC)LOCVIVNDIR	$(MSIBUILD_PRODUCT_NAME_UC)LOCDIR	vi_VN
!ENDIF
<<NOKEEP


######################################################################
# File

All :: "$(LANG).$(PLAT).$(CFG).File-1.idt"

"$(LANG).$(PLAT).$(CFG).File-1.idt" : "Makefile" "..\..\..\include\MSIBuildCfg.mak"
	-if exist $@ del /f /q $@
	move /y << $@ > NUL
File	Component_	FileName	FileSize	Version	Language	Attributes	Sequence
s$(MSIBUILD_LENGTH_ID)	s$(MSIBUILD_LENGTH_ID)	l255	i4	S$(MSIBUILD_LENGTH_ID)	S20	I2	i2
File	File
!IF "$(LANG)" != "en_US"
filewxstd.mo.$(LANG)	compwxstd.mo.$(LANG)	wxstd.mo	0		$(MSIBUILD_LANGID)	0	1
!ENDIF
<<NOKEEP


######################################################################
# Icon

All :: \
	"$(LANG).$(PLAT).$(CFG).Icon-1.idt" \
	"$(LANG).$(PLAT).$(CFG).Icon-1\product.ico"

"$(LANG).$(PLAT).$(CFG).Icon-1.idt" : "Makefile" "..\..\..\include\MSIBuildCfg.mak" "$(LANG).$(PLAT).$(CFG).Icon-1"
	-if exist $@ del /f /q $@
	move /y << $@ > NUL
Name	Data
s$(MSIBUILD_LENGTH_ID)	v0
Icon	Name
iconproduct.ico	product.ico
<<NOKEEP

"$(LANG).$(PLAT).$(CFG).Icon-1\product.ico" : "..\..\..\include\icon_full.ico"
	copy /y $** $@ > NUL


######################################################################
# InstallExecuteSequence

All :: "$(LANG).$(PLAT).$(CFG).InstallExecuteSequence-1.idt"

"$(LANG).$(PLAT).$(CFG).InstallExecuteSequence-1.idt" : "Makefile" "..\..\..\include\MSIBuildCfg.mak"
	-if exist $@ del /f /q $@
	move /y << $@ > NUL
Action	Condition	Sequence
s$(MSIBUILD_LENGTH_ID)	S255	I2
InstallExecuteSequence	Action
caSetLANGUAGE1	LANGREG	653
caSetLANGUAGE2	LANG	654
caSet$(MSIBUILD_PRODUCT_NAME_UC)DIR1	OLD$(MSIBUILD_PRODUCT_NAME_UC)DIR AND UILevel < 4	1001
caSet$(MSIBUILD_PRODUCT_NAME_UC)DIR2	INSTALLDIR AND UILevel < 4	1002
<<NOKEEP


######################################################################
# LaunchCondition

All :: "$(LANG).$(PLAT).$(CFG).LaunchCondition-2.idt"

"en_US.$(PLAT).$(CFG).LaunchCondition-2.idtx" : "Makefile" "..\..\..\include\MSIBuildCfg.mak"
	-if exist $@ del /f /q $@
	move /y << $@ > NUL
Condition	Description
s255	l255
LaunchCondition	Condition
VersionNT >= "600"	[ProductName] requires Windows Vista or later version of Windows.
<<NOKEEP

!IF "$(LANG)" == "en_US"
"en_US.$(PLAT).$(CFG).LaunchCondition-2.idt" : "en_US.$(PLAT).$(CFG).LaunchCondition-2.idtx"
	copy /y $** $@ > NUL
!ELSE
"$(LANG).$(PLAT).$(CFG).LaunchCondition-2.idt" : "en_US.$(PLAT).$(CFG).LaunchCondition-2.idtx" "..\locale\$(LANG).po"
	cscript.exe "..\..\MSIBuild\MSI.wsf" //Job:IDTTranslate //Nologo $@ $** /CP:$(MSIBUILD_CODEPAGE)
!ENDIF


######################################################################
# Media

All :: "$(LANG).$(PLAT).$(CFG).Media-1.idt"

"$(LANG).$(PLAT).$(CFG).Media-1.idt" : "Makefile" "..\..\..\include\MSIBuildCfg.mak"
	-if exist $@ del /f /q $@
	move /y << $@ > NUL
DiskId	LastSequence	DiskPrompt	Cabinet	VolumeLabel	Source
i2	i2	L64	S255	S32	S$(MSIBUILD_LENGTH_ID)
Media	DiskId
1	1	[ProductName]		$(MSIBUILD_PRODUCT_NAME_UC)	
<<NOKEEP


######################################################################
# Property

All :: \
	"$(LANG).$(PLAT).$(CFG).Property-1.idt" \
	"$(LANG).$(PLAT).$(CFG).Property-2.idt"

"$(LANG).$(PLAT).$(CFG).Property-1.idt" : "Makefile" "..\..\..\include\MSIBuildCfg.mak"
	-if exist $@ del /f /q $@
	move /y << $@ > NUL
Property	Value
s$(MSIBUILD_LENGTH_ID)	l0
Property	Property
ARPPRODUCTICON	iconproduct.ico
ALLUSERS	1
DISABLEADVTSHORTCUTS	1
INSTALLLEVEL	3
InstallMode	Typical
SecureCustomProperties	OLDPRODUCTFOUND;NEWPRODUCTFOUND;LANG
LANGUAGE	$(LANG)
<<NOKEEP

"en_US.$(PLAT).$(CFG).Property-2.idtx" : "Makefile" "..\..\..\include\MSIBuildCfg.mak"
	-if exist $@ del /f /q $@
	move /y << $@ > NUL
Property	Value
s$(MSIBUILD_LENGTH_ID)	l0
1252	Property	Property
ARPURLINFOABOUT	http://www.geant.org/
ARPHELPLINK	http://www.geant.org/
ARPURLUPDATEINFO	https://github.com/Amebis/GEANTLink/releases
<<NOKEEP

!IF "$(LANG)" == "en_US"
"en_US.$(PLAT).$(CFG).Property-2.idt" : "en_US.$(PLAT).$(CFG).Property-2.idtx"
	copy /y $** $@ > NUL
!ELSE
"$(LANG).$(PLAT).$(CFG).Property-2.idt" : "en_US.$(PLAT).$(CFG).Property-2.idtx" "..\locale\$(LANG).po"
	cscript.exe "..\..\MSIBuild\MSI.wsf" //Job:IDTTranslate //Nologo $@ $** /CP:$(MSIBUILD_CODEPAGE)
!ENDIF


######################################################################
# Registry

All :: "$(LANG).$(PLAT).$(CFG).Registry-1.idt"

"$(LANG).$(PLAT).$(CFG).Registry-1.idt" : "Makefile" "..\..\..\include\MSIBuildCfg.mak"
	-if exist $@ del /f /q $@
	move /y << $@ > NUL
Registry	Root	Key	Name	Value	Component_
s$(MSIBUILD_LENGTH_ID)	i2	l255	L255	L0	s$(MSIBUILD_LENGTH_ID)
Registry	Registry
regLocalizationRepositoryPath	2	SOFTWARE\$(MSIBUILD_VENDOR_NAME)\$(MSIBUILD_PRODUCT_NAME)	LocalizationRepositoryPath	[$(MSIBUILD_PRODUCT_NAME_UC)LOCDIR]	compLocalizationRepositoryPath
regLanguage	2	SOFTWARE\$(MSIBUILD_VENDOR_NAME)\$(MSIBUILD_PRODUCT_NAME)	Language	[LANGUAGE]	compLanguage
<<NOKEEP


######################################################################
# RegLocator

All :: "$(LANG).$(PLAT).$(CFG).RegLocator-1.idt"

"$(LANG).$(PLAT).$(CFG).RegLocator-1.idt" : "Makefile" "..\..\..\include\MSIBuildCfg.mak"
	-if exist $@ del /f /q $@
	move /y << $@ > NUL
Signature_	Root	Key	Name	Type
s$(MSIBUILD_LENGTH_ID)	i2	s255	S255	I2
RegLocator	Signature_
rlLanguage.Win32	2	SOFTWARE\$(MSIBUILD_VENDOR_NAME)\$(MSIBUILD_PRODUCT_NAME)	Language	2
!IF "$(PLAT)" == "x64" || "$(PLAT)" == "ARM64"
rlLanguage.$(PLAT)	2	SOFTWARE\$(MSIBUILD_VENDOR_NAME)\$(MSIBUILD_PRODUCT_NAME)	Language	18
!ENDIF
<<NOKEEP


######################################################################
# Build MSM module!
######################################################################

!INCLUDE "..\..\MSIBuild\MSM.mak"
