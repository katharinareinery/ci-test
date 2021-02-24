def buildStages

node('master') {
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
    buildParallelMap.put(n, prepareOneBuildStage(n))
  }
  buildStagesList.add(buildParallelMap)
  
  return buildStagesList
}

def prepareOneBuildStage(String name) {
  return {
    stage("Build stage:${name}") {
        def myEnv = docker.build 'environment'
        myEnv.inside {
            sh "rake ${name}"
        }
    }
  }
}