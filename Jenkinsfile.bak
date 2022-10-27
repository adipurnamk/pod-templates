/*
 * Runs a build on a Windows pod.
 * Tested in EKS: https://docs.aws.amazon.com/eks/latest/userguide/windows-support.html
 */
podTemplate(yaml: '''
apiVersion: v1
kind: Pod
spec:
  containers:
  - name: jnlp
    image: jenkins/inbound-agent:windowsservercore-ltsc2019
  - name: docker
    image: docker:windowsservercore-ltsc2022
    command:
    - cat
    tty: true
  nodeSelector:
    kubernetes.io/os: windows
''') {
    node(POD_LABEL) {
        container('docker') {
            bat 'docker buil -t .'
        }
    }
}
