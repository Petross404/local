# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit elisp-common eutils git-r3 qmake-utils

SITEFILE="50${PN}-gentoo.el"

DESCRIPTION="The Programmers Solid 3D CAD Modeller"
HOMEPAGE="http://www.openscad.org/"
EGIT_REPO_URI="https://github.com/openscad/openscad.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="emacs qt4 +qt5"

DEPEND="media-gfx/opencsg
	sci-mathematics/cgal
	qt5? (
		dev-qt/qtcore:5
		dev-qt/qtgui:5[-gles2]
		dev-qt/qtopengl:5
	)
	qt4? (
		dev-qt/qtcore:4
		dev-qt/qtgui:4[-egl]
		dev-qt/qtopengl:4[-egl]
	)
	dev-cpp/eigen:3
	dev-libs/glib:2
	dev-libs/gmp:0=
	dev-libs/mpfr:0=
	dev-libs/boost:=
	media-libs/fontconfig:1.0
	media-libs/freetype:2
	media-libs/glew:*
	media-libs/harfbuzz
	x11-libs/qscintilla:=[qt4=,qt5=]
	emacs? ( virtual/emacs )"
RDEPEND="${DEPEND}"

REQUIRED_USE="^^ ( qt4 qt5 )"

src_prepare() {
	sed -i "s/\/usr\/local/\/usr/g" ${PN}.pro || die

	default
}

src_configure() {
	if use qt5; then
		eqmake5 "${PN}.pro"
	else
		eqmake4 "${PN}.pro"
	fi
}

src_compile() {
	default

	if use emacs ; then
		elisp-compile contrib/*.el
	fi
}

src_install() {
	emake install INSTALL_ROOT="${D}"

	if use emacs; then
		elisp-site-file-install "${FILESDIR}/${SITEFILE}"
		elisp-install ${PN} contrib/*.el contrib/*.elc
	fi

	einstalldocs
}
