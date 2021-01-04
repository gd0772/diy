#!/bin/bash
#=================================================
# Description: Build OpenWrt using GitHub Actions
# echo '删除默认主题'
# rm -rf ./package/lean/luci-theme-argon
# echo '删除并替换luci-app-netdata'
rm -rf ./package/lean/luci-app-netdata
svn co https://github.com/gd0772/gd772-package/tree/main/luci-app-netdata ./package/lean/luci-app-netdata
# echo '删除并替换netdata'
rm -rf ./feeds/packages/admin/netdata
svn co https://github.com/gd0772/gd772-package/tree/main/netdata ./feeds/packages/admin/netdata
# echo '替换zzz-default-settings'
curl -fsSL  https://raw.githubusercontent.com/gd0772/other/main/zzz-default-settings > ./package/lean/default-settings/files/zzz-default-settings
# echo '添加关机'
curl -fsSL  https://raw.githubusercontent.com/gd0772/other/main/poweroff.htm > ./feeds/luci/modules/luci-mod-admin-full/luasrc/view/admin_system/poweroff.htm 
# echo '替换system.lua文件'
curl -fsSL  https://raw.githubusercontent.com/siropboy/other/master/patch/poweroff/system.lua > ./feeds/luci/modules/luci-mod-admin-full/luasrc/controller/admin/system.lua
# echo '修改 TTYD 名称'
sed -i 's/ttyd/网页终端/g' package/lean/luci-app-ttyd/po/zh-cn/terminal.po
# echo '修改 服务菜单 里的app名称'
sed -i 's/UPnP/UPnP设置/g' feeds/luci/applications/luci-app-upnp/luasrc/controller/upnp.lua
sed -i 's/解锁网易云灰色歌曲/音乐解锁/g' package/lean/luci-app-unblockmusic/po/zh-cn/unblockmusic.po
# echo '修改 网络存储 名称'
sed -i 's/网络存储/存储/g' package/lean/luci-app-vsftpd/po/zh-cn/vsftpd.po
# echo '修改 网络菜单 里的app名称'
sed -i 's/Turbo ACC 网络加速/网络加速/g' package/lean/luci-app-flowoffload/po/zh-cn/flowoffload.po
sed -i 's/Turbo ACC 网络加速/网络加速/g' package/lean/luci-app-sfe/po/zh-cn/sfe.po
# echo '修改 带宽监控 名称'
sed -i 's/带宽监控/统计/g' feeds/luci/applications/luci-app-nlbwmon/po/zh-cn/nlbwmon.po
sed -i 's/invalid/# invalid/g' package/network/services/samba36/files/smb.conf.template
sed -i 's/tables=1/tables=0/g' ./package/kernel/linux/files/sysctl-br-netfilter.conf
# echo '添加 小猫咪'
git clone -b master https://github.com/vernesong/OpenClash.git ./package/diy/OpenClash
# echo '添加 passwall'
git clone https://github.com/xiaorouji/openwrt-passwall.git ./package/diy/passwall
# echo '添加 HelloWorld'
git clone https://github.com/jerrykuku/luci-app-vssr.git ./package/diy/luci-app-vssr
# echo '添加 京东签到'
svn co https://github.com/jerrykuku/luci-app-jd-dailybonus.git ./package/diy/luci-app-jd-dailybonus
# echo '添加 微信推送'
git clone -b master --single-branch https://github.com/tty228/luci-app-serverchan ./package/diy/luci-app-serverchan
# echo '添加 应用过滤'
git clone -b master --single-branch https://github.com/destan19/OpenAppFilter ./package/diy/OpenAppFilter
# echo '添加 smartdns'
svn co https://github.com/gd0772/gd772-package/tree/main/smartdns ./feeds/packages/net/smartdns
# sed -i 's/KERNEL_PATCHVER:=5.4/KERNEL_PATCHVER:=4.19/g' ./target/linux/x86/Makefile
# sed -i 's/KERNEL_TESTING_PATCHVER:=5.4/KERNEL_TESTING_PATCHVER:=4.19/g' ./target/linux/x86/Makefile
./scripts/feeds update -i
