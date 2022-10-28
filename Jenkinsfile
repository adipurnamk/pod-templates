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
    image: jenkins/inbound-agent:4.13-1-jdk11-windowsservercore-ltsc2019
  nodeSelector:
    kubernetes.io/os: windows
''') {
    node(POD_LABEL) {
        container('jnlp') {
            powershell '''
            Invoke-restmethod -Uri https://desktop.docker.com/win/main/amd64/Docker%20Desktop%20Installer.exe
            echo'Install'
            Start-Process 'Docker Desktop Installer.exe' -Wait install --quiet"
            echo 'run'
            dir C:\ProgramFiles\Docker\Docker\
            echo 'done'
            Invoke-restmethod -Uri https://raw.githubusercontent.com/Rizal-I/pod-templates/master/Dockerfile > Dockerfile
            docker build -t .
            '''
        }
    }
}
