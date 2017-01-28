# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

PYTHON_COMPAT=( python2_7 )
PYTHON_REQ_USE="sqlite"

inherit python-any-r1

MY_P="elliptic_curves-${PV}"

DESCRIPTION="Sage's elliptic curves databases"
HOMEPAGE="http://www.sagemath.org"
SRC_URI="mirror://sageupstream/elliptic_curves/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux ~x64-macos"
IUSE=""

RESTRICT="mirror"

DEPEND=""
RDEPEND=""

S="${WORKDIR}"/${MY_P}

src_prepare(){
	# copy a slightly modified spkg-install. We used to have it in the tarball
	# but when we changed to new style git spkg tarball we lost the file
	cp "${FILESDIR}"/spkg-install .

	default
}

src_install() {
	SAGE_SHARE="${ED}/usr/share/sage" "${PYTHON}" spkg-install
}