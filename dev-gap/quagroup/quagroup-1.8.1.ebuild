# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="a package for doing computations with quantum groups"
HOMEPAGE="http://www.gap-system.org/Packages/${PN}.html"
SLOT="0"
SRC_URI="https://github.com/gap-packages/${PN}/releases/download/v${PV}/${P}.tar.gz"

LICENSE="GPL-2+"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=sci-mathematics/gap-4.10.1"

DOCS="README.md CHANGES"

src_install(){
	default

	insinto /usr/share/gap/pkg/"${PN}"
	doins -r doc gap
	doins *.g
}
