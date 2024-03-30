pipeline {
  agent any
  stages {
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
