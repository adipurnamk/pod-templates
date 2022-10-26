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
  - name: shell
    image: mcr.microsoft.com/powershell:preview-windowsservercore-1809
    command:
    - powershell
    args:
    - Start-Sleep
    - 999999
  nodeSelector:
    kubernetes.io/os: windows
''') {
    node(POD_LABEL) {
        container('shell') {
            powershell 'docker build -t pdaja .'
        }
    }
}
