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

!IFNDEF MSIBUILD_PRODUCT_NAME_UC
!ERROR Parameter MSIBUILD_PRODUCT_NAME_UC is undefined.
!ENDIF


######################################################################
# AppSearch

All :: "$(LANG).$(PLAT).$(CFG).AppSearch-1.idt"

"$(LANG).$(PLAT).$(CFG).AppSearch-1.idt" : "Makefile" "..\..\..\include\MSIBuildCfg.mak"
	-if exist $@ del /f /q $@
	move /y << $@ > NUL
Property	Signature_
s$(MSIBUILD_LENGTH_ID)	s$(MSIBUILD_LENGTH_ID)
AppSearch	Property	Signature_
OLD$(MSIBUILD_PRODUCT_NAME_UC)DIR	clEvents.dll.$(PLAT)
<<NOKEEP


######################################################################
# CompLocator

All :: "$(LANG).$(PLAT).$(CFG).CompLocator-1.idt"

"$(LANG).$(PLAT).$(CFG).CompLocator-1.idt" : "Makefile" "..\..\..\include\MSIBuildCfg.mak"
	-if exist $@ del /f /q $@
	move /y << $@ > NUL
Signature_	ComponentId	Type
s$(MSIBUILD_LENGTH_ID)	s38	I2
CompLocator	Signature_
!IF "$(PLAT)" == "Win32"
clEvents.dll.Win32	{E691777F-2A7F-4E8D-9B0A-499075499649}	1
!ENDIF
!IF "$(PLAT)" == "x64"
clEvents.dll.x64	{F5ACC467-0AE2-48B4-B1AB-0B87E96AE737}	1
!ENDIF
!IF "$(PLAT)" == "ARM64"
clEvents.dll.ARM64	{F69C678D-08CB-49D6-A510-CBF8DFAAB3E1}	1
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
!IF "$(PLAT)" == "Win32"
compEvents.dll.Win32	{E691777F-2A7F-4E8D-9B0A-499075499649}	$(MSIBUILD_PRODUCT_NAME_UC)BINDIR	0		fileEvents.dll.Win32
!ENDIF
!IF "$(PLAT)" == "x64"
compEvents.dll.x64	{F5ACC467-0AE2-48B4-B1AB-0B87E96AE737}	$(MSIBUILD_PRODUCT_NAME_UC)BINDIR	256		fileEvents.dll.x64
!ENDIF
!IF "$(PLAT)" == "ARM64"
compEvents.dll.ARM64	{F69C678D-08CB-49D6-A510-CBF8DFAAB3E1}	$(MSIBUILD_PRODUCT_NAME_UC)BINDIR	256		fileEvents.dll.ARM64
!ENDIF
compEventsPublisher1	{CE799218-FEF2-4584-80D1-751BEAECC4F3}	$(MSIBUILD_PRODUCT_NAME_UC)BINDIR	$(MSIBUILD_COMPONENT_ATTRIB_REGISTRY)		regEventsPublisher1
compEventsPublisher2	{CE8D096D-54A9-4F6C-8B2B-BCE8253126DC}	$(MSIBUILD_PRODUCT_NAME_UC)BINDIR	$(MSIBUILD_COMPONENT_ATTRIB_REGISTRY)		regEventsPublisher2
compEventsPublisher3	{68706D4D-4AD5-48E0-9C23-EE351E9A6FAA}	$(MSIBUILD_PRODUCT_NAME_UC)BINDIR	$(MSIBUILD_COMPONENT_ATTRIB_REGISTRY)		regEventsPublisher3
compEventsPublisher4	{5BBBA8F8-9626-4724-8984-67FA71AB27AD}	$(MSIBUILD_PRODUCT_NAME_UC)BINDIR	$(MSIBUILD_COMPONENT_ATTRIB_REGISTRY)		regEventsPublisher4
compEventsPublisherChannels	{2FAE195A-A849-4418-B204-0CFBB13A4A2F}	$(MSIBUILD_PRODUCT_NAME_UC)BINDIR	$(MSIBUILD_COMPONENT_ATTRIB_REGISTRY)		regEventsPublisherChannels
compEventsPublisherChOperational1	{97682862-F40F-4467-B465-DF31C65066FE}	$(MSIBUILD_PRODUCT_NAME_UC)BINDIR	$(MSIBUILD_COMPONENT_ATTRIB_REGISTRY)		regEventsPublisherChOperational1
compEventsPublisherChOperational2	{7730A832-F127-4FF1-A5D6-8477362194D7}	$(MSIBUILD_PRODUCT_NAME_UC)BINDIR	$(MSIBUILD_COMPONENT_ATTRIB_REGISTRY)		regEventsPublisherChOperational2
compEventsPublisherChOperational3	{D45E16AF-B757-4B1A-AB4E-E4715835E494}	$(MSIBUILD_PRODUCT_NAME_UC)BINDIR	$(MSIBUILD_COMPONENT_ATTRIB_REGISTRY)		regEventsPublisherChOperational3
compEventsPublisherChAnalytic1	{B121EA86-4ECD-42C8-B45E-30BEFC307F17}	$(MSIBUILD_PRODUCT_NAME_UC)BINDIR	$(MSIBUILD_COMPONENT_ATTRIB_REGISTRY)		regEventsPublisherChAnalytic1
compEventsPublisherChAnalytic2	{7B9CD9CD-CB21-47A7-97AC-FD297E5BA124}	$(MSIBUILD_PRODUCT_NAME_UC)BINDIR	$(MSIBUILD_COMPONENT_ATTRIB_REGISTRY)		regEventsPublisherChAnalytic2
compEventsPublisherChAnalytic3	{5BC46780-D624-42C4-86C5-0D482B5F7E00}	$(MSIBUILD_PRODUCT_NAME_UC)BINDIR	$(MSIBUILD_COMPONENT_ATTRIB_REGISTRY)		regEventsPublisherChAnalytic3
compEventsChannelOperational1	{7AC2960D-98B0-40E4-A3D9-322C0E4F1CC4}	$(MSIBUILD_PRODUCT_NAME_UC)BINDIR	$(MSIBUILD_COMPONENT_ATTRIB_REGISTRY)		regEventsChannelOperational1
compEventsChannelOperational2	{CA329351-555F-4A1A-9F6E-A358097020EE}	$(MSIBUILD_PRODUCT_NAME_UC)BINDIR	$(MSIBUILD_COMPONENT_ATTRIB_REGISTRY)		regEventsChannelOperational2
compEventsChannelOperational3	{2CA50F50-8D01-4B15-9FF4-411A3D0A8254}	$(MSIBUILD_PRODUCT_NAME_UC)BINDIR	$(MSIBUILD_COMPONENT_ATTRIB_REGISTRY)		regEventsChannelOperational3
compEventsChannelOperational4	{762EE4E5-9359-47E2-B21A-B142746A3469}	$(MSIBUILD_PRODUCT_NAME_UC)BINDIR	$(MSIBUILD_COMPONENT_ATTRIB_REGISTRY)		regEventsChannelOperational4
compEventsChannelOperational5	{4B0D9C46-AFB9-4E1F-B1FA-8061A9F9EED0}	$(MSIBUILD_PRODUCT_NAME_UC)BINDIR	$(MSIBUILD_COMPONENT_ATTRIB_REGISTRY)		regEventsChannelOperational5
compEventsChannelOperational6	{E2DC88EA-F603-4131-908E-7C303B3AA654}	$(MSIBUILD_PRODUCT_NAME_UC)BINDIR	$(MSIBUILD_COMPONENT_ATTRIB_REGISTRY)		regEventsChannelOperational6
compEventsChannelOperational7	{86641DCF-34D8-4F3B-A431-0B1365262798}	$(MSIBUILD_PRODUCT_NAME_UC)BINDIR	$(MSIBUILD_COMPONENT_ATTRIB_REGISTRY)		regEventsChannelOperational7
compEventsChannelOperational8	{09B82D13-55DD-4EAB-9E22-D8837B0B43C5}	$(MSIBUILD_PRODUCT_NAME_UC)BINDIR	$(MSIBUILD_COMPONENT_ATTRIB_REGISTRY)		regEventsChannelOperational8
compEventsChannelOperational9	{30625BDC-E125-4F7D-8E32-9F069F456180}	$(MSIBUILD_PRODUCT_NAME_UC)BINDIR	$(MSIBUILD_COMPONENT_ATTRIB_REGISTRY)		regEventsChannelOperational9
compEventsChannelAnalytic1	{4E48CC21-4884-46B2-90B3-F2A4D8267D7A}	$(MSIBUILD_PRODUCT_NAME_UC)BINDIR	$(MSIBUILD_COMPONENT_ATTRIB_REGISTRY)		regEventsChannelAnalytic1
compEventsChannelAnalytic2	{57D027B4-24AD-4541-936A-EC7B2524DFEF}	$(MSIBUILD_PRODUCT_NAME_UC)BINDIR	$(MSIBUILD_COMPONENT_ATTRIB_REGISTRY)		regEventsChannelAnalytic2
compEventsChannelAnalytic3	{52493EEE-9AE8-4947-A04E-2217FB9324B4}	$(MSIBUILD_PRODUCT_NAME_UC)BINDIR	$(MSIBUILD_COMPONENT_ATTRIB_REGISTRY)		regEventsChannelAnalytic3
compEventsChannelAnalytic4	{D25E28CD-111B-45EB-AB92-0B7658839778}	$(MSIBUILD_PRODUCT_NAME_UC)BINDIR	$(MSIBUILD_COMPONENT_ATTRIB_REGISTRY)		regEventsChannelAnalytic4
compEventsChannelAnalytic5	{F617E20D-C5EC-4146-8B72-5111C8CFFB93}	$(MSIBUILD_PRODUCT_NAME_UC)BINDIR	$(MSIBUILD_COMPONENT_ATTRIB_REGISTRY)		regEventsChannelAnalytic5
compEventsChannelAnalytic6	{60FC49D7-D01F-474A-A77E-9A5B613F018F}	$(MSIBUILD_PRODUCT_NAME_UC)BINDIR	$(MSIBUILD_COMPONENT_ATTRIB_REGISTRY)		regEventsChannelAnalytic6
compEventsChannelAnalytic7	{A8FE5C92-7CB9-4AEE-962E-28DA428C91FE}	$(MSIBUILD_PRODUCT_NAME_UC)BINDIR	$(MSIBUILD_COMPONENT_ATTRIB_REGISTRY)		regEventsChannelAnalytic7
compEventsChannelAnalytic8	{7DD8FC55-496F-420B-983E-199FA3969539}	$(MSIBUILD_PRODUCT_NAME_UC)BINDIR	$(MSIBUILD_COMPONENT_ATTRIB_REGISTRY)		regEventsChannelAnalytic8
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
fileEvents.dll.$(PLAT)	compEvents.dll.$(PLAT)	EAPMET~1.DLL|Events.dll	0		0	1536	1
<<NOKEEP


