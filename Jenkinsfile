pipeline {
    agent any
    
    environment {
        DOCKER_CREDENTIALS_ID = 'docker-hub'
        DOCKER_IMAGE_NAME = 'bitman26/jenkins-kubernetes'
        SSH_USER = 'teste'
        SSH_HOST = '172.22.129.214'
    }

    stages {
        stage('GIT Stage') {
            steps {
                // Clonar o repositório via SSH
                git branch: 'main', credentialsId: 'jenkins-token', url: 'git@github.com:bitman26/Jenkins-Kubernetes.git'
            } 
        }
        
        stage('Copy Repository to Remote Server') {
            steps {
                script {
                    // Copiar o repositório clonado para o servidor remoto
                    sshagent(credentials: ['key-ssh-docker']) {
                        sh "scp -o StrictHostKeyChecking=no -r /var/jenkins_home/workspace/Jenkins-Kubernetes_main ${SSH_USER}@${SSH_HOST}:/tmp/Jenkins-Kubernetes"
                    }
                }
            } 
        }
        
        stage('Build and Push Docker Image') {
            steps {
                script {
                    // Construir a imagem Docker no host remoto
                    sshagent(credentials: ['key-ssh-docker']) {
                        sh "ssh ${SSH_USER}@${SSH_HOST} 'cd /tmp/Jenkins-Kubernetes && docker build -t ${DOCKER_IMAGE_NAME}:v${BUILD_NUMBER}.0 .'"
                    }

                    // Fazer login no Docker Hub no host remoto
                    sshagent(credentials: ['key-ssh-docker']) {
                        sh "ssh ${SSH_USER}@${SSH_HOST} 'docker login -u ${DOCKER_CREDENTIALS_ID} -p ${DOCKER_CREDENTIALS_ID}'"
                    }

                    // Fazer push da imagem para o Docker Hub no host remoto
                    sshagent(credentials: ['key-ssh-docker']) {
                        sh "ssh ${SSH_USER}@${SSH_HOST} 'docker push ${DOCKER_IMAGE_NAME}:v${BUILD_NUMBER}.0'"
                    }
                }
            }
        }
    }
    
    post {
        success {
            sshagent(credentials: ['key-ssh-docker']) {
                sh "ssh ${SSH_USER}@${SSH_HOST} 'rm -rf /tmp/Jenkins-Kubernetes'"
            }
            echo 'Pipeline executada com sucesso!'
        }
        failure {
            sshagent(credentials: ['key-ssh-docker']) {
                sh "ssh ${SSH_USER}@${SSH_HOST} 'rm -rf /tmp/Jenkins-Kubernetes'"
            }
            echo 'Falha na execução da pipeline.'
        }
    }
}
