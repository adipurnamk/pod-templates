pipeline {
  agent {
    kubernetes {
      yaml '''
        apiVersion: v1
        kind: Pod
        metadata:
          labels:
            some-label: some-label-value
        spec:
          containers:
          - name: docker
            image: docker:windowsservercore-1809
            command:
            - more
            tty: true
          nodeSelector:
            kubernetes.io/os: windows
        '''
    }
  }
  stages {
    stage('Run docker') {
      steps {
        container('docker') {
          bat 'docker build -t .'
        }
      }
    }
  }
}
