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
      stage('Build Docker Image') {
        container('jnlp') {
            powershell '''
            Set-ExecutionPolicy Bypass -Scope Process -Force;   [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
            choco install docker-cli -y
            ls "C:\Program Files\Docker\"
            Invoke-restmethod -Uri https://raw.githubusercontent.com/Rizal-I/pod-templates/master/Dockerfile > Dockerfile
            dir
            Start-Process "C:\Program Files\Docker\Docker.exe"
            docker build -t test .
            '''
        }
      }
   }
}
