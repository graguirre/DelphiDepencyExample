/* testing ditributed build, archive/unarchive and execute. 
   Don't forget to change the nodes' label. */

node ('SlaveMario') { 
  git url: 'https://github.com/graguirre/DelphiDepencyExample.git'
  bat 'build.bat MyBasicPackage.dproj'
  archive '**/*.bpl'
}

println '----------------------------------------------------------------------------------------------------'

node  ('SlaveGonzalo') {
  git url: 'https://github.com/graguirre/DelphiDepencyExample.git'
  bat 'build.bat MyPackageTester.dproj'
  archive '**/*.bpl'
}

println '----------------------------------------------------------------------------------------------------'

node  ('SlaveMario') {
  git url: 'https://github.com/graguirre/DelphiDepencyExample.git'
  bat 'build.bat MyBasicApp.dproj'
  archive '**/*.exe'
}

println '----------------------------------------------------------------------------------------------------'

node  ('master') {
  unarchive mapping: ['**/*.exe' : '.']
  bat 'Win32\\Debug\\MyBasicApp.exe'
}
