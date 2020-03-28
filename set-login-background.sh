#!/usr/bin/sh

IMAGE=$1

if [ "$IMAGE" = "" ]; then
  IMAGE=$(
    dbus-launch gsettings get org.gnome.desktop.screensaver picture-uri |
    sed -e "s/'//g" |
    sed -e "s/^file:\/\///g"
  )
fi

if [ ! -f $IMAGE ]; then
  echo "unknown IMAGE $IMAGE"
  exit 1
fi

echo ''
echo 'using the following image as login background:'
echo $IMAGE
echo ''

if [ -d ~/tmp ]; then
  CREATED_TMP="0"
else
  mkdir -p ~/tmp
  CREATED_TMP="1"
fi

WORKDIR=~/tmp/gdm-login-background
GST=/usr/share/gnome-shell/gnome-shell-theme.gresource
GSTRES=$(basename $GST)

mkdir -p $WORKDIR
cd $WORKDIR
mkdir theme

for r in `gresource list $GST`; do
  gresource extract $GST $r >$WORKDIR$(echo $r | sed -e 's/^\/org\/gnome\/shell\//\//g')
done

cd theme
cp "$IMAGE" ./

echo "
#lockDialogGroup {
  background: #2e3436 url(resource:///org/gnome/shell/theme/$(basename $IMAGE));
  background-size: cover;
  background-repeat: no-repeat;
}" >>gnome-shell.css

echo '<?xml version="1.0" encoding="UTF-8"?>
<gresources>
  <gresource prefix="/org/gnome/shell/theme">' >"${GSTRES}.xml"
for r in `ls *.*`; do
  echo "    <file>$r</file>" >>"${GSTRES}.xml"
done
echo '  </gresource>
</gresources>' >>"${GSTRES}.xml"

glib-compile-resources "${GSTRES}.xml"

sudo mv "/usr/share/gnome-shell/$GSTRES" "/usr/share/gnome-shell/${GSTRES}.backup"
sudo mv "$GSTRES" /usr/share/gnome-shell/

rm -r $WORKDIR

if [ "$CREATED_TMP" = "1" ]; then
  rm -r ~/tmp
fi
