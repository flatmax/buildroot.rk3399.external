# NanoPi Neo4 buildroot system

# Initial setup

Clone buildroot. For example :

```
cd yourPath
git clone git://git.busybox.net/buildroot buildroot.neo4
cd buildroot.neo4

# this version builds webengine ok - however requires the webview package form this repo to build qt5webview
git checkout a946657b6e40924a746d1bd86eb023158abd1ab8

# these are from rockchip - but I suggest you use the stock buildroot
#git clone git@github.com:rockchip-linux/buildroot.git buildroot.rockchip
#git checkout rockchip/stable-rk3399-v2.09-20181102
```

Make sure you have requirements :
```
sudo apt-get install -y build-essential gcc g++ autoconf automake libtool bison flex gettext
sudo apt-get install -y patch texinfo wget git gawk curl lzma bc quilt
```

Clone the NanoPi.Neo4 external buildroot tree :
```
git clone git@github.com:flatmax/NanoPi.Neo4.buildroot.external.git NanoPi.Neo4
```

# To make the system

```
. NanoPi.Neo4/setup.sh yourPath/buildroot.neo4
```

# ensure you have your buildroot net downloads directory setup

```
mkdir yourPath/buildroot.dl
```

# build the system

```
make
```

# installing

Insert your sdcard into your drive and make sure it isn't mounted. Write the image to the disk.

NOTE: The following command will overwrite any disk attached to /dev/sdg
NOTE: Be super careful here!

```
sudo ./output/images/sd-fuse-rk3399/fusing.sh /dev/sdg buildroot
```

# using

ssh in as user root, no pass. Or connect to the console debug uart with a serial cable.
