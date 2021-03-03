#!/bin/bash
# https://github.com/281677160/build-openwrt
# common Module by 28677160
# matrix.target=${Modelfile}

# 全脚本源码通用diy.sh文件

Diy_all() {
echo "all"
mv build/${Modelfile}/{AutoUpdate.sh,AutoBuild_Tools.sh} package/base-files/files/bin
chmod -R +x package/base-files/files/bin
git clone https://github.com/gd0772/package.git package/diy
curl -fsSL https://raw.githubusercontent.com/gd0772/diy/main/x86.sh | sh
#svn co https://github.com/jerrykuku/luci-theme-argon/branches/18.06 package/luci-theme-argon
}

# 全脚本源码通用diy2.sh文件

Diy_all2() {
echo "all2"
git clone https://github.com/openwrt-dev/po2lmo.git
pushd po2lmo
make && sudo make install
popd
rm -rf {LICENSE,README,README.md}
rm -rf ./*/{LICENSE,README,README.md}
rm -rf ./*/*/{LICENSE,README,README.md}
#mkdir -p files/usr/bin/AdGuardHome/data
}

################################################################################################################


# LEDE源码通用diy1.sh文件

Diy_lean() {
echo "LEAN源码自定义1"
cp -Rf build/common/* "${PATH1}"
if [[ "${Modelfile}" == "Lean_openwrt" ]]; then
sed -i '/IMAGES_GZIP/d' "${PATH1}/${CONFIG_FILE}" > /dev/null 2>&1
echo -e "\nCONFIG_TARGET_IMAGES_GZIP=y" >> "${PATH1}/${CONFIG_FILE}"
fi
#rm -rf package/lean/luci-theme-argon

#git clone https://github.com/fw876/helloworld package/luci-app-ssr-plus

}

# LEAN源码通用diy2.sh文件（openwrt机型文件夹也使用）

Diy_lean2() {
echo "LEAN源码自定义2"
}

################################################################################################################



################################################################################################################


# LIENOL源码通用diy1.sh文件（除了openwrt机型文件夹）

Diy_lienol() {
echo "LIENOL源码自定义1"

git clone https://github.com/xiaorouji/openwrt-passwall package/danshui/luci-app-passwall
}

# LIENOL源码通用diy2.sh文件（openwrt机型文件夹也使用）

Diy_lienol2() {
echo "LIENOL源码自定义2"
}

################################################################################################################



################################################################################################################


# 天灵源码通用diy1.sh文件（除了openwrt机型文件夹）

Diy_immortalwrt() {
echo "天灵源码自定义1"

}

# 天灵源码通用diy2.sh文件（openwrt机型文件夹也使用）

Diy_immortalwrt2() {
echo "天灵源码自定义2"
}

################################################################################################################


# N1、微加云、贝壳云、我家云、S9xxx 打包程序

Diy_n1() {
cd ../
svn co https://github.com/281677160/N1/trunk reform
cp openwrt/bin/targets/armvirt/*/*.tar.gz reform/openwrt
cd reform
sudo ./gen_openwrt -d -k latest
         
devices=("phicomm-n1" "rk3328" "s9xxx" "vplus")
}


################################################################################################################


# 公告

Diy_notice() {
echo ""
echo "	《公告内容》"
echo " 祝大家新年快乐、生活愉快！"
echo " 使用中有疑问的可以加入电报群，跟群友交流"
echo ""
}


Diy_xinxi_Base() {
GET_TARGET_INFO
if [[ "${TARGET_PROFILE}" =~ (x86-64|phicomm-k3|xiaomi_mir3g|d-team_newifi-d2|phicomm_k2p|k2p) ]]; then
	Firmware_mz="${TARGET_PROFILE}自动适配"
	Firmware_hz="${TARGET_PROFILE}自动适配"
else
	Firmware_mz="${Up_Firmware}"
	Firmware_hz="${Firmware_sfx}"
fi
if [[ "${Modelfile}" =~ (Lede_phicomm_n1|Project_phicomm_n1) ]]; then
	TARGET_PROFILE="N1,Vplus,Beikeyun,L1Pro,S9xxx"
fi
echo ""
echo " 编译源码: ${COMP2}"
echo " 源码链接: ${REPO_URL}"
echo " 源码分支: ${REPO_BRANCH}"
echo " 源码作者: ${ZUOZHE}"
echo " 编译机型: ${TARGET_PROFILE}"
echo " 固件作者: ${Author}"
echo " 仓库地址: ${Github_Repo}"
if [[ ${UPLOAD_BIN_DIR} == "true" ]]; then
	echo " 上传BIN文件夹(固件+IPK): 开启"
else
	echo " 上传BIN文件夹(固件+IPK): 关闭"
fi
if [[ ${UPLOAD_CONFIG} == "true" ]]; then
	echo " 上传[.config]配置文件: 开启"
else
	echo " 上传[.config]配置文件: 关闭"
fi
if [[ ${UPLOAD_FIRMWARE} == "true" ]]; then
	echo " 上传固件在github空间: 开启"
else
	echo " 上传固件在github空间: 关闭"
fi
if [[ ${UPLOAD_COWTRANSFER} == "true" ]]; then
	echo " 上传固件到到【奶牛快传】和【WETRANSFER】: 开启"
else
	echo " 上传固件到到【奶牛快传】和【WETRANSFER】: 关闭"
fi
if [[ ${UPLOAD_RELEASE} == "true" ]]; then
	echo " 发布固件: 开启"
else
	echo " 发布固件: 关闭"
fi
if [[ ${SERVERCHAN_SCKEY} == "true" ]]; then
	echo " 微信通知: 开启"
else
	echo " 微信通知: 关闭"
fi
if [[ ${SSH_ACTIONS} == "true" ]]; then
	echo " SSH远程连接: 开启"
else
	echo " SSH远程连接: 关闭"
fi
if [[ ${SSHYC} == "true" ]]; then
	echo " SSH远程临时开关: 开启"
fi
if [[ ${REGULAR_UPDATE} == "true" ]]; then
	echo ""
	echo " 把定时自动更新插件编译进固件: 开启"
	echo " 插件版本: ${AutoUpdate_Version}"
	echo " 固件名称: ${Firmware_mz}"
	echo " 固件后缀: ${Firmware_hz}"
	echo " 固件版本: ${Openwrt_Version}"
	echo " 云端路径: ${Github_UP_RELEASE}"
	echo " 《编译成功，会自动把固件发布到指定地址，然后才会生成云端路径》"
	echo " 《请把“REPO_TOKEN”密匙设置好,没设置好密匙不能发布就生成不了云端地址》"
	echo " 《x86-64、phicomm_k2p、phicomm-k3、newifi-d2已自动适配固件名字跟后缀，无需自行设置》"
	echo " 《如有其他机子可以用定时更新固件的话，请告诉我，我把固件名字跟后缀适配了》"
	echo ""
else
	echo " 把定时自动更新插件编译进固件: 关闭"
	echo ""
fi
echo " 系统空间      类型   总数  已用  可用 使用率"
cd ../ && df -hT $PWD && cd openwrt
}
