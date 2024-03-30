pipeline {
     agent {
        docker {
            label 'Docker-Server'
        }
    }
    environment {
        DOCKER_CREDENTIALS_ID = 'docker-hub'
        DOCKER_IMAGE_NAME = 'bitman26/jenkins-kubernetes'
    }

    stages {
        stage('Clonar repositório') {
            steps {
                git(branch: 'main', credentialsId: 'jenkins-ssh-git', url: 'git@github.com:bitman26/Jenkins-Kubernetes.git')
            }
        }

        stage('Construir imagem Docker') {
            steps {
                script {
                    docker.build("${DOCKER_IMAGE_NAME}:${BUILD_NUMBER}")
                }
            }
        }

        stage('Push para Docker Hub') {
            steps {
                script {
                    docker.withRegistry('https://registry.hub.docker.com', DOCKER_CREDENTIALS_ID) {
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
