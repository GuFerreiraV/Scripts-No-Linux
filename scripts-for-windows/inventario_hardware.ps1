Write-Host "Informacoes do sistema" -ForegroundColor Cyan

# BIOS
$bios = Get-CimInstance -ClassName Win32_BIOS
$biosInfo = [PSCustomObject]@{
	Categoria = "Bios"
	Fabricante = $bios.Manufacturer
	Versao = $bios.SMBIOSBIOSVersion
	DataLancamento = $bios.ReleaseDate
	SerialNumber = $bios.SerialNumber
}

# Placa-mãe
$baseBios = Get-CimInstance -ClassName Win32_BaseBoard
$baseInfo = [PSCustomObject]@{
	Categoria = "Placa-mae"
	Produto = $baseBios.Product
	Fabricante = $baseBios.Manufacturer
	Versao = $baseBios.Version
	SerialNumber = $baseBios.SerialNumber
}

# Memoria RAM
$ram = Get-CimInstance -ClassName Win32_PhysicalMemory
$totalRAMGB = ($ram | Measure-Object -Property Capacity -Sum).Sum / 1GB
$ramDetails = $ram | ForEach-Object{
	"Pente: $($_.Capacity/1GB)GB | Velocidade: $($_.Speed)MHz | Fabricante: $($_.Manufacturer)"
}

# CPU
$processor = Get-CimInstance -ClassName Win32_Processor
$processorInfo = [PSCustomObject]@{
	Nome = $processor.Name
	Nucleos = $processor.NumberOfCores
	Threads = $processor.NumberOfLogicalProcessors
}


Write-Host "`n[ BIOS ]" -ForegroundColor Yellow
$biosInfo | Format-List

Write-Host "`n[ Placa-mae ]" -ForegroundColor Yellow
$baseInfo | Format-List

Write-Host "`n[ Memoria RAM ]" -ForegroundColor Yellow
$ramDetails | Format-List

Write-Host "`n[ Processador ]" -ForegroundColor Yellow
$processorInfo | Format-List


Read-Host "`nPressione Enter para sair..."