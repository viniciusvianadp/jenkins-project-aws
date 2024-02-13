pipeline {
    agent any

    stages {

        stage("Checkout source") {
            steps {
                git url: 'https://github.com/viniciusvianadp/jenkins-project-aws.git', branch: 'main'
            }
        }

        stage('Execução do projeto Terraform') {
            environment {
                AWS_ACCESS_KEY_ID = credentials('AWS_ACCESS_KEY_ID')
                AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
                AWS_DEFAULT_REGION = credentials('AWS_DEFAULT_REGION')
                AWS_BUCKET = credentials('AWS_BUCKET')
                AWS_BUCKET_KEY = credentials('AWS_BUCKET_KEY')
                TF_VAR_sub_net_cidr_block = "10.0.1.0/24"
            }
            steps {
                script {
                    dir('src') {
                        sh 'terraform init -backend-config="bucket=$AWS_BUCKET" -backend-config="key=$AWS_BUCKET_KEY"' 
                        sh 'terraform apply --auto-approve'
                    }
                }
            }
        }
    }
}
