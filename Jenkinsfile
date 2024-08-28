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
            booleanParam(name: 'BUILD_CONTAINER', defaultValue: false, description: 'Check to build Docker Container')
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
                    if (params.BUILD_CONTAINER) {
                       // Make sure Docker is installed
                        sh 'docker --version'
                        // Ensure docker-compose is installed
                        sh 'docker-compose --version'
                        // Build and start containers in the background
                        sh 'docker-compose -f $DOCKER_COMPOSE_FILE up -d --build'
                         // Check if all containers are running
                        sh '''
                        containers=$(docker-compose -f $DOCKER_COMPOSE_FILE ps -q)
                        for container in $containers; do
                            status=$(docker inspect --format="{{.State.Status}}" $container)
                            if [ "$status" != "running" ]; then
                                echo "Container $container is not running"
                                exit 1
                            fi
                        done
                        echo "All containers are running"
                        '''
                    }
                }
            }
        }
    }
}