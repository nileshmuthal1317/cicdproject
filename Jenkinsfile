pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'nileshmuthal1317/myproject'
    }

    parameters {
        string(name: 'BRANCH_NAME', defaultValue: 'master', description: 'Branch name to build')
    }

    stages {
        stage('Build Docker Image') {
            when {
                expression { return params.BRANCH_NAME == 'master' }
            }
            steps {
                script {
                    docker.build("${env.DOCKER_IMAGE}:${env.BUILD_ID}")
                }
            }
        }
        stage('Publish Docker Image') {
            when {
                expression { return params.BRANCH_NAME == 'master' }
            }
            steps {
                script {
                    withCredentials([string(credentialsId: 'nileshmuthal1317-dockerhub-token', variable: 'DOCKERHUB_TOKEN')]) {
                        echo 'Logging in to Docker Hub...'
                        sh 'echo $DOCKERHUB_TOKEN | docker login -u nileshmuthal1317 --password-stdin'

                        echo 'Debugging Environment Variables...'
                        sh 'echo "DOCKER_IMAGE: ${DOCKER_IMAGE}"'
                        sh 'echo "BUILD_ID: ${BUILD_ID}"'

                        echo 'Pushing Docker image to Docker Hub...'
                        sh '''
                        docker push ${DOCKER_IMAGE}:${BUILD_ID}
                        '''

                        echo 'Running Docker container...'
                        sh '''
                        docker run -d -p 82:80 -v $WORKSPACE:/var/www/html ${DOCKER_IMAGE}:${BUILD_ID}
                        '''
                    }
                }
            }
        }
        stage('Notify') {
            when {
                expression { return params.BRANCH_NAME == 'develop' }
            }
            steps {
                echo 'Build successful, not publishing'
            }
        }
    }

    post {
        always {
            cleanWs()
        }
    }
}
