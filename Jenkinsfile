pipeline {
  agent any
  stages {
    stage('Git Stage') {
      steps {
        git(credentialsId: 'jenkins-ssh-git', url: 'https://github.com/bitman26/Jenkins-Kubernetes.git', branch: 'main')
      }
    }

    stage('Build Image') {
      steps {
        sh 'docker build . -t bitman26/jenkins-kubernetes:<image name>'
      }
    }

    stage('Export Image') {
      steps {
        sh 'docker login  -u bitman26 '
      }
    }

  }
}