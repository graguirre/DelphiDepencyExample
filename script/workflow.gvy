stage 'build'
node ('node-gonzalo'){
  bat 'echo "<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"'
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
  withEnv(['config=Release']) {
    dir('3rd-party/Spring4d/Packages/DelphiXE6') {
      bat 'call "C:\\Program Files (x86)\\Embarcadero\\Studio\\14.0\\bin\\rsvars.bat" && msbuild /t:build /p:config=%config%;Platform=Win32;DCC_BplOutput=..\\..\\..\\libs;DCC_DcpOutput=..\\..\\..\\libs Spring.Base.dproj && msbuild /t:build /p:config=%config%;Platform=Win32;DCC_BplOutput=..\\..\\..\\libs;DCC_DcpOutput=..\\..\\..\\libs Spring.Core.dproj'
    }
    stash includes: '**/*.dcp', name: 'SpringDCP'
    stash includes: '**/*.bpl', name: 'SpringBPL'
  }
}


node ('node-mario'){
  bat 'echo "<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"'
  git url: 'https://github.com/graguirre/DelphiDepencyExample.git'
  unstash 'SpringDCP'
  bat 'dir 3rd-party\\libs'
  withEnv(['config=Release']) {
    bat 'call "C:\\Program Files (x86)\\Embarcadero\\Studio\\14.0\\bin\\rsvars.bat" && msbuild /t:build /p:config=%config%;Platform=Win32 MyBasicPackageR.dproj &&  msbuild /t:build /p:config=%config%;Platform=Win32 MyBasicAppR.dproj'
  unstash 'SpringBPL'
  dir('deploy') {
    bat 'copy ..\\Win32\\%config%\\*.exe .\\'
    bat 'copy ..\\Win32\\%config%\\*.bpl .\\'
    bat 'copy ..\\3rd-party\\libs\\*.bpl .\\'
  }
  }
  stash includes: 'deploy/*', name: 'DeployApp'
}

stage 'deploy'
node('node-gonzalo'){
    bat 'echo "<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"'
    unstash 'DeployApp'
    bat 'deploy\\MyBasicAppR.exe'
}
