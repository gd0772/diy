#!/bin/bash
#=================================================
# Description: Build OpenWrt using GitHub Actions
rm -rf ./package/lean/luci-theme-argon

rm -rf ./package/lean/luci-app-netdata
svn co https://github.com/gd0772/gd772-package/trunk/luci-app-netdata ./package/lean/luci-app-netdata
rm -rf ./feeds/packages/admin/netdata
svn co https://github.com/gd0772/gd772-package/trunk/netdata ./feeds/packages/admin/netdata

curl -fsSL  https://raw.githubusercontent.com/gd0772/other/main/zzz-default-settings > ./package/lean/default-settings/files/zzz-default-settings
curl -fsSL  https://raw.githubusercontent.com/gd0772/other/main/poweroff.htm > ./feeds/luci/modules/luci-mod-admin-full/luasrc/view/admin_system/poweroff.htm 
curl -fsSL  https://raw.githubusercontent.com/siropboy/other/master/patch/poweroff/system.lua > ./feeds/luci/modules/luci-mod-admin-full/luasrc/controller/admin/system.lua

sed -i 's/TTYD 终端/网页终端/g' package/lean/luci-app-ttyd/po/zh-cn/terminal.po
sed -i 's/UPnP/UPnP设置/g' feeds/luci/applications/luci-app-upnp/luasrc/controller/upnp.lua
sed -i 's/解锁网易云灰色歌曲/音乐解锁/g' package/lean/luci-app-unblockmusic/po/zh-cn/unblockmusic.po
sed -i 's/网络存储/存储/g' package/lean/luci-app-vsftpd/po/zh-cn/vsftpd.po
sed -i 's/Turbo ACC 网络加速/网络加速/g' package/lean/luci-app-flowoffload/po/zh-cn/flowoffload.po
sed -i 's/Turbo ACC 网络加速/网络加速/g' package/lean/luci-app-sfe/po/zh-cn/sfe.po
sed -i 's/带宽监控/统计/g' feeds/luci/applications/luci-app-nlbwmon/po/zh-cn/nlbwmon.po
sed -i 's/invalid/# invalid/g' package/network/services/samba36/files/smb.conf.template
sed -i 's/tables=1/tables=0/g' ./package/kernel/linux/files/sysctl-br-netfilter.conf

git clone -b master https://github.com/vernesong/OpenClash.git ./package/diy/OpenClash
git clone https://github.com/xiaorouji/openwrt-passwall.git ./package/diy/passwall
git clone -b master --single-branch https://github.com/destan19/OpenAppFilter ./package/diy/OpenAppFilter

svn co https://github.com/jerrykuku/luci-app-vssr/trunk/ package/diy/luci-app-vssr
svn co https://github.com/jerrykuku/luci-app-jd-dailybonus/trunk/ ./package/diy/luci-app-jd-dailybonus
svn co https://github.com/gd0772/gd772-package/trunk/smartdns ./feeds/packages/net/smartdns
sed -i "s/192.168.1.1/192.168.123.3/$lan_ip/g" package/base-files/files/bin/config_generate
# sed -i 's/KERNEL_PATCHVER:=5.4/KERNEL_PATCHVER:=4.19/g' ./target/linux/x86/Makefile
# sed -i 's/KERNEL_TESTING_PATCHVER:=5.4/KERNEL_TESTING_PATCHVER:=4.19/g' ./target/linux/x86/Makefile
#  make && sudo make install
./scripts/feeds update -i
