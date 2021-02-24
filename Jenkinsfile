def buildStages

node('master') {
checkout(
  [
    $class: 'GitSCM', 
    branches: [
      [
        name: '*/master'
      ]
    ], 
    doGenerateSubmoduleConfigurations: false, 
    extensions: [
      [
        $class: 'SubmoduleOption', 
        disableSubmodules: false, 
        parentCredentials: true, 
        recursiveSubmodules: true, 
        reference: '', 
        trackingSubmodules: false
      ]
    ], 
    submoduleCfg: [], 
    userRemoteConfigs: [
      [
        credentialsId: 'kathi_github', 
        url: 'https://github.com/katharinareinery/ci-test.git'
      ]
    ]
  ]
)
  stage('Initialise') {
    buildStages = prepareBuildStages()
    println("Initialised pipeline.")
  }

  for (builds in buildStages) {
      parallel(builds)
  }

  stage('Finish') {
      println('Build complete.')
  }
}

def prepareBuildStages() {
  def buildStagesList = []
  def buildParallelMap = [:]
  for (name in findFiles(glob: 'src/*.c')) {
    def n = "${name}"
    buildParallelMap.put(n, prepareOneBuildStage(n.take(n.lastIndexOf('.'))))
  }
  buildStagesList.add(buildParallelMap)
  
  return buildStagesList
}

def prepareOneBuildStage(String name) {
  return {
    stage("Build stage:${name}") {
      def myEnv = docker.build 'environment'
      myEnv.inside {
          sh "rake clean"
          sh "rake tinyAES"
          sh "rake Unity"
          sh "rake ${name}.exe --trace"
      }
    }
  }
}