pipeline {
  agent any
  stages {
    stage('Build Image') {
      steps {
        sh 'docker build . -t bitman26/jenkins-kubernetes:${tagname}'
      }
    }
    stage('Docker Login') {
      steps {
        withCredentials([usernamePassword(credentialsId: 'docker-hub', passwordVariable: 'password', usernameVariable: 'username')]) {
          sh 'docker login -u '$username' -p '$password''
        }
      }
    }
    stage('Push to Repository') {
      steps {
        sh 'docker push  bitman26/jenkins-kubernetes:${tagname}'
      }
    }

  }
}
