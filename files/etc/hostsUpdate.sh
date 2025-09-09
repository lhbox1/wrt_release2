#以下命令会下载新版 hosts 文件保存为 /etc目录下的 newhosts 文件
curl https://raw.hellogithub.com/hosts > /etc/hostsnew
#删除原有 hosts 文件中的过时 hosts 信息
cp -a /etc/hosts /etc/hosts.bak
#然后删除 /etc/hosts 中已有的过时 hosts 信息
sed -i '/# GitHub520 Host Start/,/# GitHub520 Host End/d' /etc/hosts
#新增新版 hosts 规则
cat /etc/hostsnew >> /etc/hosts
# 重启 OpenClash 服务
# if /etc/init.d/openclash status | grep -q 'running'; then
 #    /etc/init.d/openclash restart
# else
 #   /etc/init.d/openclash start
# fi

#  13 3 * * * /etc/hostsUpdate.sh
