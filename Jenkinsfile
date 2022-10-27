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
          - name: jnlp
            image: jenkins/inbound-agent:windowsservercore-1809
            command:
            - cat
            tty: true
          - name: docker
            image: docker:windowsservercore-ltsc2022
            command:
            - cat
            tty: true
          nodeSelector:
            kubernetes.io/os: windows
        '''
    }
  }
  stages {
    stage('build') {
      steps {
        container('docker') {
          bat 'docker buil -t .'
        }
      }
    }
  }
}
