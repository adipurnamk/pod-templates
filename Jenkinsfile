podTemplate(yaml: '''
apiVersion: v1
kind: Pod
spec:
  containers:
  - name: jnlp
    image: jenkins/inbound-agent:windowsservercore-ltsc2019
  - name: gcloud
  nodeSelector:
    kubernetes.io/os: windows
''') {
    node(POD_LABEL) {
      stage('Build Docker Image') {
        container('jnlp') {
            powershell 'gcloud components update --quiet'
            
        }
      }
   }
}
