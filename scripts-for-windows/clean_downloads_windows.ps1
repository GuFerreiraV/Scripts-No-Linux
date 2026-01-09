# Definindo o caminho do diretório Downloads
$downloads_dir= Join-Path $HOME "Downloads"

# Define o número de dias para considerar um arquivo 'antigo'
$days_old = 7

if (Test-Path -Path $downloads_dir){
	Write-Host "iniciando a limpeza do diretorio: $downloads_dir" -ForegroundColor Cyan

	Get-ChildItem -Path $downloads_dir -File -Recurse | Where-Object {$_.LastWriteTime -lt (Get-Date).AddDays(-$days_old) }	| Remove-Item -Force
	
	Write-Host "Limpeza concluido." -ForegroundColor Green
}else {
	Write-Host "Erro: o diretorio $downloads_dir não foi encontrado" -ForegroundColor Red
	exit
}


# Test-Path: Verifica se o caminho existe
# Where-Object: 
# Write-Host: Permite escrever e visualizar a mensagem
# -ForegroundColor Color: Define uma cor para a mensagem
# -Force: Força o comando
