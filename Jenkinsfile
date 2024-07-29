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
                script {
                    deleteDir() // Clean workspace before checkout
                    git branch: "${params.BRANCH_NAME}", url: 'https://github.com/nileshmuthal1317/cicdproject.git'
                }
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    def imageTag = "${env.DOCKER_IMAGE}:${env.BUILD_ID}"
                    echo "Building Docker image with tag: ${imageTag}"
                    docker.build(imageTag)
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

                        def imageTag = "${env.DOCKER_IMAGE}:${env.BUILD_ID}"
                        echo "Pushing Docker image with tag: ${imageTag}"
                        
                        sh '''#!/bin/bash
                        docker push "${imageTag}"
                        '''

                        echo 'Running Docker container...'
                        sh '''#!/bin/bash
                        docker run -d -p 82:80 -v $WORKSPACE:/var/www/html "${imageTag}"
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
