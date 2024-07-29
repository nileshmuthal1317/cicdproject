pipeline {
    agent any
    parameters {
        string(name: 'BRANCH_NAME', defaultValue: 'master', description: 'Branch name to build')
    }
    stages {
        stage('Checkout') {
            steps {
                script {
                    // Clean workspace before checkout
                    deleteDir()

                    // Checkout the specified branch from the Git repository
                    git branch: "${params.BRANCH_NAME}", url: 'https://github.com/nileshmuthal1317/cicdproject.git'

                    // Verify the current branch
                    sh '''#!/bin/bash
                    echo "Current branch:"
                    git branch
                    '''
                }
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    docker.build("nileshmuthal1317/myproject:${env.BUILD_ID}")
                }
            }
        }
        stage('Publish Docker Image') {
            steps {
                script {
                    withCredentials([string(credentialsId: 'nileshmuthal1317-dockerhub', variable: 'DOCKERHUB_TOKEN')]) {
                        echo 'Logging in to Docker Hub...'
                        sh '''#!/bin/bash
                        echo "$DOCKERHUB_TOKEN" | docker login -u nileshmuthal1317 --password-stdin
                        '''

                        echo 'Pushing Docker image to Docker Hub...'
                        sh '''#!/bin/bash
                        docker push ${DOCKER_IMAGE}:${BUILD_ID}
                        '''

                        echo 'Running Docker container...'
                        sh '''#!/bin/bash
                        docker run -d -p 82:80 -v $WORKSPACE:/var/www/html ${DOCKER_IMAGE}:${BUILD_ID}
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
