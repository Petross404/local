#! /bin/bash
PWD="/var/lib/layman/local"
if [ "$1" == "-rm" ]; then
   prog_name="$0"
   if whiptail --yesno "Do you want to delete the repo?\nSelecting Yes, will not erase this script." 10 50 ;then
		ls /var/lib/layman/local/ | grep [0-9\-] | xargs  rm -rv
        ls /var/lib/layman/local/ | grep package | xargs  rm -rv
		rm -rv /var/lib/layman/local/eclass  /var/lib/layman/local/licenses  /var/lib/layman/local/metadata  /var/lib/layman/local/profiles /var/lib/layman/local/Tools
		mkdir /var/lib/layman/local/metadata ; mkdir /var/lib/layman/local/profiles ; touch /var/lib/layman/local/layout.conf ; touch /var/lib/layman/local/profiles/repo_name
        echo "local" > /var/lib/layman/local/profiles/repo_name
        echo "masters = gentoo" > /var/lib/layman/local/metadata/layout.conf && echo "cache-formats = md5-dict" >> /var/lib/layman/local/metadata/layout.conf
        exit 0;
    else
        echo "Didn't delete anything."
    fi
fi
cd /var/lib/layman/local/
#wget -P ./dev-util -r -nH --cut-dirs=2 --no-parent --reject="index.html*" -e robots=off  http://data.gpo.zugaina.org/kde/dev-util/
#rsync -ahzv --progress --exclude '.git*' --exclude 'repo_name' --exclude 'layout.conf' rsync://data.gpo.zugaina.org/pentoo-portage/dev-util/edb "${PWD}"/dev-util/
rsync -ahzv --progress --exclude '.git*' --exclude 'repo_name' --exclude 'layout.conf' rsync://data.gpo.zugaina.org/kde-portage/dev-util "${PWD}"
rsync -ahzv --progress --exclude '.git*' --exclude 'repo_name' --exclude 'layout.conf' rsync://data.gpo.zugaina.org/kde-portage/kde-apps/kcachegrind "${PWD}"/kde-apps/
rsync -ahzv --progress --exclude '.git*' --exclude 'repo_name' --exclude 'layout.conf' rsync://data.gpo.zugaina.org/kde-portage/eclass "${PWD}"
#rsync -ahzv --progress --exclude '.git*' --exclude 'repo_name' --exclude 'layout.conf' rsync://data.gpo.zugaina.org/qt-portage/dev-qt "${PWD}"
#rsync -ahzv --progress --exclude '.git*' --exclude 'repo_name' --exclude 'layout.conf' rsync://data.gpo.zugaina.org/qt-portage/eclass "${PWD}"
#rsync -ahzv --progress --exclude '.git*' --exclude 'repo_name' --exclude 'layout.conf' rsync://data.gpo.zugaina.org/qt-portage/metadata "${PWD}"
#rsync -ahzv --progress --exclude '.git*' --exclude 'repo_name' --exclude 'layout.conf' rsync://data.gpo.zugaina.org/qt-portage/profiles "${PWD}"
echo "local" > /var/lib/layman/local/profiles/repo_name
rsync -ahzv --progress --exclude '.git*' --exclude 'repo_name' --exclude 'layout.conf' rsync://data.gpo.zugaina.org/sage-on-gentoo-portage "${PWD}"
rsync -ahzv --progress --exclude '.git*' --exclude 'repo_name' --exclude 'layout.conf' rsync://data.gpo.zugaina.org/mv-portage/app-shells/runtitle  "S{PWD}"/app-shells/
rsync -ahzv --progress --exclude '.git*' --exclude 'repo_name' --exclude 'layout.conf' rsync://data.gpo.zugaina.org/mv-portage/sys-fs "${PWD}"
rsync -ahzv --progress --exclude '.git*' --exclude 'repo_name' --exclude 'layout.conf' rsync://data.gpo.zugaina.org/mv-portage/sys-block "${PWD}"
rsync -ahzv --progress --exclude '.git*' --exclude 'repo_name' --exclude 'layout.conf' rsync://data.gpo.zugaina.org/mv-portage/eclass "${PWD}"
rsync -ahzv --progress --exclude '.git*' --exclude 'repo_name' --exclude 'layout.conf' rsync://data.gpo.zugaina.org/science-portage/sci-misc "${PWD}"
rsync -ahzv --progress --exclude '.git*' --exclude 'repo_name' --exclude 'layout.conf' rsync://data.gpo.zugaina.org/science-portage/sci-libs "${PWD}"
rsync -ahzv --progress --exclude '.git*' --exclude 'repo_name' --exclude 'layout.conf' rsync://data.gpo.zugaina.org/science-portage/eclass "${PWD}"
rsync -ahzv --progress --exclude '.git*' --exclude 'repo_name' --exclude 'layout.conf' rsync://data.gpo.zugaina.org/science-portage/licenses "${PWD}"
echo "local" > /var/lib/layman/local/profiles/repo_name
rsync -ahzv --progress --exclude '.git*' --exclude 'repo_name' --exclude 'layout.conf' --exclude 'gsl' rsync://data.gpo.zugaina.org/bleeding-edge-portage/ "${PWD}"
rsync -ahzv --progress --exclude '.git*' --exclude 'repo_name' --exclude 'layout.conf' rsync://data.gpo.zugaina.org/jorgicio-portage/sys-apps/anything-sync-daemon "${PWD}"/sys-apps/
#rsync -ahzv --progress --exclude '.git*' --exclude 'repo_name' --exclude 'layout.conf' rsync://data.gpo.zugaina.org/gentoo-el-portage/media-tv "${PWD}"
#rsync -ahzv --progress --exclude '.git*' --exclude 'repo_name' --exclude 'layout.conf' rsync://data.gpo.zugaina.org/gentoo-el-portage/net-im "${PWD}"

echo "local" > /var/lib/layman/local/profiles/repo_name

#rsync -ahzv --progress --exclude '.git*' --exclude 'repo_name' --exclude 'layout.conf' rsync://data.gpo.zugaina.org/write2David-portage/x11-misc "${PWD}"/x11-misc
#rsync -ahzv --progress --exclude '.git*' --exclude 'repo_name' --exclude 'layout.conf' rsync://data.gpo.zugaina.org/write2David-portage/x11-plugins "${PWD}"/x11-plugins
rsync -ahzv --progress --exclude '.git*' --exclude 'repo_name' --exclude 'layout.conf' rsync://data.gpo.zugaina.org/sabayon-portage/x11-misc/cairo-dock "${PWD}"/x11-misc
rsync -ahzv --progress --exclude '.git*' --exclude 'repo_name' --exclude 'layout.conf' rsync://data.gpo.zugaina.org/sabayon-portage/x11-plugins/cairo-dock-plugins "${PWD}"/x11-plugins
cd /var/lib/layman/local/
#rm -rv "${PWD}"/sci-libs/gsl || exit -1;
rm README.*
echo "masters = gentoo" > /var/lib/layman/local/metadata/layout.conf && echo "cache-formats = md5-dict" >> /var/lib/layman/local/metadata/layout.conf || exit -2;
touch /var/lib/layman/local/profiles/repo_name && echo "local" > /var/lib/layman/local/profiles/repo_name || exit -3;

repoman manifest && emerge --regen 
emerge --metadata
repoman --digest=y -d full 
egencache --jobs=2 --update --repo local
