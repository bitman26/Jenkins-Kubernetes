pipeline {
  agent any
  stages {
    stage('Git Stage') {
      steps {
        git(credentialsId: 'jenkins-ssh-git', url: 'git@github.com:bitman26/Jenkins-Kubernetes.git', branch: 'main')
      }
    }

    stage('Build Image') {
      steps {
        sh 'docker build . -t ${usuario}/jenkins-kubernetes:${tagname}'
      }
    }

    stage('Export Image') {
      steps {
        sh '''docker login  -u ${usuario} -p ${password}
docker push ${usuario}/jenkins-kubernetes:${tagname}'''
      }
    }

  }
}
