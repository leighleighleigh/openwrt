default:
  just -l -u

update-feeds:
  ./scripts/feeds update -a 
  ./scripts/feeds install -a 

menuconfig:
  make menuconfig

make:
  time make -j$(nproc) defconfig download clean world

distclean:
  make distclean

