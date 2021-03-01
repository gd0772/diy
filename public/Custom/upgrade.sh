GET_TARGET_INFO() {
	[ -f ${GITHUB_WORKSPACE}/Openwrt.info ] && . ${GITHUB_WORKSPACE}/Openwrt.info
	AutoBuild_Info=${GITHUB_WORKSPACE}/openwrt/package/base-files/files/etc/openwrt_info
	Github_Repo="$(grep "https://github.com/[a-zA-Z0-9]" ${GITHUB_WORKSPACE}/.git/config | cut -c8-100)"
	Openwrt_Version="${Compile_Date}"
	AutoUpdate_Version=$(awk 'NR==6' package/base-files/files/bin/AutoUpdate.sh | awk -F '[="]+' '/Version/{print $2}')
	[[ -z "${AutoUpdate_Version}" ]] && AutoUpdate_Version="Unknown"
	[[ -z "${Author}" ]] && Author="Unknown"
	TARGET1="$(awk -F '[="]+' '/TARGET_BOARD/{print $2}' .config)"
	TARGET2="$(awk -F '[="]+' '/TARGET_SUBTARGET/{print $2}' .config)"
	TARGET3="$(egrep -o "CONFIG_TARGET.*DEVICE.*=y" .config | sed -r 's/.*DEVICE_(.*)=y/\1/')"
        if [[ "${TARGET1}" == "x86" ]]; then
		TARGET_PROFILE="x86-64"
	else
		TARGET_PROFILE="${TARGET3}"
	fi
	[[ -z "${TARGET_PROFILE}" ]] && TARGET_PROFILE="Unknown"
	
	if [[ "${REPO_URL}" == "https://github.com/coolsnowwolf/lede" ]];then
		if [[ "${TARGET_PROFILE}" == "x86-64" ]]; then
			Up_Firmware="openwrt-x86-64-generic-squashfs-combined.img.gz"
			Firmware_sfx=".img.gz"
		elif [[ "${TARGET_PROFILE}" == "phicomm-k3" ]]; then
			Up_Firmware="openwrt-bcm53xx-generic-phicomm-k3-squashfs.trx"
			Firmware_sfx=".trx"
		elif [[ "${TARGET_PROFILE}" =~ (xiaomi_mir3g|d-team_newifi-d2) ]]; then
			Up_Firmware="openwrt-${TARGET1}-${TARGET2}-${TARGET3}-squashfs-sysupgrade.bin"
			Firmware_sfx=".bin"
		else
			Up_Firmware="${Updete_firmware}"
			Firmware_sfx="${Extension}"
		fi
	fi
        
	if [[ "${REPO_URL}" == "https://github.com/Lienol/openwrt" ]];then
		if [[ "${TARGET_PROFILE}" == "x86-64" ]]; then
			Up_Firmware="openwrt-x86-64-combined-squashfs.img.gz"
			Firmware_sfx=".img.gz"
		elif [[ "${TARGET_PROFILE}" == "phicomm-k3" ]]; then
			Up_Firmware="openwrt-bcm53xx-phicomm-k3-squashfs.trx"
			Firmware_sfx=".trx"
		elif [[ "${TARGET_PROFILE}" =~ (xiaomi_mir3g|d-team_newifi-d2) ]]; then
			Up_Firmware="openwrt-${TARGET1}-${TARGET2}-${TARGET3}-squashfs-sysupgrade.bin"
			Firmware_sfx=".bin"
		else
			Up_Firmware="${Updete_firmware}"
			Firmware_sfx="${Extension}"
		fi
	fi
	
        if [[ "${REPO_URL}" == "https://github.com/immortalwrt/immortalwrt" ]];then
		if [[ "${TARGET_PROFILE}" == "x86-64" ]]; then
			Up_Firmware="immortalwrt-x86-64-combined-squashfs.img.gz"
			Firmware_sfx=".img.gz"
		elif [[ "${TARGET_PROFILE}" == "phicomm-k3" ]]; then
			Up_Firmware="immortalwrt-bcm53xx-phicomm-k3-squashfs.trx"
			Firmware_sfx=".trx"
		elif [[ "${TARGET_PROFILE}" =~ (xiaomi_mir3g|d-team_newifi-d2) ]]; then
			Up_Firmware="immortalwrt-${TARGET1}-${TARGET2}-${TARGET3}-squashfs-sysupgrade.bin"
			Firmware_sfx=".bin"
		else
			Up_Firmware="${Updete_firmware}"
			Firmware_sfx="${Extension}"
		fi
	fi
}

