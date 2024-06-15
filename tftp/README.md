

## 安装

安装脚本使用tftpd-hpa, [man手册](https://manpages.debian.org/testing/tftpd-hpa/tftpd.8.en.html)

### 软件包：

`tftpd（服务端）`，`tftp（客户端）`，`xinetd` 

```
sudo apt-get install tftpd tftp xinetd
```

### 建立配置文件：

```
vi /etc/xinetd.d/tftp

service tftp
{
    protocol        = udp
    port            = 69
    socket_type     = dgram
    wait            = yes
    user            = nobody
    server          = /usr/sbin/in.tftpd
    server_args     = /home/xxx/tftprootfs
    disable         = no
}
```

### 重启服务

```
sudo /etc/init.d/xinetd restart
```

## 本地测试

```
$tftp localhost
tftp> get aaa
Received 8 bytes in 0.0 seconds
```

## 开发板使用

下载：

```
tftp –gr 源文件名  服务器地址  
```

上传：

```
tftp –pr 目标文件名 服务器地址
```

## tftp与tftp-hpa的区别

tftpd 和 tftpd-hpa 都是用于实现 TFTP (Trivial File Transfer Protocol) 协议的守护进程，它们的主要作用是在网络中提供简单的文件传输服务，通常用于没有足够资源运行更复杂的文件传输协议（如FTP）的环境，例如在网络设备的固件升级或PXE引导中。

tftpd 是一个基本的 TFTP 服务器实现，而 tftpd-hpa 是一个功能增强版本，具有以下优势：

- 功能增强
  - `tftpd-hpa` 支持更多的选项和特性，比如支持更大的文件传输（大于4GB），这对于现代操作系统和应用程序来说非常重要。
  - 它还可能支持一些高级特性，如块大小协商、多播传输、以及更复杂的错误处理。

- 兼容性和移植
- 安全性
  - `tftpd-hpa` 可能包含额外的安全特性，例如限制访问控制、日志记录等

- 配置灵活
  - `tftpd-hpa` 提供了更多的配置选项，允许管理员更精细地调整服务器的行为。

- 维护支持
  - `tftpd-hpa` 通常会有更活跃的开发和维护团队，这意味着它可能会得到更频繁的更新和bug修复。


