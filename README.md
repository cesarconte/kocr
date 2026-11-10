# 📝 kocr: One-Click Screen OCR for KDE Plasma 6 (Wayland)

Herramienta nativa y ultraligera de extracción de texto de pantalla en un clic para **KDE Plasma 6** en **Wayland (CachyOS Linux)**.

Inspirada en el flujo de trabajo de Shottr y CleanShot X en macOS: pulsa un atajo global, selecciona un área rectangular con el ratón y obtén el texto limpio en tu portapapeles al instante con una notificación de confirmación.

---

## ✨ Características

- ⚡ **Latencia Mínima:** Captura instantánea por capas de Wayland con Spectacle 6 (`layer-shell`) sin ventanas intermedias.
- 🧠 **Cero Desgaste de Disco:** Procesa la imagen directamente en memoria RAM (`/dev/shm`).
- 🌐 **OCR Bilingüe Completo:** Motor Tesseract 5.5 con soporte para Español (acentos `á, é, í, ó, ú`, diéresis, `ñ`, `¿`, `¡`) e Inglés.
- 📋 **Portapapeles Nativo:** Copiado atómico a `wl-copy`.
- 🔔 **Notificación OSD:** Vista previa del texto extraído en Plasma.
- 📱 **Integración Plasma Deck:** Activación directa desde el panel táctil en el teléfono móvil.

---

## ⌨️ Atajo de Teclado Predeterminado

| Acción | Atajo |
|---|---|
| **Extraer Texto de Pantalla** | `Meta + Shift + O` |

---

## 🚀 Instalación en un nuevo PC

Clona el repositorio y ejecuta el instalador automático:

```bash
git clone https://github.com/cesarconte/kocr.git
cd kocr
./install.sh
```

El script verificará las dependencias (`spectacle`, `tesseract`, `wl-clipboard`, `libnotify`), instalará el binario en `~/.local/bin`, configurará los diccionarios en `~/.local/share/tessdata/` y registrará el atajo global `Meta+Shift+O` en KDE Plasma.

---

## 🗑️ Desinstalación

```bash
cd kocr
./uninstall.sh
```

---

## 📄 Licencia

GPL-3.0-or-later © 2026 Cesar
