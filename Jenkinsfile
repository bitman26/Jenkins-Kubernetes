pipeline {
  agent any
  stages {
    stage('Build Image') {
      steps {
        sh 'docker build . -t ${usuario}/jenkins-kubernetes:${tagname}'
      }
    }

  }
}
