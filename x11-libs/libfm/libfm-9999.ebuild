# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools git-r3 vala xdg-utils

DESCRIPTION="A library for file management"
HOMEPAGE="http://pcmanfm.sourceforge.net/"
EGIT_REPO_URI="https://github.com/lxde/${PN}"

LICENSE="GPL-2"
SLOT="0/5.1.1" #copy ABI_VERSION because it seems upstream change it randomly
KEYWORDS=""
IUSE="+automount debug doc examples exif +gtk +gtk3 udisks vala"

COMMON_DEPEND="dev-libs/glib:2
	gtk3? ( x11-libs/gtk+:3 )
	!gtk3? ( gtk? ( x11-libs/gtk+:2 ) )
	lxde-base/menu-cache
	x11-libs/libfm-extra"
RDEPEND="${COMMON_DEPEND}
	!lxde-base/lxshortcut
	x11-misc/shared-mime-info
	automount? (
		udisks? ( gnome-base/gvfs[udev,udisks] )
		!udisks? ( gnome-base/gvfs[udev] )
	)
	exif? ( media-libs/libexif )"
DEPEND="${COMMON_DEPEND}
	vala? ( $(vala_depend) )
	doc? ( dev-util/gtk-doc )
	dev-util/intltool
	virtual/pkgconfig
	sys-devel/gettext"

DOCS=( AUTHORS TODO )

REQUIRED_USE="udisks? ( automount ) doc? ( gtk )"

src_prepare() {
	eapply ${FILESDIR}/libfm-eacces.patch

	if ! use doc; then
		sed -ie '/^SUBDIR.*=/s#docs##' "${S}"/Makefile.am || die "sed failed"
		sed -ie '/^[[:space:]]*docs/d' configure.ac || die "sed failed"
	else
		gtkdocize --copy || die
	fi
	sed -i -e "s:-O0::" -e "/-DG_ENABLE_DEBUG/s: -g::" \
		configure.ac || die "sed failed"

	intltoolize --force --copy --automake || die
	#disable unused translations. Bug #356029
	for trans in app-chooser ask-rename exec-file file-prop preferred-apps \
		progress;do
		echo "data/ui/"${trans}.ui >> po/POTFILES.in
	done
	#Remove -Werror for automake-1.12. Bug #421101
	sed -i "s:-Werror::" configure.ac || die

	# subslot sanity check
	local sub_slot=${SLOT#*/}
	local libfm_major_abi=$(sed -rne '/ABI_VERSION/s:.*=::p' src/Makefile.am | tr ':' '.')

	if [[ ${sub_slot} != ${libfm_major_abi} ]]; then
		eerror "Ebuild sub-slot (${sub_slot}) does not match ABI_VERSION(${libfm_major_abi})"
		eerror "Please update SLOT variable as follows:"
		eerror "    SLOT=\"${SLOT%%/*}/${libfm_major_abi}\""
		eerror
		die "sub-slot sanity check failed"
	fi

	eautoreconf
	rm -r autom4te.cache || die
	use vala && export VALAC="$(type -p valac-$(vala_best_api_version))"
	default
}

src_configure() {
	econf \
		--sysconfdir="${EPREFIX}/etc" \
		--disable-dependency-tracking \
		--disable-static \
		$(use_enable examples demo) \
		$(use_enable exif) \
		$(use_enable debug) \
		$(use_enable udisks) \
		$(use_enable vala actions) \
		$(use_with gtk) \
		$(usex gtk3 --with-gtk=3 "" "" "") \
		$(use_enable doc gtk-doc) \
		--with-html-dir=/usr/share/doc/${PF}/html
}

src_install() {
	default
	find "${D}" -name '*.la' -exec rm -f '{}' +
	# Sometimes a directory is created instead of a symlink. No idea why...
	# It is wrong anyway. We expect a libfm-1.0 directory and then a libfm
	# symlink to it.
	if [[ -h ${D}/usr/include/${PN} || -d ${D}/usr/include/${PN} ]]; then
		rm -r "${D}"/usr/include/${PN}
	fi
	# Remove files installed by split-off libfm-extra package
	rm "${D}"/usr/include/libfm-1.0/fm-{extra,version,xml-file}.h
	rm "${D}"/usr/$(get_libdir)/libfm-extra*
	rm "${D}"/usr/$(get_libdir)/pkgconfig/libfm-extra.pc
}

pkg_preinst() {
	# Resolve the symlink mess. Bug #439570
	[[ -d "${ROOT}"/usr/include/${PN} ]] && \
		rm -rf "${ROOT}"/usr/include/${PN}
	if [[ -d "${D}"/usr/include/${PN}-1.0 ]]; then
		cd "${D}"/usr/include
		ln -s --force ${PN}-1.0 ${PN}
	fi
}

pkg_postinst() {
	xdg_mimeinfo_database_update
}

pkg_postrm() {
	xdg_mimeinfo_database_update
}
