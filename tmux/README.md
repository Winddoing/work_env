

# tmux

## 命令

* tmux new-session -s basic # 创建一个名为 basic 的 session
* tmux new -s basic -d # 同上，但是不会连接到终端，在后台运行
* tmux new -s basic -n win # 同上，并将第一个窗口命令为 win
* tmux ls # 列出现在的 sessions ，等同 tmux list-sessioin
* tmux attach # 如果只有一个 session
* tmux attach -t basic # 指定名称，-t 表示 target
* tmux kill-session -t basic # 关闭一个 session


## 操作

* `C-b 空格键` 采用下一个内置布局
* `C-b !` 把当前窗口变为新窗口
* `C-b -` 模向分隔窗口
* `C-b \` 纵向分隔窗口
* `C-b q` 显示分隔窗口的编号
* `C-b 方向键` 分隔窗口切换
* `C-b ALT-方向键` 调整分隔窗口大小
* `C-b c` 创建新窗口
* `C-b 1~9` 选择几号窗口
* `C-b c` 创建新窗口
* `C-b n` 选择下一个窗口
* `C-b l` 切换到最后使用的窗口
* `C-b p` 选择前一个窗口
* `C-b w` 以菜单方式显示及选择窗口
* `C-b t` 显示时钟
* `C-b ;` 切换到最后一个使用的面板
* `C-b x` 关闭面板
* `C-b &` 关闭窗口
* `C-b s` 以菜单方式显示和选择会话
* `C-b d` 退出tumx，并保存当前会话，这时，tmux仍在后台运行，可以通过tmux attach进入 到指定的会话

## 插件

### 插件管理

[Tmux Plugin Manager](https://github.com/tmux-plugins/tpm)

	prefix + I

Installs new plugins from GitHub or any other git repository
Refreshes TMUX environment

	prefix + U

updates plugin(s)

	prefix + alt + u

remove/uninstall plugins not on the plugin list


## 脚本启动

``` shell
tmux_init()
{
	tmux new-session -s "kumu" -d -n "local" # 开启一个会话
	tmux new-window -n "other" # 开启一个窗口
	tmux split-window -h # 开启一个竖屏
	tmux split-window -v "top" # 开启一个横屏,并执行top命令
	tmux -2 attach-session -d # tmux -2强制启用256color，连接已开启的tmux
}
```
* 自动关联session
```shell
if which tmux 2>&1 >/dev/null; then
	test -z "$TMUX" && (tmux attach || tmux_init)
fi
```
