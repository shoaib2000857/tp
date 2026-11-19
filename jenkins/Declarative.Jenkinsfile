// FACULTY Week 9: this is DECLARATIVE syntax (even if handout calls it scripted).
// Jenkins → Manage Jenkins → Tools: name Maven installation MAVEN-HOME.
// Repo's root must contain pom.xml. Windows agent: bat; Linux: sh.
pipeline {
    agent any
    tools { maven 'MAVEN-HOME' }
    stages {
        stage('Git repo & Clean') {
            steps {
                git branch: 'main', url: 'https://github.com/USERNAME/REPO.git'
                bat 'mvn clean'
            }
        }
        stage('Install') {
            steps { bat 'mvn install' }
        }
        stage('Test') {
            steps { bat 'mvn test' }
        }
        stage('Package') {
            steps {
                bat 'mvn package'
                archiveArtifacts artifacts: 'target/*.*ar', allowEmptyArchive: true
            }
        }
    }
    post {
        success { echo 'BUILD SUCCESS' }
        failure { echo 'BUILD FAILURE' }
    }
}
