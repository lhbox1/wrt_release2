#!/bin/sh
##########################
# 网络异常重启wan接口监控脚本
# 配置在调度表cron中
##########################
# 添加执行权限
# chmod +x /etc/wan_check.sh
# */5 * * * * /etc/wan_check.sh
# 定义日志文件路径
LOG_FILE="/var/log/auto_restart_wan.log"

ping_host="www.baidu.com"

log_info() {
	echo "$(date): INFO  : $*" >>"$LOG_FILE"
}
log_error() {
	echo "$(date): ERROR : $*" >>"$LOG_FILE"
}

check_wan() {
	# 检测网络连接是否正常
	ping -c 3 ${ping_host} >/dev/null
}

check_wan

if [ "$?" != "0" ]; then
	log_error "网络错误，即将重启动 WAN 接口"

	# 重启 WAN 接口
	ifup wan >/dev/null
	
	#/etc/init.d/network restart >/dev/null
	log_info "WAN 接口已重启"
	sleep 20
	check_wan
	[ "$?" = "0" ] && log_info "WAN 接口重启成功，网络已正常" && return 0
	log_error "重启WAN接口后，网络仍然错误"
	
	
#   else
    
	
	#  log_info "网络正常，无需执行任何操作"
fi


exit 0