######################################################################
# Registry

All :: "$(LANG).$(PLAT).$(CFG).Registry-1.idt"

"$(LANG).$(PLAT).$(CFG).Registry-1.idt" : "Makefile" "..\..\..\include\MSIBuildCfg.mak"
	-if exist $@ del /f /q $@
	move /y << $@ > NUL
Registry	Root	Key	Name	Value	Component_
s$(MSIBUILD_LENGTH_ID)	i2	l255	L255	L0	s$(MSIBUILD_LENGTH_ID)
Registry	Registry
regEventsPublisher1	2	SOFTWARE\Microsoft\Windows\CurrentVersion\WINEVT\Publishers\{3f65af01-ce8f-4c7d-990b-673b244aac7b}		$(MSIBUILD_VENDOR_NAME)-$(MSIBUILD_PRODUCT_NAME)-EAPMethod	compEventsPublisher1
regEventsPublisher2	2	SOFTWARE\Microsoft\Windows\CurrentVersion\WINEVT\Publishers\{3f65af01-ce8f-4c7d-990b-673b244aac7b}	MessageFileName	[$(MSIBUILD_PRODUCT_NAME_UC)BINDIR]Events.dll	compEventsPublisher2
regEventsPublisher3	2	SOFTWARE\Microsoft\Windows\CurrentVersion\WINEVT\Publishers\{3f65af01-ce8f-4c7d-990b-673b244aac7b}	ResourceFileName	[$(MSIBUILD_PRODUCT_NAME_UC)BINDIR]Events.dll	compEventsPublisher3
regEventsPublisher4	2	SOFTWARE\Microsoft\Windows\CurrentVersion\WINEVT\Publishers\{3f65af01-ce8f-4c7d-990b-673b244aac7b}	Enabled	#1	compEventsPublisher4
regEventsPublisherChannels	2	SOFTWARE\Microsoft\Windows\CurrentVersion\WINEVT\Publishers\{3f65af01-ce8f-4c7d-990b-673b244aac7b}\ChannelReferences	Count	#2	compEventsPublisherChannels
regEventsPublisherChOperational1	2	SOFTWARE\Microsoft\Windows\CurrentVersion\WINEVT\Publishers\{3f65af01-ce8f-4c7d-990b-673b244aac7b}\ChannelReferences\0		$(MSIBUILD_VENDOR_NAME)-$(MSIBUILD_PRODUCT_NAME)-EAPMethod/Operational	compEventsPublisherChOperational1
regEventsPublisherChOperational2	2	SOFTWARE\Microsoft\Windows\CurrentVersion\WINEVT\Publishers\{3f65af01-ce8f-4c7d-990b-673b244aac7b}\ChannelReferences\0	Id	#16	compEventsPublisherChOperational2
regEventsPublisherChOperational3	2	SOFTWARE\Microsoft\Windows\CurrentVersion\WINEVT\Publishers\{3f65af01-ce8f-4c7d-990b-673b244aac7b}\ChannelReferences\0	Flags	#0	compEventsPublisherChOperational3
regEventsPublisherChAnalytic1	2	SOFTWARE\Microsoft\Windows\CurrentVersion\WINEVT\Publishers\{3f65af01-ce8f-4c7d-990b-673b244aac7b}\ChannelReferences\1		$(MSIBUILD_VENDOR_NAME)-$(MSIBUILD_PRODUCT_NAME)-EAPMethod/Analytic	compEventsPublisherChAnalytic1
regEventsPublisherChAnalytic2	2	SOFTWARE\Microsoft\Windows\CurrentVersion\WINEVT\Publishers\{3f65af01-ce8f-4c7d-990b-673b244aac7b}\ChannelReferences\1	Id	#17	compEventsPublisherChAnalytic2
regEventsPublisherChAnalytic3	2	SOFTWARE\Microsoft\Windows\CurrentVersion\WINEVT\Publishers\{3f65af01-ce8f-4c7d-990b-673b244aac7b}\ChannelReferences\1	Flags	#0	compEventsPublisherChAnalytic3
regEventsChannelOperational1	2	SOFTWARE\Microsoft\Windows\CurrentVersion\WINEVT\Channels\$(MSIBUILD_VENDOR_NAME)-$(MSIBUILD_PRODUCT_NAME)-EAPMethod/Operational	OwningPublisher	{3f65af01-ce8f-4c7d-990b-673b244aac7b}	compEventsChannelOperational1
regEventsChannelOperational2	2	SOFTWARE\Microsoft\Windows\CurrentVersion\WINEVT\Channels\$(MSIBUILD_VENDOR_NAME)-$(MSIBUILD_PRODUCT_NAME)-EAPMethod/Operational	Enabled	#1	compEventsChannelOperational2
regEventsChannelOperational3	2	SOFTWARE\Microsoft\Windows\CurrentVersion\WINEVT\Channels\$(MSIBUILD_VENDOR_NAME)-$(MSIBUILD_PRODUCT_NAME)-EAPMethod/Operational	Isolation	#0	compEventsChannelOperational3
regEventsChannelOperational4	2	SOFTWARE\Microsoft\Windows\CurrentVersion\WINEVT\Channels\$(MSIBUILD_VENDOR_NAME)-$(MSIBUILD_PRODUCT_NAME)-EAPMethod/Operational	ChannelAccess	O:BAG:SYD:(A;;0xf0007;;;SY)(A;;0x7;;;BA)(A;;0x7;;;SO)(A;;0x3;;;IU)(A;;0x3;;;SU)(A;;0x3;;;S-1-5-3)(A;;0x3;;;S-1-5-33)(A;;0x1;;;S-1-5-32-573)	compEventsChannelOperational4
regEventsChannelOperational5	2	SOFTWARE\Microsoft\Windows\CurrentVersion\WINEVT\Channels\$(MSIBUILD_VENDOR_NAME)-$(MSIBUILD_PRODUCT_NAME)-EAPMethod/Operational	MaxSize	#1048576	compEventsChannelOperational5
regEventsChannelOperational6	2	SOFTWARE\Microsoft\Windows\CurrentVersion\WINEVT\Channels\$(MSIBUILD_VENDOR_NAME)-$(MSIBUILD_PRODUCT_NAME)-EAPMethod/Operational	MaxSizeUpper	#0	compEventsChannelOperational6
regEventsChannelOperational7	2	SOFTWARE\Microsoft\Windows\CurrentVersion\WINEVT\Channels\$(MSIBUILD_VENDOR_NAME)-$(MSIBUILD_PRODUCT_NAME)-EAPMethod/Operational	Retention	#0	compEventsChannelOperational7
regEventsChannelOperational8	2	SOFTWARE\Microsoft\Windows\CurrentVersion\WINEVT\Channels\$(MSIBUILD_VENDOR_NAME)-$(MSIBUILD_PRODUCT_NAME)-EAPMethod/Operational	Type	#1	compEventsChannelOperational8
regEventsChannelOperational9	2	SOFTWARE\Microsoft\Windows\CurrentVersion\WINEVT\Channels\$(MSIBUILD_VENDOR_NAME)-$(MSIBUILD_PRODUCT_NAME)-EAPMethod/Operational	AutoBackupLogFiles	#0	compEventsChannelOperational9
regEventsChannelAnalytic1	2	SOFTWARE\Microsoft\Windows\CurrentVersion\WINEVT\Channels\$(MSIBUILD_VENDOR_NAME)-$(MSIBUILD_PRODUCT_NAME)-EAPMethod/Analytic	OwningPublisher	{3f65af01-ce8f-4c7d-990b-673b244aac7b}	compEventsChannelAnalytic1
regEventsChannelAnalytic2	2	SOFTWARE\Microsoft\Windows\CurrentVersion\WINEVT\Channels\$(MSIBUILD_VENDOR_NAME)-$(MSIBUILD_PRODUCT_NAME)-EAPMethod/Analytic	Enabled	#0	compEventsChannelAnalytic2
regEventsChannelAnalytic3	2	SOFTWARE\Microsoft\Windows\CurrentVersion\WINEVT\Channels\$(MSIBUILD_VENDOR_NAME)-$(MSIBUILD_PRODUCT_NAME)-EAPMethod/Analytic	Isolation	#0	compEventsChannelAnalytic3
regEventsChannelAnalytic4	2	SOFTWARE\Microsoft\Windows\CurrentVersion\WINEVT\Channels\$(MSIBUILD_VENDOR_NAME)-$(MSIBUILD_PRODUCT_NAME)-EAPMethod/Analytic	ChannelAccess	O:BAG:SYD:(A;;0xf0007;;;SY)(A;;0x7;;;BA)(A;;0x7;;;SO)(A;;0x3;;;IU)(A;;0x3;;;SU)(A;;0x3;;;S-1-5-3)(A;;0x3;;;S-1-5-33)(A;;0x1;;;S-1-5-32-573)	compEventsChannelAnalytic4
regEventsChannelAnalytic5	2	SOFTWARE\Microsoft\Windows\CurrentVersion\WINEVT\Channels\$(MSIBUILD_VENDOR_NAME)-$(MSIBUILD_PRODUCT_NAME)-EAPMethod/Analytic	MaxSize	#1048576	compEventsChannelAnalytic5
regEventsChannelAnalytic6	2	SOFTWARE\Microsoft\Windows\CurrentVersion\WINEVT\Channels\$(MSIBUILD_VENDOR_NAME)-$(MSIBUILD_PRODUCT_NAME)-EAPMethod/Analytic	MaxSizeUpper	#0	compEventsChannelAnalytic6
regEventsChannelAnalytic7	2	SOFTWARE\Microsoft\Windows\CurrentVersion\WINEVT\Channels\$(MSIBUILD_VENDOR_NAME)-$(MSIBUILD_PRODUCT_NAME)-EAPMethod/Analytic	Retention	#4294967295	compEventsChannelAnalytic7
regEventsChannelAnalytic8	2	SOFTWARE\Microsoft\Windows\CurrentVersion\WINEVT\Channels\$(MSIBUILD_VENDOR_NAME)-$(MSIBUILD_PRODUCT_NAME)-EAPMethod/Analytic	Type	#2	compEventsChannelAnalytic8
<<NOKEEP


######################################################################
# Build MSM module!
######################################################################

!INCLUDE "..\..\..\MSI\MSIBuild\MSM.mak"
