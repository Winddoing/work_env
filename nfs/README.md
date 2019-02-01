# NFS


## 配置参数

```
/home *(rw,sync,no_root_squash)
```
> man 5 exports

- `/home`: 共享目录
- `*`: （IP网段指定哪些用户可以访问）`*`表示所以可以ping通的主机都可以访问
- `rw`: 读写
- `ro`：只读
- `sync`: 同步
- `no_root_squash`: 不降低root用户的权限


## 查看服务端的共享目录

```
showmount -e 192.168.1.11
Export list for 192.168.1.11:
/home *
```

## 挂载到本地

```
mount 192.168.1.11:/home  /mnt 
```
