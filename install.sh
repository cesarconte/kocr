#!/usr/bin/env bash
# SPDX-FileCopyrightText: 2026 Cesar <yugurta@gmail.com>
# SPDX-License-Identifier: GPL-3.0-or-later
# install.sh: Instalador autónomo de kocr para KDE Plasma 6 / Wayland (instalación estricta en /usr)

set -eo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BIN_PATH="/usr/bin/kocr"
APPS_PATH="/usr/share/applications/org.cesar.kocr.desktop"

echo "==> Instalando kocr (Extracción de Texto OCR en un Clic) estrictamente en /usr..."

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
        echo "    sudo pacman -S --needed spectacle tesseract wl-clipboard libnotify tesseract-data-spa"
    fi
fi

# 2. Instalar binario ejecutable en /usr/bin
sudo -n install -m 755 "${SCRIPT_DIR}/bin/kocr" "$BIN_PATH"
echo "  ✓ Binario instalado en $BIN_PATH"

# 3. Instalar archivo .desktop en /usr/share/applications
sudo -n install -m 644 "${SCRIPT_DIR}/data/org.cesar.kocr.desktop" "$APPS_PATH"
echo "  ✓ Lanzador instalado en $APPS_PATH"

# 4. Registrar atajo global Meta+Shift+O en KDE Plasma
if command -v kwriteconfig6 >/dev/null 2>&1; then
    kwriteconfig6 --file kglobalshortcutsrc --group "services" --group "org.cesar.kocr.desktop" --key "_launch" "Meta+Shift+O"
    echo "  ✓ Atajo global 'Meta+Shift+O' registrado en Plasma 6"
fi

# 5. Actualizar base de datos de aplicaciones de KDE
if command -v kbuildsycoca6 >/dev/null 2>&1; then
    kbuildsycoca6 --noincremental >/dev/null 2>&1 || true
    echo "  ✓ Base de datos Sycoca de KDE actualizada"
fi

echo ""
echo "🎉 ¡Instalación de kocr completada con éxito en /usr!"
echo "   Pruébalo pulsando [Meta+Shift+O] o ejecutando 'kocr' en tu terminal."
