#!/bin/bash
#=================================================
# Description: Build OpenWrt using GitHub Actions
# echo '删除重复多余主题'
rm -rf ./feeds/freifunk/themes
rm -rf ./package/luci-theme-netgear
rm -rf ./package/lean/luci-theme-argon
rm -rf ./feeds/luci/themes/luci-theme-material

# echo '删除重复插件'
rm -rf ./feeds/packages/net/smartdns
rm -rf ./feeds/packages/admin/netdata
rm -rf ./package/lean/luci-app-netdata
rm -rf ./package/lean/luci-app-cpufreq
rm -rf ./package/lean/luci-app-zerotier
rm -rf ./package/lean/luci-app-ipsec-vpnd
rm -rf ./package/lean/luci-app-usb-printer
rm -rf ./package/lean/luci-app-v2ray-server
rm -rf ./package/lean/luci-app-softethervpn
rm -rf ./package/lean/luci-app-openvpn-server

# echo '修改 默认IP'
sed -i "s/192.168.1.1/192.168.123.3/g" package/base-files/files/bin/config_generate

# echo '添加关机功能'
curl -fsSL  https://raw.githubusercontent.com/gd0772/diy/main/poweroff.htm > ./feeds/luci/modules/luci-mod-admin-full/luasrc/view/admin_system/poweroff.htm 
curl -fsSL  https://raw.githubusercontent.com/gd0772/diy/main/system.lua > ./feeds/luci/modules/luci-mod-admin-full/luasrc/controller/admin/system.lua
# echo '添加 小猫咪'
git clone https://github.com/vernesong/OpenClash.git ./package/diy/OpenClash
# echo '添加 Passwall'
git clone https://github.com/xiaorouji/openwrt-passwall.git ./package/diy/passwall
# echo '添加 应用过滤'
git clone https://github.com/destan19/OpenAppFilter.git ./package/diy/OpenAppFilter
# echo '添加 京东签到'
svn co https://github.com/jerrykuku/luci-app-jd-dailybonus/trunk/ package/diy/luci-app-jd-dailybonus
# echo '添加 SmartDNS'
git clone https://github.com/pymumu/luci-app-smartdns.git -b lede ./package/diy/luci-app-smartdns
git clone https://github.com/pymumu/openwrt-smartdns.git ./feeds/packages/net/smartdns
# echo '汉化实时监控'
svn co https://github.com/gd0772/diy/trunk/luci-app-netdata ./package/lean/luci-app-netdata
svn co https://github.com/gd0772/diy/trunk/netdata ./feeds/packages/admin/netdata

# echo '修改插件名称'
sed -i 's/TTYD 终端/网页终端/g' package/lean/luci-app-ttyd/po/zh-cn/terminal.po
sed -i 's/ShadowSocksR Plus+/SSR Plus+/g' feeds/helloworld/luci-app-ssr-plus/luasrc/controller/shadowsocksr.lua
sed -i 's/广告屏蔽大师 Plus+/广告屏蔽/g' package/lean/luci-app-adbyby-plus/po/zh-cn/adbyby.po
sed -i 's/京东签到服务/京东签到/g' package/diy/luci-app-jd-dailybonus/po/zh-cn/jd-dailybonus.po
sed -i 's/KMS 服务器/KMS 激活/g' package/lean/luci-app-vlmcsd/po/zh-cn/vlmcsd.zh-cn.po
sed -i 's/UPnP/UPnP设置/g' feeds/luci/applications/luci-app-upnp/luasrc/controller/upnp.lua
sed -i 's/Frp 内网穿透/Frp 客户端/g' package/lean/luci-app-frpc/po/zh-cn/frp.po
sed -i 's/Frps/Frp 服务端/g' package/lean/luci-app-frps/luasrc/controller/frps.lua
sed -i 's/Nps 内网穿透/NPS 客户端/g' package/lean/luci-app-nps/po/zh-cn/nps.po
sed -i 's/解锁网易云灰色歌曲/音乐解锁/g' package/lean/luci-app-unblockmusic/po/zh-cn/unblockmusic.po
sed -i 's/Docker CE 容器/Docker容器/g' package/lean/luci-app-docker/po/zh-cn/docker.po
sed -i 's/网络存储/存储/g' package/lean/luci-app-vsftpd/po/zh-cn/vsftpd.po
sed -i 's/挂载 SMB 网络共享/挂载共享/g' package/lean/luci-app-cifs-mount/po/zh-cn/cifs.po
sed -i 's/BaiduPCS Web/百毒网盘/g' package/lean/luci-app-baidupcs-web/luasrc/controller/baidupcs-web.lua
sed -i 's/Turbo ACC 网络加速/网络加速/g' package/lean/luci-app-flowoffload/po/zh-cn/flowoffload.po
sed -i 's/Turbo ACC 网络加速/网络加速/g' package/lean/luci-app-sfe/po/zh-cn/sfe.po
sed -i 's/带宽监控/统计/g' feeds/luci/applications/luci-app-nlbwmon/po/zh-cn/nlbwmon.po
sed -i 's/invalid/# invalid/g' package/lean/samba4/files/smb.conf.template

# echo '插件归类'
sed -i 's/\"services\"/\"nas\"/g' package/lean/luci-app-samba4/luasrc/controller/samba4.lua
sed -i 's/\"services\"/\"network\"/g' package/lean/luci-app-mwan3helper/luasrc/controller/mwan3helper.lua




# echo '版本号更新'
curl -fsSL  https://raw.githubusercontent.com/gd0772/other/main/zzz-default-settings > ./package/lean/default-settings/files/zzz-default-settings

# sed -i 's/KERNEL_PATCHVER:=5.4/KERNEL_PATCHVER:=4.19/g' ./target/linux/x86/Makefile
# sed -i 's/KERNEL_TESTING_PATCHVER:=5.4/KERNEL_TESTING_PATCHVER:=4.19/g' ./target/linux/x86/Makefile
./scripts/feeds update -i
