properties([

	parameters([

		string(name: 'url', description: "URL for check", defaultValue: 'google.com')
        string(name: 'BuildAgentNameType', description: "How agent will call by name or label?", defaultValue: 'name')
        string(name: 'BuildAgent', description: "Name or Label for build agent call?", defaultValue: 'name')

	])

])

pipeline {

    if('${BuildAgentNameType}' == 'name'){

        agent{
            name '${BuildAgentName}'
        }

    }

    else {

        if('${BuildAgent}' == 'label'){

            agent{
                label '${BuildAgentName}'
            }

        }

    }

    environment {

        msg = 'BuildError'

    }

    stages {

        stage('Clone repository') {

            steps{

                checkout([

                    $class: 'GitSCM',

                    branches: [[name: '*/master']],

                    extensions: scm.extensions + [[$class: 'CleanCheckout']],

                    userRemoteConfigs: scm.userRemoteConfigs

                ])

            }

        }

        stage ('Check URL'){

            steps{

                script{

                    msg = powershell(returnStdout : true, script: ".\\ps.ps1 -url ${url}")

                }

            }

        }

        stage ('Print Results'){

            steps{

                echo "${msg}"

            }

        }

    }

    post {

        always {

            emailext body: "URL check status: ${msg}",

            recipientProviders: [[$class: 'RequesterRecipientProvider']], 

            subject: 'Jenkins Build Results'

        }

    }

}
