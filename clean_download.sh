#!/bin/bash

# Define o caminho do diretório Downloads
DOWNLOADS_DIR="$HOME/Downloads"

# Define o número de dias para considerar um arquivo 'antigo'
DAYS_OLD="+7"

# Verifica se o diretório Downloads existe
if [ -d "$DOWNLOADS_DIR" ]; then
    echo "Iniciando a limpeza do diretório: $DOWNLOADS_DIR"
    
    # Encontra e deleta arquivos com mais de 7 dias
    # -type f: apenas arquivos regulares
    # -mtime $DAYS_OLD: arquivos modificados há mais de 7 dias
    # -delete: deleta os itens encontrados
    find "$DOWNLOADS_DIR" -type f -mtime "$DAYS_OLD" -delete
    
    # Encontra e deleta diretórios vazios com mais de 7 dias (opcional, mas bom para limpeza)
    # -type d: apenas diretórios
    # -mtime $DAYS_OLD: diretórios modificados há mais de 7 dias
    # -empty: assegura que apenas diretórios vazios sejam considerados para deleção
    find "$DOWNLOADS_DIR" -type d -mtime "$DAYS_OLD" -empty -delete
    
    echo "Limpeza concluída."
else
    echo "Erro: O diretório $DOWNLOADS_DIR não foi encontrado."
    exit 1
fi
