pipeline {
    agent {
        node {
            label 'AGENT-1'
        }
    }
    parameters {
        string(name: 'version', defaultValue: '', description: 'What is the Artifact Version?')
        string(name: 'environment', defaultValue: '', description: 'What is the environment?')
        booleanParam(name: 'create', defaultValue: 'true', description: 'Do you want to Create?')
        booleanParam(name: 'destroy', defaultValue: 'false', description: 'Do you want to Destroy?')
        
    }
   
    options {
        ansiColor('xterm')
        disableConcurrentBuilds()
    }

    stages {
        stage('Get the package version and environment') {
            steps {
                sh """
                    echo "Artifact version: ${params.version}"
                    echo "Environment: ${params.environment}"
                """
            }
        }
        stage('Terraform init') {
            steps {
                sh """
                    cd terraform
                    terraform init --backend-config=${params.environment}/backend.tf -reconfigure
                """
            }
        }
        stage('Terraform Plan') {
            when {
                expression { params.create == true }
            }
            steps {
                sh """
                    cd terraform 
                    terraform plan -var-file="${params.environment}/${params.environment}.tfvars" -var="app_version=${params.version}" 
                """
            }
        }
        stage('Terraform Apply') {
            when {
                expression { params.create == true && params.destroy == false}
            }
            steps {
                sh """
                    cd terraform 
                    terraform apply -var-file="${params.environment}/${params.environment}.tfvars" -var="app_version=${params.version}" -auto-approve
                    
                """
            }
        }
        stage('Terraform Destroy') {
            when {
                expression { params.destroy == true && params.create == false }
            }
            steps {
                sh """
                    cd terraform 
                    terraform destroy -var-file="${params.environment}/${params.environment}.tfvars" -var="app_version=${params.version}" -auto-approve
                    
                """
            }
        }   
    }
    post {
        // always {
        //     echo 'Deleting the Directory'
        //     deleteDir()
        // }
        failure {
            echo 'Pipeline Script execution Failed'
        }
        success {
            echo 'Pipeline Scrip Executed Successfully'
        }
    }

}

