
# 定时同步

## crontab

添加任务
``` shell
crontab -e #编辑当前用户的定时任务

0 18 * * * /home/wqshao/.work_env/rsync-backup/rsync_vm_win7.sh #每天下午六点
```

``` shell
crontab -l
```
> 查看当前用户下的cron任务


``` shell
crontab -r
```
> 删除目前的时程表


``` shell
crontab -u linuxso -e
```
> 编辑用户linuxso的定时任务


### 格式

```
# For details see man 4 crontabs

# Example of job definition:
# .---------------- minute (0 - 59)
# |  .------------- hour (0 - 23)
# |  |  .---------- day of month (1 - 31)
# |  |  |  .------- month (1 - 12) OR jan,feb,mar,apr ...
# |  |  |  |  .---- day of week (0 - 6) (Sunday=0 or 7) OR sun,mon,tue,wed,thu,fri,sat
# |  |  |  |  |
# *  *  *  *  * user-name command to be executed
  *  *  *  *  *           command
```
> `*`:表示时间不受限制


# 同步

## rsync
