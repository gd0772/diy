#!/bin/bash
#=================================================
# Description: Build OpenWrt using GitHub Actions
# echo '删除重复主题'
rm -rf ./package/lean/luci-theme-argon
# echo '修改 默认IP'
sed -i "s/192.168.1.1/192.168.123.3/g" package/base-files/files/bin/config_generate
# echo '汉化实时监控'
rm -rf ./package/lean/luci-app-netdata
svn co https://github.com/gd0772/diy/trunk/luci-app-netdata ./package/lean/luci-app-netdata
rm -rf ./feeds/packages/admin/netdata
svn co https://github.com/gd0772/diy/trunk/netdata ./feeds/packages/admin/netdata
# echo '添加关机功能'
curl -fsSL  https://raw.githubusercontent.com/gd0772/diy/main/poweroff.htm > ./feeds/luci/modules/luci-mod-admin-full/luasrc/view/admin_system/poweroff.htm 
curl -fsSL  https://raw.githubusercontent.com/gd0772/diy/main/system.lua > ./feeds/luci/modules/luci-mod-admin-full/luasrc/controller/admin/system.lua
# echo '添加 小猫咪'
git clone https://github.com/vernesong/OpenClash.git ./package/diy/OpenClash
# echo '添加 Passwall'
git clone https://github.com/xiaorouji/openwrt-passwall.git ./package/diy/passwall
# echo '添加 应用过滤'
git clone -b master --single-branch https://github.com/destan19/OpenAppFilter ./package/diy/OpenAppFilter
# echo '添加 HelloWorld'
svn co https://github.com/jerrykuku/luci-app-vssr/trunk/ package/diy/luci-app-vssr
# echo '添加 京东签到'
svn co https://github.com/jerrykuku/luci-app-jd-dailybonus/trunk/ ./package/diy/luci-app-jd-dailybonus
# echo '添加 SmartDNS 依赖'
git clone https://github.com/pymumu/openwrt-smartdns.git ./feeds/packages/net/smartdns
# echo '修改插件名称'
sed -i 's/TTYD 终端/网页终端/g' package/lean/luci-app-ttyd/po/zh-cn/terminal.po
sed -i 's/UPnP/UPnP设置/g' feeds/luci/applications/luci-app-upnp/luasrc/controller/upnp.lua
sed -i 's/解锁网易云灰色歌曲/音乐解锁/g' package/lean/luci-app-unblockmusic/po/zh-cn/unblockmusic.po
sed -i 's/网络存储/存储/g' package/lean/luci-app-vsftpd/po/zh-cn/vsftpd.po
sed -i 's/Turbo ACC 网络加速/网络加速/g' package/lean/luci-app-flowoffload/po/zh-cn/flowoffload.po
sed -i 's/Turbo ACC 网络加速/网络加速/g' package/lean/luci-app-sfe/po/zh-cn/sfe.po
sed -i 's/ZeroTier/ZeroTier内网穿透/g' package/lean/luci-app-zerotier/luasrc/controller/zerotier.lua
sed -i 's/带宽监控/统计/g' feeds/luci/applications/luci-app-nlbwmon/po/zh-cn/nlbwmon.po
sed -i 's/invalid/# invalid/g' package/lean/samba4/files/smb.conf.template
# echo '版本号更新'
curl -fsSL  https://raw.githubusercontent.com/gd0772/other/main/zzz-default-settings > ./package/lean/default-settings/files/zzz-default-settings
# sed -i 's/KERNEL_PATCHVER:=5.4/KERNEL_PATCHVER:=4.19/g' ./target/linux/x86/Makefile
# sed -i 's/KERNEL_TESTING_PATCHVER:=5.4/KERNEL_TESTING_PATCHVER:=4.19/g' ./target/linux/x86/Makefile
./scripts/feeds update -i
