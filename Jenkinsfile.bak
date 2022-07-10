pipeline {
  agent any
  tools {
    nodejs 'NodeJS16.5'
  }

  options {
    timeout(time: 2, unit: 'MINUTES')
  }

  stages {
    stage('Run tests') {
      steps {
        ng serve
      }
    }
  }
}
