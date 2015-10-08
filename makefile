#
# Makefile, build delphi project
#
Platform=Win32
Config=Release

CC="C:\Program Files (x86)\Embarcadero\Studio\14.0\bin\dcc32"
RC=rc

COMPDIR = -$O+
OUTPUTDIR = -LE.\$(Platform)\$(Config)  -E.\$(Platform)\$(Config)
PATHS = -I.\3rd-party-libs -O.\3rd-party-libs -R.\3rd-party-libs -U.\3rd-party-libs;.\$(Platform)\$(Config)

DFLAGS = $(COMPDIR) -DRELEASE -M -NSSystem;vlc;Winapi $(OUTPUTDIR) $(PATHS)

MyBasicApp.exe: MyBasicApp.dpr MyPackageTester.bpl MyBasicPackage.bpl
	$(CC) $(DFLAGS) -LUMyPackageTester;MyBasicPackage;Spring.Core MyBasicApp.dpr
	
MyPackageTester.bpl: MyPackageTester.dpk MyBasicPackage.bpl
	$(CC) $(DFLAGS) -LUMyBasicPackage;Spring.Core MyPackageTester.dpk

MyBasicPackage.bpl: MyBasicPackage.dpk 
	$(CC) $(DFLAGS) -LUSpring.Core MyBasicPackage.dpk