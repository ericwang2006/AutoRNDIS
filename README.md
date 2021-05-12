# 简介

本项目用于解决以下问题

OpenWrt路由器通过Android手机USB网络共享(RNDIS)方式联网时，手机有时会意外关闭网络共享(比如路由器断电)，当种情况发生时，脚本通过定时任务发现并自动打开手机的USB网络共享。

# 使用方法

1. 手机开启开发者模式

2. OpenWrt路由器需要安装adb

   参考命令

   ```shell
   opkg update
   opkg install adb
   ```

3. 手机通过USB线连接路由器，手机会提示是否信任，选择信任。

4. 将本项目脚本文件`net_check.sh`和`wan_check.sh`保存到路由器并加可执行权限

   ```shell
   wget -O /usr/bin/net_check.sh https://raw.githubusercontent.com/ericwang2006/AutoRNDIS/master/net_check.sh
   wget -O /usr/bin/wan_check.sh https://raw.githubusercontent.com/ericwang2006/AutoRNDIS/master/wan_check.sh
   chmod +x /usr/bin/net_check.sh /usr/bin/wan_check.sh
   ```

5. OpenWrt计划任务添加

   ```shell
   #如果手机没有开启USB网络共享就开启
   */5 * * * *  /usr/bin/net_check.sh
   #如果长时间断网就重启一次手机
   */50 * * * * /usr/bin/wan_check.sh
   ```