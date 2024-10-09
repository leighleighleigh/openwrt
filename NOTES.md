# OpenWRT custom image with RTL8821AU drivers

This fork has the required drivers, backported from `wireless-next`
> https://github.com/mj22226/openwrt/tree/rtw88-8821au

I've forked it here:
> https://github.com/leighleighleigh/openwrt/tree/rtw88-8821au


Follow the instructions at the official OpenWRT docs to build the repo
> https://openwrt.org/docs/guide-developer/toolchain/use-buildsystem

Additionally, find relevant build information (menuconfig settings) for the Raspi Zero 2W here:
> https://mirror-03.infra.openwrt.org/snapshots/targets/bcm27xx/bcm2710/
Note the `rpi-3` prefix, that is the correct one!
For a brand-new SD Card, flash the `rpi-3-ext4-factory.img.gz` file.

Relevant bits below...

```shell
# Get source
git clone --depth 1 --branch rtw88-8821au https://github.com/leighleighleigh/openwrt

# Hop into your nix shell
nix-shell

# Update the feeds
./scripts/feeds update -a
./scripts/feeds install -a
 
# Configure the firmware image, selecting the correct option for RPi Zero2W,
# and adding any additional packages you like. 
cp ./config_rpi_Z2W ./.config
make menuconfig
# Target System  -> Broadcom BCM27xx
# Subtarget      -> BCM2710 boards (64 bit)
# Target Profile -> Raspberry Pi 3A+/3B/3B+/CM3/Zero2/Zero2W (64bit)
# 
# Enable LuCI web UI, batman-adv tools
# LuCI -> Collections -> luci (enable)
# LuCI -> Protocols -> luci-proto-batman-adv (enable)
#
# Enable RTL8821AU, the USB-wifi card driver
# Kernel modules -> Wireless Drivers -> kmod-rtw88-8821au (enable)

 
# Optional: configure the kernel (usually not required)
# Don't, unless have a strong reason to
make -j$(nproc) kernel_menuconfig
 
# Build the firmware image
make -j$(nproc) defconfig download clean world
```

