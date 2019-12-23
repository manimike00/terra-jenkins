pipeline {  
	
	agent { label 'jenkins-slave-1' }
	
	// #environment {
    	// #	SVC_ACCOUNT_KEY = credentials('terraform-auth')
  	// #}  

	stages {
		stage('Checkout') {
     			 steps {
        			checkout scm
        			sh 'mkdir -p ~/.aws'
				sh 'which terraform'
        			sh 'echo $SVC_ACCOUNT_KEY | base64 -d > ~/.aws/credentials'
				sh 'cat ~/.aws/credentials'
      			}
    		}
		stage('TF Plan') {
       			steps {
        			 container('terraform') {
        			 sh 'terraform init'
           			 sh 'terraform plan -out myplan'
         			}
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
        			container('terraform') {
          				sh 'terraform apply -input=false myplan'
        			}
      			}
    		}
  	}
}
