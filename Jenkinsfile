podTemplate(yaml: '''
apiVersion: v1
kind: Pod
spec:
  containers:
  - name: jnlp
    image: jenkins/inbound-agent:windowsservercore-ltsc2019
  - name: docker
    image: docker:windowsservercore-ltsc2022
  nodeSelector:
    kubernetes.io/os: windows
''') {
    node(POD_LABEL) {
      stage('Build Docker Image') {
        container('docker') {
            bat 'docker build -t .'
            
        }
      }
   }
}
