pipeline {
    agent any

    environment {
        COMPOSE_PROJECT_NAME = "dev_project_1" // Set a unique project name
        DOCKER_COMPOSE_FILE = "docker-compose.yml"
    }

    parameters {
            booleanParam(name: 'PLAN_TERRAFORM', defaultValue: false, description: 'Check to plan Terraform changes')
            booleanParam(name: 'APPLY_TERRAFORM', defaultValue: false, description: 'Check to apply Terraform changes')
            booleanParam(name: 'DESTROY_TERRAFORM', defaultValue: false, description: 'Check to apply Terraform changes')
            booleanParam(name: 'BUILD_DOCKER', defaultValue: false, description: 'Check to build Docker Container')
    }

    stages {
        stage('Clone Repository') {
            steps {
                deleteDir()
                git branch: 'master',
                    url: 'https://github.com/firstpersoncode/app-infra.git'

                sh "ls -lart"
            }
        }

        stage('Terraform Init') {
                    steps {
                       withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-crendentails-jenkins']]){
                            dir('infra') {
                            sh 'echo "=================Terraform Init=================="'
                            sh 'terraform init'
                        }
                    }
                }
        }

        stage('Terraform Plan') {
            steps {
                script {
                    if (params.PLAN_TERRAFORM) {
                       withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-crendentails-jenkins']]){
                            dir('infra') {
                                sh 'echo "=================Terraform Plan=================="'
                                sh 'terraform plan'
                            }
                        }
                    }
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                script {
                    if (params.APPLY_TERRAFORM) {
                       withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-crendentails-jenkins']]){
                            dir('infra') {
                                sh 'echo "=================Terraform Apply=================="'
                                sh 'terraform apply -auto-approve'
                            }
                        }
                    }
                }
            }
        }

        stage('Terraform Destroy') {
            steps {
                script {
                    if (params.DESTROY_TERRAFORM) {
                       withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-crendentails-jenkins']]){
                            dir('infra') {
                                sh 'echo "=================Terraform Destroy=================="'
                                sh 'terraform destroy -auto-approve'
                            }
                        }
                    }
                }
            }
        }

        stage('Build Docker') {
            steps {
                script {
                    if (params.BUILD_DOCKER) {
                        withCredentials([sshUserPrivateKey(credentialsId: 'ssh-ec2-credentials-key', keyFileVariable: 'IDENTITY', usernameVariable: 'USERNAME'), string(credentialsId: 'ssh-ec2-host', variable: 'HOST')]) {
                            // some block
                            def remote = [:]
                            remote.name = 'ssh-ec2'
                            remote.host = '$HOST'
                            remote.user = '$USERNAME'
                            remote.identity = '$IDENTITY'
                            remote.allowAnyHosts = true
                            stage('Remote SSH') {
                                // writeFile file: 'abc.sh', text: 'ls -lrt'
                                // sshScript remote: remote, script: "abc.sh"

                                // navigate to the project directory
                                sshCommand remote: remote, command: 'cd ./app-infra'
                                // pull the latest changes from the repository
                                sshCommand remote: remote, command: 'git pull origin master'
                                sshCommand remote: remote, command: 'touch hello.txt'
                                // build the docker images using docker compose
                                sshCommand remote: remote, command: 'docker-compose up -d --build'
                            }
                        }

                        // withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-crendentails-jenkins']]){
                        //     sh 'echo "=================Build Container=================="'
                        //     // sh 'sudo apt install docker.io -y'
                        //     // sh 'sudo usermod -aG docker ubuntu'
                        //     // sh 'newgrp docker'
                        //     // sh 'sudo chmod 777 /var/run/docker.sock'
                        //     sh 'docker version'
                        //     // sh 'sudo systemctl start docker'
                        //     // sh 'sudo systemctl enable docker'
                        //     // sh 'sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose'
                        //     // sh 'sudo chmod +x /usr/local/bin/docker-compose'
                        //     // sh 'docker-compose --version'
                        //     sh 'docker-compose -f $DOCKER_COMPOSE_FILE up -d --build'
                        //     sh '''
                        //     containers=$(docker-compose -f $DOCKER_COMPOSE_FILE ps -q)
                        //     for container in $containers; do
                        //         status=$(docker inspect --format="{{.State.Status}}" $container)
                        //         if [ "$status" != "running" ]; then
                        //             echo "Container $container is not running"
                        //             exit 1
                        //         fi
                        //     done
                        //     echo "All containers are running"
                        //     '''
                        // }

                        // sshagent(credentials: ['ssh-ec2-credentials-key']) {
                        //     sh '''
                        //     ssh -o StrictHostKeyChecking=no $@<EC2_PUBLIC_IP> << EOF
                        //         # Navigate to your project directory
                        //         cd /path/to/your/project

                        //         # Pull the latest changes from your repository
                        //         git pull origin main

                        //         # Build the Docker image
                        //         docker build -t your-image-name .

                        //         # Stop and remove the old container if exists
                        //         docker stop your-container-name || true
                        //         docker rm your-container-name || true

                        //         # Run the Docker container
                        //         docker run -d --name your-container-name -p 80:80 your-image-name
                        //     EOF
                        //     '''
                        // }
                        
                    }
                }
            }
        }
    }
}