Diy_Part1() {
	sed -i '/luci-app-autoupdate/d' .config > /dev/null 2>&1
	echo -e "\nCONFIG_PACKAGE_luci-app-autoupdate=y" >> .config
	sed -i '/luci-app-ttyd/d' .config > /dev/null 2>&1
	echo -e "\nCONFIG_PACKAGE_luci-app-ttyd=y" >> .config
	sed -i '/IMAGES_GZIP/d' .config > /dev/null 2>&1
	echo -e "\nCONFIG_TARGET_IMAGES_GZIP=y" >> .config
}

Diy_Part2() {
	GET_TARGET_INFO
	echo "编译源码: ${Source}"
	echo "源码链接: ${REPO_URL}"
	echo "源码分支: ${REPO_BRANCH}"
	echo "源码作者: ${ZUOZHE}"
	echo "机子型号: ${TARGET_PROFILE}"
	echo "安装需要的固件名称: ${Up_Firmware}"
	echo "安装需要的固件后缀: ${Firmware_sfx}"
	echo "自动更新固件版本: Firmware-${Openwrt_Version}"
	echo "固件作者: ${Author}"
	echo "仓库链接: ${Github_Repo}"
	if [[ ${UPLOAD_BIN_DIR} == "false" ]]; then
		echo "上传BIN文件夹(固件+IPK): 关闭"
	elif [[ ${UPLOAD_BIN_DIR} == "true" ]]; then
		echo "上传BIN文件夹(固件+IPK): 开启"
	fi
	if [[ ${UPLOAD_CONFIG} == "false" ]]; then
		echo "上传[.config]配置文件: 关闭"
	elif [[ ${UPLOAD_CONFIG} == "true" ]]; then
		echo "上传[.config]配置文件: 开启"
	fi
	if [[ ${UPLOAD_FIRMWARE} == "false" ]]; then
		echo "上传固件在github空间: 关闭"
	elif [[ ${UPLOAD_FIRMWARE} == "true" ]]; then
		echo "上传固件在github空间: 开启"
	fi
	if [[ ${UPLOAD_COWTRANSFER} == "false" ]]; then
		echo "上传固件到到【奶牛快传】和【WETRANSFER】: 关闭"
	elif [[ ${UPLOAD_COWTRANSFER} == "true" ]]; then
		echo "上传固件到到【奶牛快传】和【WETRANSFER】: 开启"
	fi
	if [[ ${UPLOAD_RELEASE} == "false" ]]; then
		echo "发布固件: 关闭"
	elif [[ ${UPLOAD_RELEASE} == "true" ]]; then
		echo "发布固件: 开启"
	fi
	if [[ ${SERVERCHAN_SCKEY} == "false" ]]; then
		echo "微信通知: 关闭"
	elif [[ ${SERVERCHAN_SCKEY} == "true" ]]; then
		echo "微信通知: 开启"
	fi
	if [[ ${REGULAR_UPDATE} == "true" ]]; then
		echo "编译定时更新插件: 开启"
		echo "《把定时自动更新插件编译进固件已开启》"
		echo "《请把“REPO_TOKEN”密匙设置好,没设置好密匙不能发布云端地址》"
		echo "《请注意核对固件名字和后缀,避免编译错误》"
		echo "《x86-64、phicomm-k3、newifi-d2已自动适配固件名字跟后缀，无需自行设置了》"
	fi
	echo "Firmware-${Openwrt_Version}" > ${AutoBuild_Info}
	echo "${Github_Repo}" >> ${AutoBuild_Info}
	echo "${TARGET_PROFILE}" >> ${AutoBuild_Info}
	echo "${Source}" >> ${AutoBuild_Info}
}

Diy_Part3() {
	GET_TARGET_INFO
	Default_Firmware="${Up_Firmware}"
	AutoBuild_Firmware="openwrt-${Source}-${TARGET_PROFILE}-Firmware-${Openwrt_Version}${Firmware_sfx}"
	AutoBuild_Detail="openwrt-${Source}-${TARGET_PROFILE}-Firmware-${Openwrt_Version}.detail"
	Mkdir bin/Firmware
	echo "Firmware: ${AutoBuild_Firmware}"
	cp bin/targets/*/*/*"${Default_Firmware}" bin/Firmware/"${AutoBuild_Firmware}"
	_MD5="$(md5sum bin/Firmware/${AutoBuild_Firmware} | cut -d ' ' -f1)"
	_SHA256="$(sha256sum bin/Firmware/${AutoBuild_Firmware} | cut -d ' ' -f1)"
	echo -e "\nMD5:${_MD5}\nSHA256:${_SHA256}" > bin/Firmware/"${AutoBuild_Detail}"
}

Mkdir() {
	_DIR=${1}
	if [ ! -d "${_DIR}" ];then
		echo "[$(date "+%H:%M:%S")] Creating new folder [${_DIR}] ..."
		mkdir -p ${_DIR}
	fi
	unset _DIR
}
