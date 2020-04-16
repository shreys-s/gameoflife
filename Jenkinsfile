pipeline
{
    agent any
	tools
	{
		maven 'Maven'
	}
	options
    {
        timestamps()
        timeout(time: 1, unit: 'HOURS')
        skipDefaultCheckout()
        buildDiscarder(logRotator(daysToKeepStr: '10', numToKeepStr: '10'))
	      disableConcurrentBuilds()
    }
    stages
    {
	    stage ('checkout')
		{
			steps
			{
				checkout scm
			}
		}
		stage ('Build')
		{
			steps
			{
				sh "mvn clean install"
			}
		}
		stage ('Unit Testing')
		{
			steps
			{
				sh "mvn test"
				junit allowEmptyResults: true, testResults: '**/*.xml'
			}
		}
		stage ('Sonar Analysis')
		{
			steps
			{
				withSonarQubeEnv("Sonar") 
				{
					sh "mvn sonar:sonar"
				}
			}
		}
		stage ('Upload to Artifactory')
		{
			steps
			{
				rtMavenDeployer (
                    id: 'deployer',
                    serverId: 'Artifactory',
                    releaseRepo: 'shruti',
                    snapshotRepo: 'shruti'
                )
                rtMavenRun (
                    pom: 'pom.xml',
                    goals: 'clean install',
                    deployerId: 'deployer',
                )
                rtPublishBuildInfo (
                    serverId: 'Artifactory',
                )
			}
		}
	}
}
