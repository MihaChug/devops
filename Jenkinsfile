def url = 'google.com'
def response = 'Unknown'

pipeline {
    agent any
    stages {
        stage('Clone repository') {
            checkout([
                $class: 'GitSCM',
                branches: [[name: '*/master']],
                extensions: scm.extensions + [[$class: 'CleanCheckout']],
                userRemoteConfigs: scm.userRemoteConfigs
            ])
        }
        stage ('Check URL'){
            steps{
                $env:response = PowerShell(". '.\\ps.ps1'; -url $env:url")
                echo $env:response
            }
        }
    }
}