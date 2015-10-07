/* testing ditributed build, archive/unarchive and execute. 
   Don't forget to change the nodes' labels. */
   
/* Workflow config (if value doesn't appear above keep default value)
    1- Create new workflow. 
	2- Definition: workflow script from SCM
	3- SCM: Git
	4- URL: https://github.com/graguirre/DelphiDepencyExample.git
	5- Script path: script/distributed-workflow.groovy
	*/

node ('SlaveG') { 
  git url: 'https://github.com/graguirre/DelphiDepencyExample.git'
  bat 'build.bat MyBasicPackage.dproj'
  archive '**/*.dcu'
}

println '----------------------------------------------------------------------------------------------------'

node  ('SlaveM') {
  unarchive mapping: ['**/*.dcu' : '.']
  git url: 'https://github.com/graguirre/DelphiDepencyExample.git'
  bat 'build.bat MyPackageTester.dproj'
  archive '**/*.dcu'
}

println '----------------------------------------------------------------------------------------------------'

node  ('SlaveG') {
  unarchive mapping: ['**/*.dcu' : '.']
  git url: 'https://github.com/graguirre/DelphiDepencyExample.git'
  bat 'build.bat MyBasicApp.dproj'
  archive '**/*.exe'
}

println '----------------------------------------------------------------------------------------------------'

node  ('master') {
  unarchive mapping: ['**/*.exe' : '.']
  bat 'Win32\\Debug\\MyBasicApp.exe'
}
