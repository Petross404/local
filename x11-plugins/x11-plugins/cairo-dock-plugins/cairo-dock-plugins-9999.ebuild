# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

# Launchpad repository where "cairo-dock-plugins" lives:
EBZR_REPO_URI="lp:cairo-dock-plug-ins"

# You can specify a certain revision from the repository here.
# Or comment it out to choose the latest ("live") revision.
#EBZR_REVISION="2242"


inherit cmake-utils bzr

DESCRIPTION="Official plugins for cairo-dock"
HOMEPAGE="https://launchpad.net/cairo-dock-plug-ins/"
SRC_URI=""

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""


# The next line has been stripped down somewhat from a longer version
# used in the ebuilds of other overlays.  For more info, see:
# https://bugs.launchpad.net/cairo-dock-plug-ins/+bug/922981/comments/8
IUSE="alsa exif gmenu terminal vala webkit xfce xgamma xklavier"


# Dependencies are listed here:
# http://glx-dock.org/ww_page.php?p=From%20BZR&lang=en

RDEPEND="
	~x11-misc/cairo-dock-${PV}
	x11-libs/cairo
	gnome-base/librsvg
	dev-libs/libxml2
	alsa? ( media-libs/alsa-lib )
	exif? ( media-libs/libexif )
	gmenu? ( gnome-base/gnome-menus )
	terminal? ( x11-libs/vte )
	webkit? ( >=net-libs/webkit-gtk-1.0 )
	xfce? ( xfce-base/thunar )
	xgamma? ( x11-libs/libXxf86vm )
	xklavier? ( x11-libs/libxklavier )
	vala? ( dev-lang/vala:0.12 )
"


DEPEND="${RDEPEND}
	dev-util/intltool
	sys-devel/gettext
	dev-util/pkgconfig
"


pkg_setup()
{
	ewarn ""
	ewarn ""
	ewarn "THIS IS A LIVE EBUILD, NOT AN OFFICIAL RELEASE."
	ewarn "   Thus, it may FAIL to build properly."
	ewarn "   Please do NOT report bugs to Gentoo's bugzilla."
	ewarn "   Instead, report all bugs to write2david@gmail.com"
	ewarn ""
	ewarn ""
}


src_prepare() {
	bzr_src_prepare
}


# Can't find out what the following line does (no Gentoo documentation on it?) and it seems to find the makefile and compile fine without it, so commenting it out.
#MAKE_IN_SOURCE_BUILD=true


# Actually, it looks like it is supposed to be CMAKE_IN_SOURCE_BUILD
# http://devmanual.gentoo.org/eclass-reference/cmake-utils.eclass/index.html
# But still not needed, so it is still commented out.
#CMAKE_IN_SOURCE_BUILD=true



# Next section is inspired from...
# https://bugs.launchpad.net/cairo-dock-plug-ins/+bug/922981
# and
# http://code.google.com/p/rion-overlay/source/browse/x11-misc/cairo-dock-plugins/cairo-dock-plugins-2.3.9999.ebuild?spec=svn71d4acbbb8c297b818ff886fb5dd434a6f54c377&r=71d4acbbb8c297b818ff886fb5dd434a6f54c377


src_configure() {
#	MYCMAKEARGS="-DROOT_PREFIX=${D}" cmake-utils_src_configure
	mycmakeargs="${mycmakeargs} -DROOT_PREFIX=${D} -DCMAKE_INSTALL_PREFIX=/usr"
	cmake-utils_src_configure
#	econf
}


pkg_postinst() {
	ewarn ""
	ewarn ""
	ewarn "THIS IS A LIVE EBUILD, NOT AN OFFICIAL RELEASE."
	ewarn "   Thus, it may FAIL to run properly."
	ewarn "   Please do NOT report bugs to Gentoo's bugzilla."
	ewarn "   Instead, report all bugs to write2david@gmail.com"
	ewarn ""
	ewarn ""
}