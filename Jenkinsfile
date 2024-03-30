pipeline {
    agent any
    
    environment {
        DOCKER_CREDENTIALS_ID = 'docker-hub'
        DOCKER_IMAGE_NAME = 'bitman26/jenkins-kubernetes'
        SSH_CREDENTIALS_ID = 'seu-id-de-credencial-ssh'
        SSH_USER = 'seu-usuario-ssh'
        SSH_HOST = 'seu-host-ssh'
        DOCKER_USERNAME = 'seu-usuario-dockerhub'
        DOCKER_PASSWORD = 'sua-senha-dockerhub'
    }
    
    stages {
        stage('Build and Push Docker Image') {
            steps {
                script {
                    // Clonar o repositório via SSH
                    sshagent(credentials: ['${SSH_CREDENTIALS_ID}']) {
                        sh "ssh ${SSH_USER}@${SSH_HOST} 'git clone -b main git@github.com:bitman26/Jenkins-Kubernetes.git'"
                    }
                    
                    // Construir a imagem Docker
                    sshagent(credentials: ['${SSH_CREDENTIALS_ID}']) {
                        sh "ssh ${SSH_USER}@${SSH_HOST} 'cd Jenkins-Kubernetes && docker build -t ${DOCKER_IMAGE_NAME}:v${BUILD_NUMBER}.0 .'"
                    }

                    // Fazer login no Docker Hub
                    sshagent(credentials: ['${SSH_CREDENTIALS_ID}']) {
                        sh "ssh ${SSH_USER}@${SSH_HOST} 'docker login -u ${DOCKER_USERNAME} -p ${DOCKER_PASSWORD}'"
                    }

                    // Fazer push da imagem para o Docker Hub
                    sshagent(credentials: ['${SSH_CREDENTIALS_ID}']) {
                        sh "ssh ${SSH_USER}@${SSH_HOST} 'docker push ${DOCKER_IMAGE_NAME}:v${BUILD_NUMBER}.0'"
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
