pipeline {
    agent { dockerfile true }
    stages {
        stage('Build') {
            steps {
                sh 'git submodule update --init --recursive'
                sh 'rake'
            }
        }
    }
}