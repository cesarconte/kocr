#!/usr/bin/env bash
# SPDX-FileCopyrightText: 2026 Cesar <yugurta@gmail.com>
# SPDX-License-Identifier: GPL-3.0-or-later
# install.sh: Instalador autónomo de kocr para KDE Plasma 6 / Wayland

set -eo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BIN_DIR="${HOME}/.local/bin"
APPS_DIR="${HOME}/.local/share/applications"
TESS_DIR="${HOME}/.local/share/tessdata"

echo "==> Instalando kocr (Extracción de Texto OCR en un Clic)..."

# 1. Comprobar dependencias del sistema
MISSING_DEPS=()
for dep in spectacle tesseract wl-copy notify-send; do
    if ! command -v "$dep" >/dev/null 2>&1; then
        MISSING_DEPS+=("$dep")
    fi
done

if [ ${#MISSING_DEPS[@]} -gt 0 ]; then
    echo "⚠️  Faltan las siguientes dependencias: ${MISSING_DEPS[*]}"
    if command -v pacman >/dev/null 2>&1; then
        echo "--> Puedes instalarlas en CachyOS/Arch con:"
        echo "    sudo pacman -S --needed spectacle tesseract wl-clipboard libnotify"
    fi
fi

# 2. Instalar binario ejecutable
mkdir -p "$BIN_DIR"
install -m 755 "${SCRIPT_DIR}/bin/kocr" "${BIN_DIR}/kocr"
echo "  ✓ Binario instalado en ${BIN_DIR}/kocr"

# 3. Instalar archivo .desktop
mkdir -p "$APPS_DIR"
install -m 644 "${SCRIPT_DIR}/data/org.cesar.kocr.desktop" "${APPS_DIR}/org.cesar.kocr.desktop"
echo "  ✓ Lanzador instalado en ${APPS_DIR}/org.cesar.kocr.desktop"

# 4. Configurar modelos de lenguaje de Tesseract (Español + Inglés)
mkdir -p "$TESS_DIR"
if [ ! -f "${TESS_DIR}/spa.traineddata" ]; then
    if [ -f "/usr/share/tessdata/spa.traineddata" ]; then
        ln -sf "/usr/share/tessdata/spa.traineddata" "${TESS_DIR}/spa.traineddata"
    else
        echo "  --> Descargando modelo de español (tessdata_fast spa.traineddata)..."
        curl -sSL -o "${TESS_DIR}/spa.traineddata" "https://github.com/tesseract-ocr/tessdata_fast/raw/main/spa.traineddata" || true
    fi
fi

if [ -f "/usr/share/tessdata/eng.traineddata" ] && [ ! -e "${TESS_DIR}/eng.traineddata" ]; then
    ln -sf "/usr/share/tessdata/eng.traineddata" "${TESS_DIR}/eng.traineddata"
fi
if [ -f "/usr/share/tessdata/osd.traineddata" ] && [ ! -e "${TESS_DIR}/osd.traineddata" ]; then
    ln -sf "/usr/share/tessdata/osd.traineddata" "${TESS_DIR}/osd.traineddata"
fi
echo "  ✓ Modelos OCR listos en ${TESS_DIR}"

# 5. Registrar atajo global Meta+Shift+O en KDE Plasma
if command -v kwriteconfig6 >/dev/null 2>&1; then
    kwriteconfig6 --file kglobalshortcutsrc --group "services" --group "org.cesar.kocr.desktop" --key "_launch" "Meta+Shift+O"
    echo "  ✓ Atajo global 'Meta+Shift+O' registrado en Plasma 6"
fi

# 6. Actualizar base de datos de aplicaciones de KDE
if command -v kbuildsycoca6 >/dev/null 2>&1; then
    kbuildsycoca6 --noincremental >/dev/null 2>&1 || true
    echo "  ✓ Base de datos Sycoca de KDE actualizada"
fi

echo ""
echo "🎉 ¡Instalación de kocr completada con éxito!"
echo "   Pruébalo pulsando [Meta+Shift+O] o ejecutando 'kocr' en tu terminal."
