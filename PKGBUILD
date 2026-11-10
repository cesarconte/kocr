# Maintainer: Cesar <yugurta@gmail.com>

pkgname=kocr
pkgver=1.0.0
pkgrel=1
pkgdesc="Instant One-Click Screen OCR for KDE Plasma 6 on Wayland (CachyOS Linux)"
arch=('any')
url="https://github.com/cesarconte/kocr"
license=('GPL-3.0-or-later')
depends=('spectacle' 'tesseract' 'wl-clipboard' 'libnotify')
optdepends=('tesseract-data-spa: Spanish language support')

package() {
    install -Dm755 "${srcdir}/../bin/kocr" "${pkgdir}/usr/bin/kocr"
    install -Dm644 "${srcdir}/../data/org.cesar.kocr.desktop" "${pkgdir}/usr/share/applications/org.cesar.kocr.desktop"
}
