#!/usr/bin/env bash
# SPDX-FileCopyrightText: 2026 Cesar <yugurta@gmail.com>
# SPDX-License-Identifier: GPL-3.0-or-later

set -eo pipefail

echo "==> Desinstalando kocr..."

rm -f "${HOME}/.local/bin/kocr"
rm -f "${HOME}/.local/share/applications/org.cesar.kocr.desktop"

if command -v kwriteconfig6 >/dev/null 2>&1; then
    kwriteconfig6 --file kglobalshortcutsrc --group "services" --group "org.cesar.kocr.desktop" --key "_launch" "none"
fi

if command -v kbuildsycoca6 >/dev/null 2>&1; then
    kbuildsycoca6 --noincremental >/dev/null 2>&1 || true
fi

echo "✓ Desinstalación completada."
