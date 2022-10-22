# 移动硬盘（Move Hard Disk）

系统检测到移动硬盘插入后，将特定目录进行自动备份


## 检测是否有设备插入

1. 检测是否插入硬盘设备
2. 启动文件同步服务

```
./mhd_monitor.path
```

## 文件同步

1. 判断插入设备是否为需要备份的硬盘
2. 进行数据备份

```
./mhd_backup.service
```

## 参考

- [linux实现插入U盘自动备份到TF卡](https://zhuanlan.zhihu.com/p/389178014)
