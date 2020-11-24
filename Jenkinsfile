node {
  try {

    stage('Checkout SCM') {
        checkout scm
    }

    stage('Build containers') {
      redoc = docker.build("redoc:${env.BUILD_ID}", ".")
    }

    stage('Push containers') {
      docker.withRegistry("https://dockers.shareit.fi") {
        retry(10) {
          redoc.push()
          redoc.push('latest')
        }
      }
    }

  } finally {	
      step([$class: 'WsCleanup'])
  }
}