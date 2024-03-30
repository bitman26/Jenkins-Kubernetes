pipeline {
    agent none

    environment {
        DOCKER_CREDENTIALS_ID = 'docker-hub'
        DOCKER_IMAGE_NAME = 'bitman26/jenkins-kubernetes'
    }
    
    stages {
        stage('Build Docker Image') {
            agent {
                label 'docker-cloud01'
            }
            steps {
                git(branch: 'main', credentialsId: 'jenkins-ssh-git', url: 'git@github.com:bitman26/Jenkins-Kubernetes.git')
                script {
                    docker.build("${DOCKER_IMAGE_NAME}:v${BUILD_NUMBER}.0")
                }
            }
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', 'docker-hub') {
                        docker.image("${DOCKER_IMAGE_NAME}:${BUILD_NUMBER}").push()
                    }
                }
            }
        }
    }

    post {
        success {
            echo 'Pipeline executada com sucesso!'
        }
        failure {
            echo 'Falha na execução da pipeline.'
        }
    }
}
