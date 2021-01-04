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
# echo '修改 系统菜单 里的app名称'

# echo '修改 服务菜单 里的app名称'
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

# sed -i '/filter_/d' package/network/services/dnsmasq/files/dhcp.conf
sed -i '$a tls_enable = true' ./package/lean/luci-app-frpc/root/etc/config/frp
git clone -b master https://github.com/vernesong/OpenClash.git package/OpenClashgit clone https://github.com/xiaorouji/openwrt-passwall package/diy1
sed -i '$a\chdbits.co\n\www.cnscg.club\n\pt.btschool.club\n\et8.org\n\www.nicept.net\n\pthome.net\n\ourbits.club\n\pt.m-team.cc\n\hdsky.me\n\ccfbits.org' package/diy1/xiaorouji/luci-app-passwall/root/usr/share/passwall/rules/direct_host
sed -i '$a\docker.com\n\docker.io' package/diy1/xiaorouji/luci-app-passwall/root/usr/share/passwall/rules/proxy_host
sed -i '/global_rules/a	option auto_update 1\n	option week_update 0\n	option time_update 5' package/diy1/xiaorouji/luci-app-passwall/root/etc/config/passwall
sed -i '/global_subscribe/a	option auto_update_subscribe 1\noption week_update_subscribe 7\noption time_update_subscribe 5' package/diy1/xiaorouji/luci-app-passwall/root/etc/config/passwall

git clone https://github.com/AlexZhuo/luci-app-bandwidthd diy/luci-app-bandwidthd
rm -rf package/lean/luci-app-baidupcs-web && \
git clone https://github.com/garypang13/luci-app-baidupcs-web diy/luci-app-baidupcs-web
#svn co https://github.com/sirpdboy/sirpdboy-package/trunk/AdGuardHome ./package/new/AdGuardHome
# curl -fsSL https://raw.githubusercontent.com/privacy-protection-tools/anti-AD/master/anti-ad-smartdns.conf >  ./package/new/smartdns/conf/anti-ad-smartdns.conf
svn co https://github.com/jerrykuku/luci-app-jd-dailybonus/trunk/ ./package/diy/luci-app-jd-dailybonus
git clone -b master --single-branch https://github.com/tty228/luci-app-serverchan ./package/diy/luci-app-serverchan
# curl -fsSL  https://raw.githubusercontent.com/siropboy/other/master/patch/etc/serverchan > ./package/diy/luci-app-serverchan/root/etc/config/serverchan
git clone -b master --single-branch https://github.com/destan19/OpenAppFilter ./package/diy/OpenAppFilter
# svn co https://github.com/siropboy/luci-app-vssr-plustrunk/luci-app-vssr-plus package/new/luci-app-vssr-plus
# svn co https://github.com/siropboy/luci-app-vssr-plus/trunk/luci-app-vssr-plus package/new/luci-app-vssr-plus
# svn co https://github.com/xiaorouji/openwrt-passwall/trunk/ package/diy/lienol
# sed -i 's/KERNEL_PATCHVER:=5.4/KERNEL_PATCHVER:=4.19/g' ./target/linux/x86/Makefile
# sed -i 's/KERNEL_TESTING_PATCHVER:=5.4/KERNEL_TESTING_PATCHVER:=4.19/g' ./target/linux/x86/Makefile
#sed -i "/mediaurlbase/d" package/*/luci-theme*/root/etc/uci-defaults/*
#sed -i "/mediaurlbase/d" feed/*/luci-theme*/root/etc/uci-defaults/*
#svn co https://github.com/kenzok8/openwrt-packages/trunk/luci-app-openclash package/diy/luci-app-openclash
svn co https://github.com/jerrykuku/luci-app-vssr/ package/diy/luci-app-vssr
./scripts/feeds update -i
