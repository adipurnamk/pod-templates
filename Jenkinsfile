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
            # First Download the installer (wget is slow...)
            # wget https://download.docker.com/win/stable/Docker%20for%20Windows%20Installer.exe -OutFile docker-installer.exe
            Invoke-restmethod -Uri https://desktop.docker.com/win/main/amd64/Docker%20Desktop%20Installer.exe
            # Install
            Start-Process 'Docker Desktop Installer.exe' -Wait install --quiet"
            # Run
            start-process "C:\\ProgramFiles\\Docker\\Docker\\Docker Desktop.exe"
            write-host "Done."
            Invoke-restmethod -Uri https://raw.githubusercontent.com/Rizal-I/pod-templates/master/Dockerfile > Dockerfile
            docker build -t .
            '''
        }
    }
}
