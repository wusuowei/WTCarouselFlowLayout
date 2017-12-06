pipeline {
  agent any
  stages {
    stage('build') {
      steps {
        sh 'echo \'abc\''
        sh 'echo "test"'
      }
    }
    stage('upload') {
      parallel {
        stage('upload') {
          steps {
            echo 'upload'
          }
        }
        stage('archive') {
          steps {
            echo 'archive'
          }
        }
      }
    }
    stage('test') {
      steps {
        echo 'test'
      }
    }
  }
}