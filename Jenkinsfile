pipeline {  
	
	agent { label 'jenkins-slave-1' }

	stages {
		stage('Checkout') {
     			 steps {
        			checkout scm
        			sh 'mkdir -p ~/.aws'
        			sh 'echo $SVC_ACCOUNT_KEY | base64 -d > ~/.aws/credentials'
      			}
    		}
		stage('TF Plan') {
       			steps {
        			 sh 'terraform init'
           			 sh 'terraform plan -out myplan'
       			}
     		}
		stage('Approval') {
      			steps {
        			script {
          				def userInput = input(id: 'confirm', message: 'Apply Terraform?', parameters: [ [$class: 'BooleanParameterDefinition', defaultValue: false, description: 'Apply terraform', name: 'confirm'] ])
        			}
      			}
    		}
		stage('TF Apply') {
      			steps {
          			sh 'terraform apply -input=false myplan'
				//    sh 'terraform destroy --auto-approve'
      			}
    		}
  	}
}
