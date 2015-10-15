stage 'build'
node {
  bat 'rmdir /s /q 3rd-party'
  git url: 'https://github.com/graguirre/DelphiDepencyExample.git'
  dir('3rd-party/DUnitX'){
    git url: 'https://github.com/VSoftTechnologies/DUnitX'
  }
  dir('3rd-party/Spring4d'){
    checkout([$class: 'GitSCM',
    branches: [[name: '*/master']],
    doGenerateSubmoduleConfigurations: false,
    extensions: [[$class: 'SparseCheckoutPaths',
    sparseCheckoutPaths: [[path: 'Source/Base'], [path: 'Source/Core'], [path: 'Source/Extensions'], [path: 'Packages/DelphiXE6']]]],
    submoduleCfg: [],
    userRemoteConfigs: [[url: 'https://bitbucket.org/sglienke/spring4d.git']]])
  }
  dir('3rd-party/Spring4d/Packages/DelphiXE6') {
    bat 'call "C:\\Program Files (x86)\\Embarcadero\\Studio\\14.0\\bin\\rsvars.bat" && msbuild /t:build /p:config=Release;Platform=Win32;DCC_BplOutput=..\\..\\..\\libs;DCC_DcpOutput=..\\..\\..\\libs Spring.Base.dproj && msbuild /t:build /p:config=Release;Platform=Win32;DCC_BplOutput=..\\..\\..\\libs;DCC_DcpOutput=..\\..\\..\\libs Spring.Core.dproj'
  }
  bat 'dir 3rd-party\\libs'
  bat 'call "C:\\Program Files (x86)\\Embarcadero\\Studio\\14.0\\bin\\rsvars.bat" &&
  msbuild /t:build /p:config=Release;Platform=Win32 MyBasicPackage.dproj &&
  msbuild /t:build /p:config=Release;Platform=Win32 MyPackageTester.dproj &&
  msbuild /t:build /p:config=Release;Platform=Win32 MyBasicApp.dproj'
}
