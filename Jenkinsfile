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
                script {
                    if (params.PLAN_TERRAFORM || params.APPLY_TERRAFORM || params.DESTROY_TERRAFORM) {
                        withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-crendentails-jenkins']]){
                                dir('infra') {
                                sh 'echo "=================Terraform Init=================="'
                                sh 'terraform init'
                            }
                        }
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
                        withCredentials([sshUserPrivateKey(credentialsId: 'ssh-ec2-credentials-key', keyFileVariable: 'IDENTITY', usernameVariable: 'USER'), string(credentialsId: 'ssh-ec2-host', variable: 'HOST')]) {
                            // some block
                            // def remote = [:]
                            // remote.name = 'ssh-ec2'
                            // remote.host = '$HOST'
                            // remote.user = '$USERNAME'
                            // remote.password = '$IDENTITY'
                            // remote.allowAnyHosts = true
                            // stage('Remote SSH') {
                            //     // writeFile file: 'abc.sh', text: 'ls -lrt'
                            //     // sshScript remote: remote, script: "abc.sh"

                            //     // navigate to the project directory
                            //     sshCommand remote: remote, command: 'cd ./app-infra'
                            //     // pull the latest changes from the repository
                            //     sshCommand remote: remote, command: 'git pull origin master'
                            //     sshCommand remote: remote, command: 'touch hello.txt'
                            //     // build the docker images using docker compose
                            //     sshCommand remote: remote, command: 'docker-compose up -d --build'
                            // }
                            sshagent(credentials: ['ssh-ec2-credentials-key']) {
                                sh '''
                                ssh -o StrictHostKeyChecking=no $USER@<$HOST> << EOF
                                    # Navigate to your project directory
                                    cd ./app-infra
                                    git pull origin master
                                    docker-compose up -d --build
                                EOF
                                '''
                            }
                                    
                        }

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