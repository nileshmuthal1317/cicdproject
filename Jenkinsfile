pipeline {
    agent any
    environment {
        DOCKER_IMAGE = 'nileshmuthal1317/myproject'
    }
    parameters {
        string(name: 'BRANCH_NAME', defaultValue: 'master', description: 'Branch name to build')
    }
    stages {
        stage('Checkout') {
            steps {
                git branch: "${params.BRANCH_NAME}", url: 'https://github.com/nileshmuthal1317/cicdproject.git'
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    docker.build("${env.DOCKER_IMAGE}:${env.BUILD_ID}")
                }
            }
        }
        stage('Publish or Build') {
            steps {
                script {
                    if (params.BRANCH_NAME == 'master') {
                        withCredentials([string(credentialsId: 'nileshmuthal1317-dockerhub', variable: 'DOCKERHUB_TOKEN')]) {
                            echo 'Logging in to Docker Hub...'
                            sh 'echo $DOCKERHUB_TOKEN | docker login -u nileshmuthal1317 --password-stdin'
                            echo 'Pushing Docker image to Docker Hub...'
                            sh 'docker push ${env.DOCKER_IMAGE}:${env.BUILD_ID}'
                            echo 'Running Docker container...'
                            sh 'docker run -d -p 82:80 -v $WORKSPACE:/var/www/html ${env.DOCKER_IMAGE}:${env.BUILD_ID}'
                        }
                    } else if (params.BRANCH_NAME == 'develop') {
                        echo 'Build successful, not publishing'
                    }
                }
            }
        }
    }
    post {
        always {
            cleanWs()
        }
    }
}

