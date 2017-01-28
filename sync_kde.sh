#! /bin/bash

if [ "$1" == "-rm" ]; then
   prog_name="$0"
   if whiptail --yesno "Do you want to delete the repo?\nSelecting Yes, will not erase this script." 10 50 ;then
	ls | grep [0-9\-] | xargs  rm -rv
        ls | grep package | xargs  rm -rv
	rm -rv eclass  licenses  metadata  profiles Tools
	mkdir metadata && mkdir profiles && touch ./metadata/layout.conf && touch ./profiles/repo_name
        echo "local" > ./profiles/repo_name
        echo "masters = gentoo" > ./metadata/layout.conf && echo "cache-formats = md5-dict" >> ./metadata/layout.conf
        exit 0;
    else
        echo "Didn't delete anything."
    fi
fi
#wget -P ./dev-util -r -nH --cut-dirs=2 --no-parent --reject="index.html*" -e robots=off  http://data.gpo.zugaina.org/kde/dev-util/
rsync -ahzv --progress --exclude '.git*' --exclude 'repo_name' --exclude 'layout.conf' rsync://data.gpo.zugaina.org/kde-portage/dev-util .
rsync -ahzv --progress --exclude '.git*' --exclude 'repo_name' --exclude 'layout.conf' rsync://data.gpo.zugaina.org/kde-portage/eclass .
rsync -ahzv --progress --exclude '.git*' --exclude 'repo_name' --exclude 'layout.conf' rsync://data.gpo.zugaina.org/qt-portage/dev-qt .
rsync -ahzv --progress --exclude '.git*' --exclude 'repo_name' --exclude 'layout.conf' rsync://data.gpo.zugaina.org/qt-portage/eclass .
rsync -ahzv --progress --exclude '.git*' --exclude 'repo_name' --exclude 'layout.conf' rsync://data.gpo.zugaina.org/qt-portage/metadata .
rsync -ahzv --progress --exclude '.git*' --exclude 'repo_name' --exclude 'layout.conf' rsync://data.gpo.zugaina.org/qt-portage/profiles .
echo "local" > ./profiles/repo_name
rsync -ahzv --progress --exclude '.git*' --exclude 'repo_name' --exclude 'layout.conf' rsync://data.gpo.zugaina.org/sage-on-gentoo-portage/ .
rsync -ahzv --progress --exclude '.git*' --exclude 'repo_name' --exclude 'layout.conf' rsync://data.gpo.zugaina.org/mv-portage/sys-fs .
rsync -ahzv --progress --exclude '.git*' --exclude 'repo_name' --exclude 'layout.conf' rsync://data.gpo.zugaina.org/mv-portage/sys-block .
rsync -ahzv --progress --exclude '.git*' --exclude 'repo_name' --exclude 'layout.conf' rsync://data.gpo.zugaina.org/mv-portage/eclass .
echo "local" > ./profiles/repo_name
rsync -ahzv --progress --exclude '.git*' --exclude 'repo_name' --exclude 'layout.conf' --exclude 'gsl' rsync://data.gpo.zugaina.org/bleeding-edge-portage/ .
rsync -ahzv --progress --exclude '.git*' --exclude 'repo_name' --exclude 'layout.conf' rsync://data.gpo.zugaina.org/gentoo-el-portage/media-tv .
echo "local" > ./profiles/repo_name
rsync -ahzv --progress --exclude '.git*' --exclude 'repo_name' --exclude 'layout.conf' rsync://data.gpo.zugaina.org/write2David-portage/x11-misc ./x11-misc
rsync -ahzv --progress --exclude '.git*' --exclude 'repo_name' --exclude 'layout.conf' rsync://data.gpo.zugaina.org/write2David-portage/x11-plugins ./x11-plugins
rsync -ahzv --progress --exclude '.git*' --exclude 'repo_name' --exclude 'layout.conf' rsync://data.gpo.zugaina.org/sabayon-portage/x11-misc/cairo-dock ./x11-misc
rsync -ahzv --progress --exclude '.git*' --exclude 'repo_name' --exclude 'layout.conf' rsync://data.gpo.zugaina.org/sabayon-portage/x11-plugins/cairo-dock-plugins ./x11-plugins

rm -rv sci-libs/gsl || exit -1;
echo "masters = gentoo" > ./metadata/layout.conf && echo "cache-formats = md5-dict" >> ./metadata/layout.conf || exit -2;
touch ./profiles/repo_name && echo "local" > ./profiles/repo_name || exit -3;
repoman manifest && emerge --regen 
emerge --metadata
repoman --digest=y -d full 
egencache --jobs=2 --update --repo local
