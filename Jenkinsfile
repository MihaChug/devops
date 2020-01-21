def url = 'google.com'
def msg = 'Unknown'

pipeline {
    agent any
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
                echo powershell(returnStdout : true, script: ".\\ps.ps1 -url ${url}") >> ${msg}
                echo ${msg}
            }
        }
    }

}
