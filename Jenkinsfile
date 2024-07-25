pipeline {
    agent any
    environment {
        DOCKER_IMAGE = 'nileshmuthal1317/myproject'
    }
    stages {
        stage('Checkout') {
            steps {
                git branch: '${BRANCH_NAME}', url: 'https://github.com/nileshmuthal1317/cicdproject.git'
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
                    if (env.BRANCH_NAME == 'master') {
                        sh 'docker run -d -p 82:80 -v $WORKSPACE:/var/www/html ${env.DOCKER_IMAGE}:${env.BUILD_ID}'
                    } else if (env.BRANCH_NAME == 'develop') {
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
