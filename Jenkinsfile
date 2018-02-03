#!groovy
pipeline {
    agent any

    stages {
        stage('Build') { 
            steps {
                sh 'mvn clean compile'
            }
        }
        stage('Test') {
            steps {
                sh 'mvn clean test'
            }
        }
        stage('Results') {
            steps {
                step([$class: 'JUnitResultArchiver', keepLongStdio: true, testResults: '**/target/surefire-reports/TEST*.xml'])
            }
        }
    }
}
