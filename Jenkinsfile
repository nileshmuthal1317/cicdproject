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
                    def imageTag = "${env.DOCKER_IMAGE}:${env.BUILD_ID}"
                    echo "Building Docker image with tag: ${imageTag}"
                    docker.build(imageTag)
                }
            }
        }
        stage('Publish Docker Image') {
            when {
                expression { return params.BRANCH_NAME == 'master' }
            }
            steps {
                script {
                    withCredentials([string(credentialsId: 'nileshmuthal1317-dockerhub', variable: 'DOCKERHUB_TOKEN')]) {
                        echo 'Logging in to Docker Hub...'
                        sh 'echo $DOCKERHUB_TOKEN | docker login -u nileshmuthal1317 --password-stdin'
                        
                        echo 'Debugging Environment Variables...'
                        sh 'echo "DOCKER_IMAGE: ${DOCKER_IMAGE}"'
                        sh 'echo "BUILD_ID: ${BUILD_ID}"'

                        def imageTag = "${env.DOCKER_IMAGE}:${env.BUILD_ID}"
                        echo 'Pushing Docker image to Docker Hub...'
                        sh 'docker push ${imageTag}'

                        echo 'Running Docker container...'
                        sh '''
                            docker run -d -p 82:80 -v $WORKSPACE:/var/www/html ${imageTag}
                        '''
                    }
                }
            }
        }
    }
    post {
        always {
            cleanWs() // Clean workspace after the build
        }
    }
}
