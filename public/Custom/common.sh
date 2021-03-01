#!/bin/bash
# 机型文件=${Modelfile}

# 全脚本源码通用diy.sh文件

Diy_all() {
echo "all"
mv common/{AutoUpdate.sh,AutoBuild_Tools.sh} package/base-files/files/bin
chmod +x package/base-files/files/bin/* ./
}

# 全脚本源码通用diy2.sh文件

Diy_all2() {
echo "all2"
rm -rf {LICENSE,README,README.md}
rm -rf ./*/{LICENSE,README,README.md}
rm -rf ./*/*/{LICENSE,README,README.md}
}

################################################################################################################


# LEDE源码通用diy1.sh文件（除了openwrt机型文件夹）

Diy_lede() {
echo "LEDE源码自定义1"
}

# LEDE源码通用diy2.sh文件（openwrt机型文件夹也使用）

Diy_lede2() {
echo "LEDE源码自定义2"
}

################################################################################################################



################################################################################################################


# LIENOL源码通用diy1.sh文件（除了openwrt机型文件夹）

Diy_lienol() {
echo "LIENOL源码自定义1"
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


Diy_xinxi() {
DEVICES="$(awk -F '[="]+' '/TARGET_BOARD/{print $2}' .config)"
SUBTARGETS="$(awk -F '[="]+' '/TARGET_SUBTARGET/{print $2}' .config)"
if [[ "${DEVICES}" == "x86" ]]; then
	TARGET_PRO="x86-${SUBTARGETS}"
elif [[ ${Modelfile} =~ (Lean_phicomm_n1|Project_phicomm_n1) ]]; then
	TARGET_PRO="n1,Vplus,Beikeyun,L1Pro,S9xxx"
else
	TARGET_PRO="$(egrep -o "CONFIG_TARGET.*DEVICE.*=y" .config | sed -r 's/.*DEVICE_(.*)=y/\1/')"
fi
[[ -z "${TARGET_PRO}" ]] && TARGET_PRO="Unknown"
echo "编译源码: ${Source}"
echo "源码链接: ${REPO_URL}"
echo "源码分支: ${REPO_BRANCH}"
echo "源码作者: ${ZUOZHE}"
echo "机子型号: ${TARGET_PRO}"
echo "固件作者: ${Author}"
echo "仓库链接: ${GITHUB_RELEASE}"
if [[ ${UPLOAD_BIN_DIR} == "true" ]]; then
	echo "上传BIN文件夹(固件+IPK): 开启"
else
	echo "上传BIN文件夹(固件+IPK): 关闭"
fi
if [[ ${UPLOAD_CONFIG} == "true" ]]; then
	echo "上传[.config]配置文件: 开启"
else
	echo "上传[.config]配置文件: 关闭"
fi
if [[ ${UPLOAD_FIRMWARE} == "true" ]]; then
	echo "上传固件在github空间: 开启"
else
	echo "上传固件在github空间: 关闭"
fi
if [[ ${UPLOAD_COWTRANSFER} == "true" ]]; then
	echo "上传固件到到【奶牛快传】和【WETRANSFER】: 开启"
else
	echo "上传固件到到【奶牛快传】和【WETRANSFER】: 关闭"
fi
if [[ ${UPLOAD_RELEASE} == "true" ]]; then
	echo "发布固件: 开启"
else
	echo "发布固件: 关闭"
fi
if [[ ${SERVERCHAN_SCKEY} == "true" ]]; then
	echo "微信通知: 开启"
else
	echo "微信通知: 关闭"
fi
if [[ ${REGULAR_UPDATE} == "true" ]]; then
	echo "把定时自动更新插件编译进固件: 开启"
	echo "定时更新固件版本：《${BANBEN}》"
	echo "《请把“REPO_TOKEN”密匙设置好,没设置好密匙不能发布云端地址》"
	echo "《x86-64、phicomm-k3、newifi-d2已自动适配固件名字跟后缀，无需自行设置了》"
	echo "《如有其他机子可以用定时更新固件的话，请告诉我，我把固件名字跟后缀适配了》"
else	
	echo "把定时自动更新插件编译进固件: 关闭"
fi
}
