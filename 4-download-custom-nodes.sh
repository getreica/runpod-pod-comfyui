#!/bin/bash

# Some custom nodes need this env variable
COMFYUI_PATH=/comfyui

# File contenente l'elenco dei nodi da scaricare
NODES_FILE="/node_list.txt"

# Cartella in cui verranno scaricati i nodi
DOWNLOAD_DIR="$COMFYUI_PATH/custom_nodes"
echo "I nodi verranno scaricati qui $DOWNLOAD_DIR"

# Entro nella cartella di download
cd "$DOWNLOAD_DIR"

# Legge ogni nodo dal file di testo
while IFS= read -r GITHUB_URL; do
    if [[ -n "$GITHUB_URL" ]]; then
        # prendi l'ultima parte del nome del nodo (dopo l'ultimo /)
        NODE_NAME=$(basename $GITHUB_URL)
        
        echo "Scaricamento del nodo: $GITHUB_URL"
        
        # Verifica se il nodo esiste già
        if [[ -d "$DOWNLOAD_DIR/$NODE_NAME" ]]; then
            echo "Il nodo $NODE_NAME esiste già, saltato."
            continue
        fi
        
        # Clona il repository del nodo (supponendo che sia su GitHub)
        git clone $GITHUB_URL --recursive
        
        # Verifica se il file requirements.txt esiste e installa le dipendenze
        if [[ -f "$DOWNLOAD_DIR/$NODE_NAME/requirements.txt" ]]; then
            echo "Installazione delle dipendenze per $NODE_NAME"
            pip3 install -r "$DOWNLOAD_DIR/$NODE_NAME/requirements.txt"
        else
            echo "File requirements.txt non trovato per $NODE_NAME, saltato."
        fi
    fi
done < "$NODES_FILE"

echo "Processo completato."
