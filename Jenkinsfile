pipeline {
  agent any
  stages {
    stage('Build Image') {
      steps {
        sh 'docker build . -t bitman26/jenkins-kubernetes:${tagname}'
      }
    }
    stage('Push to Repository') {
      steps {
        sh 'docker push  bitman26/jenkins-kubernetes:${tagname}'
      }
    }

  }
}
