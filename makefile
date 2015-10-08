#
# Makefile, build delphi project
#

CC="C:\Program Files (x86)\Embarcadero\Studio\14.0\bin\dcc32"
RC=rc

COMPDIR = -$O+
OUTPUTDIR = -LE.\Win32\Release  -E.\Win32\Release
PATH = -I.\3rd-party-libs;"C:\Program Files (x86)\Embarcadero\Studio\14.0\Componentes\spring4d\Source\Base" -O.\3rd-party-libs -R.\3rd-party-libs -U.\3rd-party-libs;.\Win32\Release;"C:\Program Files (x86)\Embarcadero\Studio\14.0\Componentes\spring4d\Source\Core\Container";"C:\Program Files (x86)\Embarcadero\Studio\14.0\Componentes\spring4d\Source\Base";"C:\Program Files (x86)\Embarcadero\Studio\14.0\Componentes\spring4d\Source\Base\Collections";"C:\Program Files (x86)\Embarcadero\Studio\14.0\Componentes\spring4d\Source\Base\Reflection";"C:\Program Files (x86)\Embarcadero\Studio\14.0\Componentes\spring4d\Source\Core\Services"

DFLAGS = $(COMPDIR) -M -NSSystem;vlc;Winapi $(OUTPUTDIR) $(PATH)

MyBasicApp.exe: MyBasicApp.dpr MyPackageTester.bpl MyBasicPackage.bpl
	$(CC) $(DFLAGS) -LUMyPackageTester;MyBasicPackage MyBasicApp.dpr
	
MyPackageTester.bpl: MyPackageTester.dpk MyBasicPackage.bpl
	$(CC) $(DFLAGS) -LUMyBasicPackage MyPackageTester.dpk

MyBasicPackage.bpl: MyBasicPackage.dpk
	$(CC) $(DFLAGS) MyBasicPackage.dpk