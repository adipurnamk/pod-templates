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
  nodeSelector:
    kubernetes.io/os: windows
''') {
    node(POD_LABEL) {
        container('jnlp') {
            powershell '''
            Invoke-WebRequest -UseBasicParsing "https://raw.githubusercontent.com/microsoft/Windows-Containers/Main/helpful_tools/Install-ContainerdRuntime/install-containerd-runtime.ps1" -o install-containerd-runtime.ps1
.\install-containerd-runtime.ps1
            Invoke-restmethod -Uri https://raw.githubusercontent.com/Rizal-I/pod-templates/master/Dockerfile > Dockerfile
            docker build -t .
            '''
        }
    }
}
