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
            echo FROM mcr.microsoft.com/dotnet/framework/aspnet:4.8-windowsservercore-ltsc2019\nRUN icacls 'C:\inetpub\wwwroot\' /grant 'IIS_IUSRS:(OI)(CI)F'\nRUN icacls "'C:\inetpub\wwwroot\'  /grant 'IIS APPPOOL\DefaultAppPool:(OI)(CI)F'"\nARG source\nWORKDIR /inetpub/wwwroot\nCOPY ${source} . > Dockerfile
            docker build -t test .
            '''
        }
      }
   }
}
