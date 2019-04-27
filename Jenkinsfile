pipeline {
	agent any
	stages{
		stage('Build') {
			steps {
				sh 'mvn package -DskipTests'
						
			}		
		}
		stage('BUILD - Docker Images') 
		{
			steps 
			{
				sh 'docker build -t yharshavardhan97/cheers2019:appimg .'
				sh 'docker build -t yharshavardhan97/cheers2019:sqlimg -f mysql.Dockerfile .'
			}
		} 

		

		stage("TEST - Running Test") 
		{
			steps 
			{	
				script 
				{
                                 try
					{
						sh 'docker-compose up -d'
						sh 'sleep 60'
						sh 'docker exec hM1_container mvn -f /usr/app test'
						currentBuild.result = 'SUCCESS'
						sh 'docker-compose stop'
					}
					catch(Exception ex) 
					{
						currentBuild.result = 'ABORTED'
						sh 'docker-compose stop'
						error('Test Cases Failed')

					}
							
				}

			}
		}


		stage('PUBLISH to DockerHub') 
		{
		    steps 
		    {
	        	withDockerRegistry([ credentialsId: "dockerHub", url: "" ]) 
	        	{
				
	        		sh 'docker stop hmsql1_container'
				sh 'docker rm hmsql1_container'
				sh 'docker stop hM1_container'
				sh 'docker rm hM1_container'
				sh 'docker push yharshavardhan97/cheers2019:appimg'
	        		sh 'docker push yharshavardhan97/cheers2019:sqlimg'
				
	      		}
		    }
		}
	}
	post
	{
		always
		{
			sh 'echo "Pipeline Finished"'
		}
		success
		{
			sh 'curl --location --request POST "http://localhost:4440/api/21/job/9c52ea01-8d7a-4ee3-8800-18e4693d012d/run" \
 			--header "Accept: application/json" \
 			--header "X-Rundeck-Auth-Token: aFbPNoYDgrq7uIu0YB6A7C1buiUdZ9jh" \
 			--header "Content-Type: application/json" \
 			--data ""'
		}
  	}
	
}
