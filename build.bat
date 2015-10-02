SET MSBuild="C:\Windows\Microsoft.NET\Framework\v4.0.30319\MSBuild.exe"
CALL "C:\Program Files (x86)\Embarcadero\Studio\14.0\bin\rsvars.bat"

SET SEARCH_PATH="Win32\Debug"
SET OUTPUT_PATH="Win32\Debug"

%MSBuild% %1 /t:Build /p:Config=Debug;Platform=Win32;DCC_DcuOutput=%OUTPUT_PATH%;DCC_UnitSearchPath=%SEARCH_PATH%