pipeline {
    agent any

    environment {
        DOCKERHUB_IMAGE_NAME = 'nileshmutha1317/my_docker_image_001' // Updated with your Docker Hub username
    }

    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    // Build the Docker image with the updated name
                    sh 'docker build -t my_docker_image_001 .'
                }
            }
        }
        stage('Publish Website') {
            when {
                branch 'master'
            }
            steps {
                script {
                    // Run the Docker container mapping internal port 80 to host port 82
                    sh 'docker run -d -p 82:80 my_docker_image_001'
                }
            }
        }
        stage('Push Docker Image') {
            when {
                branch 'master'
            }
            steps {
                withCredentials([string(credentialsId: 'nileshmuthal1317-dockerhub', variable: 'DOCKERHUB_TOKEN')]) {
                    script {
                        // Log in to Docker Hub
                        sh 'echo $DOCKERHUB_TOKEN | docker login -u nileshmutha1317 --password-stdin'
                        
                        // Tag the Docker image for Docker Hub
                        sh 'docker tag my_docker_image_001 $DOCKERHUB_IMAGE_NAME:latest'
                        
                        // Push the Docker image to Docker Hub
                        sh 'docker push $DOCKERHUB_IMAGE_NAME:latest'
                    }
                }
            }
        }
    }

    post {
        always {
            // Clean up Docker container and image if needed
            script {
                sh 'docker container prune -f'
                sh 'docker image prune -f'
            }
        }
    }
}
