Write-Host "Organizador de arquivos" -ForegroundColor Cyan

# Diretorio onde estao os arquivos que devem ser movidos
$downloadsDir = "C:\Users\gustavo.vargens\Downloads"

# Base para mover os arquivos de Downloads
$DestinationBase="C:\Users\gustavo.vargens"

# coloque os nomes corretamente, se n o programa nao rastreia corretamente
$extensions = @{
'Pictures'=@('.jpg', '.jpeg', '.png', '.gif', '.webp') 
'Documents'=@('.pdf', '.doc', '.docx', '.txt', '.xlsx')
'Videos'=@('.mp4', '.avi', '.mov', '.mkv')
'Music'=@('.mp3', '.wav', '.flac')
'Desktop'=@('.zip', '.rar', '.7z')
}

# pega os arquivos que estao em downloads
$fileList = Get-ChildItem -Path $downloadsDir -File

foreach($file in $fileList){

# Pega a extensão corretamente com ponto e deixa em lower case
$extension=$file.Extension.ToLower(); 	

# variavel para verificar se o arquivo foi movido com sucesso
$isMove=$false

foreach($par in $extensions.GetEnumerator()){

$fileNameDestination= $par.Key # Pictures, Documents, Videos etc..
$extsTarget = $par.Value # .jpg, .pdf, .mp4 etc..

if ($extension -in $extsTarget){

# Monta o caminho final (ex: C:\Users\gustavo.vargens\Pictures)
$finalPath = Join-Path -Path $DestinationBase -ChildPath $fileNameDestination

# Se o diretorio nao existir, o programa cria
if(-not(Test-Path $finalPath)){
$null = New-Item -Path $finalPath -ItemType Directory -Force
}

try{
# tenta mover o arquivo para o caminho montado (finalPath)
Move-Item -Path $file.FullName -Destination $finalPath -ErrorAction Stop
Write-Host "Movido: $($file.Name) -> $fileNameDestination."

}catch{

Write-Host "Erro ao mover $($file.Name): $_" -ForegroundColor Red

}
# a mudanca foi bem sucedida
$isMove=$true

break

}
}
# Se a extensao nao foi mapeada cai nesse if
if (-not $isMove) {
        Write-Host "Ignorado: $($file.Name) (extensao nao mapeada)" -ForegroundColor Gray
    }
}