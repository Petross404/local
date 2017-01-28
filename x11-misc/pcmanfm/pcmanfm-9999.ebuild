# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PLOCALES="ar be bg bn ca cs da de el en_GB es et eu fa fi fo fr gl he hr hu id
is it ja kk km ko lg lt lv ms nl pa pl pt pt_BR ro ru si sk sl sr sr@latin sv
te th tr tt_RU ug uk vi zh_CN zh_TW"
PLOCALE_BACKUP="en_GB"

inherit autotools eutils fdo-mime git-r3 l10n readme.gentoo

DESCRIPTION="Fast lightweight tabbed filemanager"
HOMEPAGE="http://pcmanfm.sourceforge.net/"
EGIT_REPO_URI="git://pcmanfm.git.sourceforge.net/gitroot/pcmanfm/${PN}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="debug +gtk3"

RDEPEND="dev-libs/glib:2
	gtk3? ( x11-libs/gtk+:3 )
	!gtk3? ( x11-libs/gtk+:2 )
	lxde-base/menu-cache
	x11-misc/shared-mime-info
	=x11-libs/libfm-${PV}:=[gtk(+),gtk3=]
	virtual/eject
	virtual/freedesktop-icon-theme"
DEPEND="${RDEPEND}
	dev-util/intltool
	virtual/pkgconfig
	sys-devel/gettext"

DOCS=( AUTHORS )

DOC_CONTENTS="PCmanFM can optionally support the menu://applications/
	location. You should install lxde-base/lxmenu-data for that functionality."

src_prepare() {
	intltoolize --force --copy --automake || die
	# drop -O0 -g. Bug #382265 and #382265
	sed -i -e "s:-O0::" -e "/-DG_ENABLE_DEBUG/s: -g::" "${S}"/configure.ac || die
	#Remove -Werror for automake-1.12. Bug #421101
	sed -i "s:-Werror::" configure.ac || die
	eautoreconf
	export LINGUAS="${LINGUAS:-${PLOCALE_BACKUP}}"
	l10n_get_locales > "${S}"/po/LINGUAS
	eapply_user
}

src_configure() {
	econf --sysconfdir="${EPREFIX}/etc" $(use_enable debug) \
		$(usex gtk3 --with-gtk=3 "" "" "")
}

pkg_postinst() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
	readme.gentoo_print_elog
}

pkg_postrm() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
}
