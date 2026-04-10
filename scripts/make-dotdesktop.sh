#!/bin/bash

set -euo pipefail



# ── Argumentos ─────────────────────────────────────────────────────────────────
[[ $# -lt 2 ]] && usage

APP_NAME="$1"
EXEC_PATH="$2"

# ── Validaciones ───────────────────────────────────────────────────────────────
if [[ ! -e "$EXEC_PATH" ]]; then
    echo "Error: el ejecutable '$EXEC_PATH' no existe." >&2
    exit 1
fi

if [[ ! -x "$EXEC_PATH" ]]; then
    echo "Advertencia: '$EXEC_PATH' no tiene permisos de ejecución." >&2
fi

# Convertir a ruta absoluta
EXEC_PATH="$(realpath "$EXEC_PATH")"

# ── Directorio XDG ─────────────────────────────────────────────────────────────
DESKTOP_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/applications"
mkdir -p "$DESKTOP_DIR"

# ── Nombre de archivo (sin espacios ni caracteres raros) ───────────────────────
FILE_NAME="$(echo "$APP_NAME" | tr '[:upper:]' '[:lower:]' | tr -cs '[:alnum:]' '-' | sed 's/-*$//')"
DESKTOP_FILE="$DESKTOP_DIR/${FILE_NAME}.desktop"

# ── Crear el .desktop ──────────────────────────────────────────────────────────
cat > "$DESKTOP_FILE" <<EOF
[Desktop Entry]
Version=1.0
Type=Application
Name=$APP_NAME
Exec=$EXEC_PATH
Terminal=false
EOF

chmod 644 "$DESKTOP_FILE"

echo "✓ Entrada creada: $DESKTOP_FILE"


