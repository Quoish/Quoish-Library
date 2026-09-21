# Linux 常用命令速查手册

> 范围：收录常见、主要遵循“命令 + 选项 + 参数”形式的 Linux 命令。暂不展开 `vi`/`vim`、`emacs`、`tmux`、`screen`、复杂 `awk` 编程、Shell 脚本语法等内容。
>
> 示例输出均为“典型输出”，会因发行版、软件版本、用户名、时间、文件内容和系统状态而不同。命令区分大小写。
>
> “名称来源”优先采用命令作者、项目文档或 Unix 传统中的通行解释。并非所有命令名都是正式首字母缩写；属于字面命名、双关、后人反向解释或存在多种说法的条目，会在正文中明确说明。
>
> 选项表中的“字母来源”用于说明短选项的英文全词或助记来源。长选项本身已经写明含义、来源过长、字母只是历史约定，或没有可靠解释时，该单元格留空。

## 目录

1. [阅读约定](#1-阅读约定)
2. [目录与路径](#2-目录与路径)
3. [文件操作与信息](#3-文件操作与信息)
4. [查看与分页显示文本](#4-查看与分页显示文本)
5. [文本统计、整理与转换](#5-文本统计整理与转换)
6. [搜索、筛选与比较](#6-搜索筛选与比较)
7. [简单文本替换](#7-简单文本替换)
8. [权限、所有权与用户身份](#8-权限所有权与用户身份)
9. [系统与时间信息](#9-系统与时间信息)
10. [进程与作业控制](#10-进程与作业控制)
11. [磁盘与文件系统](#11-磁盘与文件系统)
12. [归档与压缩](#12-归档与压缩)
13. [网络诊断与传输](#13-网络诊断与传输)
14. [远程登录与文件同步](#14-远程登录与文件同步)
15. [软件包管理](#15-软件包管理)
16. [systemd 服务与日志](#16-systemd-服务与日志)
17. [帮助与命令发现](#17-帮助与命令发现)
18. [Shell 输出、变量与历史](#18-shell-输出变量与历史)
19. [批量参数、校验与底层复制](#19-批量参数校验与底层复制)
20. [常见组合范例](#20-常见组合范例)
21. [退出码、管道和重定向速记](#21-退出码管道和重定向速记)
22. [使用建议](#22-使用建议)

## 1. 阅读约定

### 1.1 通用语法

```text
命令 [选项] [参数...]
```

- `[]`：可省略的部分，不要把方括号原样输入。
- `...`：前一项可以写多个。
- `<文件>`：替换成实际文件名，如 `notes.txt`。
- `<目录>`：替换成实际目录，如 `/var/log`。
- `<用户>`：替换成用户名，如 `alice`。
- `<PID>`：替换成进程号，如 `2468`。
- 短选项常可合并：`ls -l -a -h` 通常可写成 `ls -lah`。
- `--` 表示选项结束。例如删除名为 `-draft` 的文件可写 `rm -- -draft`。

### 1.2 路径写法

| 写法 | 含义 |
|---|---|
| `/etc/hosts` | 从根目录开始的绝对路径 |
| `docs/readme.md` | 相对于当前目录的路径 |
| `.` | 当前目录 |
| `..` | 上一级目录 |
| `~` | 当前用户的主目录 |
| `~alice` | 用户 `alice` 的主目录 |

### 1.3 特别注意

- `rm`、`mv`、`chmod`、`chown`、`dd` 等命令可能造成数据丢失或权限问题；执行前检查路径。
- 通配符由 Shell 展开：`*` 匹配任意多个字符，`?` 匹配一个字符，`[0-9]` 匹配一个数字。
- 查看命令完整手册：`man <命令>`；查看简短帮助：`<命令> --help`。

---

## 2. 目录与路径

### 2.1 `pwd`：显示当前工作目录

- 名称来源：`pwd` 来自英语 “print working directory”，即“打印当前工作目录”。

- 语法

```bash
pwd [选项]
```

- 常用选项

| 选项 | 功能 | 字母来源 |
|---|---|---|
| `-L` | 显示包含符号链接的逻辑路径，通常为默认行为 | logical |
| `-P` | 解析符号链接，显示实际物理路径 | physical |

- 参数填写：不接受文件或目录参数。

- 示例

```console
$ pwd
/home/alice/projects
$ pwd -P
/mnt/data/projects
```

### 2.2 `ls`：列出目录内容

- 名称来源：`ls` 是英语 “list”的缩写，意为“列出”。

- 语法

```bash
ls [选项] [文件或目录...]
```

- 常用选项

| 选项 | 功能 | 字母来源 |
|---|---|---|
| `-l` | 使用长格式，显示权限、所有者、大小、时间等 | long |
| `-a` | 包含以 `.` 开头的隐藏项 | all |
| `-A` | 显示隐藏项，但不显示 `.` 和 `..` | almost all |
| `-h` | 与 `-l` 配合，以 KiB、MiB、GiB 等易读单位显示大小 | human-readable |
| `-R` | 递归列出子目录 | recursive |
| `-t` | 按修改时间排序，新的在前 | time |
| `-S` | 按文件大小排序，大的在前 | size |
| `-r` | 反转排序结果 | reverse |
| `-d` | 显示目录本身，而不是其内容 | directory |
| `-i` | 显示 inode 编号 | inode |
| `--color=auto` | 在终端中按文件类型着色 |  |

- 参数填写：可写一个或多个路径；省略时列出当前目录。

- 示例

```console
$ ls -lah /var/log
total 2.1M
drwxr-xr-x  9 root root 4.0K Sep 20 08:10 .
drwxr-xr-x 14 root root 4.0K Sep 18 12:00 ..
-rw-r-----  1 root adm   38K Sep 20 09:12 auth.log
```

### 2.3 `cd`：切换工作目录

- 名称来源：`cd` 来自英语 “change directory”，即“更改目录”。

- 语法

```bash
cd [选项] [目录]
```

- 常用选项/写法

| 写法 | 功能 | 字母来源 |
|---|---|---|
| `cd <目录>` | 进入指定目录 |  |
| `cd` 或 `cd ~` | 回到当前用户主目录 |  |
| `cd ..` | 进入上一级目录 |  |
| `cd -` | 返回上一次所在目录，并输出该路径 |  |
| `-L` | 按逻辑路径处理符号链接，通常为默认行为 | logical |
| `-P` | 使用解析符号链接后的物理路径 | physical |

- 参数填写：目录可以是绝对路径或相对路径；含空格时使用引号，如 `cd "My Files"`。

- 示例

```console
$ cd /var/log
$ cd -
/home/alice
```

### 2.4 `mkdir`：创建目录

- 名称来源：`mkdir` 来自英语 “make directory”，即“创建目录”。

- 语法

```bash
mkdir [选项] <目录...>
```

- 常用选项

| 选项 | 功能 | 字母来源 |
|---|---|---|
| `-p` | 自动创建缺失的父目录；目录已存在时不报错 | parents |
| `-m <权限>` | 创建时直接设置权限，如 `755` | mode |
| `-v` | 显示创建过程 | verbose |

- 参数填写：至少填写一个目录名；可一次创建多个目录。

- 示例

```console
$ mkdir -pv project/{src,docs}
mkdir: created directory 'project'
mkdir: created directory 'project/src'
mkdir: created directory 'project/docs'
```

### 2.5 `rmdir`：删除空目录

- 名称来源：`rmdir` 来自英语 “remove directory”，即“删除目录”。

- 语法

```bash
rmdir [选项] <空目录...>
```

- 常用选项

| 选项 | 功能 | 字母来源 |
|---|---|---|
| `-p` | 删除目录后，继续删除变空的父目录 | parents |
| `-v` | 显示删除过程 | verbose |
| `--ignore-fail-on-non-empty` | 目录非空时不把该情况视为错误 |  |

- 参数填写：只能填写空目录；删除非空目录通常使用 `rm -r`，但风险更高。

- 示例

```console
$ rmdir -v empty_dir
rmdir: removing directory, 'empty_dir'
```

### 2.6 `tree`：以树状结构显示目录

- 名称来源：`tree` 是英语“树”的本义，因输出形状像目录树而得名。

> 某些系统需要先安装 `tree` 软件包。

- 语法

```bash
tree [选项] [目录]
```

- 常用选项

| 选项 | 功能 | 字母来源 |
|---|---|---|
| `-a` | 包含隐藏文件 | all |
| `-d` | 只显示目录 | directories |
| `-L <层数>` | 限制递归深度 | level |
| `-h` | 以易读单位显示大小 | human-readable |
| `-I <模式>` | 忽略匹配项，多个模式用 `\|` 分隔 | ignore |

- 参数填写：目录省略时使用当前目录；层数填正整数。

- 示例

```console
$ tree -L 2 project
project
├── docs
│   └── guide.md
└── src
    └── main.py

2 directories, 2 files
```

### 2.7 `basename`：取路径中的最后一段

- 名称来源：`basename` 由英语 “base name” 构成，指路径最末端的基础名称。

- 语法

```bash
basename [选项] <路径> [后缀]
```

- 常用选项

| 选项 | 功能 | 字母来源 |
|---|---|---|
| `-s <后缀>` | 删除结果末尾的指定后缀 | suffix |
| `-a` | 接受多个路径参数，通常与 `-s` 配合 | all arguments |
| `-z` | 每项以 NUL 字符而非换行结尾，便于脚本处理 | zero-terminated |

- 参数填写：路径不必真实存在；第二个参数或 `-s` 指定要去掉的后缀。

- 示例

```console
$ basename /home/alice/report.txt .txt
report
```

### 2.8 `dirname`：取路径中的目录部分

- 名称来源：`dirname` 由英语 “directory name” 缩合而来，指路径中的目录部分。

- 语法

```bash
dirname [选项] <路径...>
```

- 常用选项

| 选项 | 功能 | 字母来源 |
|---|---|---|
| `-z` | 每项以 NUL 字符而非换行结尾 | zero-terminated |
| `--help` | 显示帮助 |  |

- 参数填写：可填一个或多个路径，路径不必真实存在。

- 示例

```console
$ dirname /home/alice/report.txt
/home/alice
```

### 2.9 `realpath`：规范化并输出绝对路径

- 名称来源：`realpath` 由英语 “real path” 构成，表示解析并规范化后的实际路径。

- 语法

```bash
realpath [选项] <路径...>
```

- 常用选项

| 选项 | 功能 | 字母来源 |
|---|---|---|
| `-e` | 路径的所有组成部分都必须存在 | existing |
| `-m` | 即使部分路径不存在也进行规范化 | missing components allowed |
| `-s` | 不展开符号链接 | strip symlink expansion |
| `--relative-to=<目录>` | 输出相对于指定目录的路径 |  |

- 参数填写：填写相对或绝对路径；是否允许不存在的路径由选项决定。

- 示例

```console
$ realpath ./docs/../src/main.py
/home/alice/project/src/main.py
```

---

## 3. 文件操作与信息

### 3.1 `touch`：创建空文件或更新时间戳

- 名称来源：`touch` 是英语“触碰”；早期 Unix 中“触碰”文件即可更新其时间戳，后来也用于创建空文件。

- 语法

```bash
touch [选项] <文件...>
```

- 常用选项

| 选项 | 功能 | 字母来源 |
|---|---|---|
| `-a` | 只修改访问时间 | access time |
| `-m` | 只修改修改时间 | modification time |
| `-c` | 文件不存在时不创建 | no create |
| `-d <时间>` | 使用指定时间，如 `2026-09-20 10:30` | date |
| `-r <参考文件>` | 复制参考文件的时间戳 | reference |

- 参数填写：可写一个或多个文件路径；默认不存在则创建空文件，存在则更新时间。

- 示例

```console
$ touch -d '2026-09-20 10:30' report.txt
$ stat -c '%y %n' report.txt
2026-09-20 10:30:00.000000000 +0800 report.txt
```

### 3.2 `cp`：复制文件或目录

- 名称来源：`cp` 是英语 “copy”的缩写，意为“复制”。

- 语法

```bash
cp [选项] <源...> <目标>
```

- 常用选项

| 选项 | 功能 | 字母来源 |
|---|---|---|
| `-r`、`-R` | 递归复制目录 | recursive |
| `-a` | 归档复制，尽量保留权限、时间、链接等属性 | archive |
| `-i` | 覆盖前询问 | interactive |
| `-n` | 不覆盖已存在文件；不同版本对其与其他覆盖选项的组合略有差异 | no clobber |
| `-u` | 仅当源文件更新或目标不存在时复制 | update |
| `-v` | 显示复制过程 | verbose |
| `-p` | 保留模式、所有权和时间戳 | preserve |
| `--backup` | 覆盖前为旧文件创建备份 |  |

- 参数填写：一个源和一个目标时，目标可为新文件名或目录；多个源时，最后一个参数必须是目录。

- 示例

```console
$ cp -av docs backup/
'docs' -> 'backup/docs'
'docs/guide.md' -> 'backup/docs/guide.md'
```

### 3.3 `mv`：移动或重命名文件/目录

- 名称来源：`mv` 是英语 “move”的缩写，意为“移动”。

- 语法

```bash
mv [选项] <源...> <目标>
```

- 常用选项

| 选项 | 功能 | 字母来源 |
|---|---|---|
| `-i` | 覆盖前询问 | interactive |
| `-n` | 不覆盖已存在的目标 | no clobber |
| `-f` | 强制覆盖，不询问 | force |
| `-u` | 仅当源更新或目标不存在时移动 | update |
| `-v` | 显示移动过程 | verbose |
| `--backup` | 覆盖前备份目标文件 |  |

- 参数填写：规则与 `cp` 类似；同一文件系统内移动通常很快。

- 示例

```console
$ mv -v draft.txt report.txt
renamed 'draft.txt' -> 'report.txt'
```

### 3.4 `rm`：删除文件或目录

- 名称来源：`rm` 是英语 “remove”的缩写，意为“移除”。

- 语法

```bash
rm [选项] <文件或目录...>
```

- 常用选项

| 选项 | 功能 | 字母来源 |
|---|---|---|
| `-i` | 每次删除前询问 | interactive |
| `-I` | 删除多个文件或递归删除前只询问一次 | interactive once |
| `-f` | 强制删除，不询问；不存在也不报错 | force |
| `-r`、`-R` | 递归删除目录及其内容 | recursive |
| `-v` | 显示删除过程 | verbose |
| `-d` | 删除空目录 | directory |
| `--preserve-root` | 防止递归删除 `/`；GNU `rm` 通常默认启用 |  |

- 参数填写：填写明确路径。文件名以 `-` 开头时写成 `rm -- -name`。`rm -rf` 风险极高，执行前先用 `ls` 核对目标。

- 示例

```console
$ rm -Iv old1.log old2.log
rm: remove 2 arguments? y
removed 'old1.log'
removed 'old2.log'
```

### 3.5 `ln`：创建硬链接或符号链接

- 名称来源：`ln` 是英语 “link”的缩写，意为“链接”。

- 语法

```bash
ln [选项] <目标> <链接名>
ln [选项] <目标...> <目录>
```

- 常用选项

| 选项 | 功能 | 字母来源 |
|---|---|---|
| `-s` | 创建符号链接；不加时创建硬链接 | symbolic |
| `-f` | 删除已存在的同名目标后创建 | force |
| `-i` | 覆盖前询问 | interactive |
| `-n` | 把指向目录的已有符号链接视为普通文件 | no dereference |
| `-r` | 创建相对符号链接 | relative |
| `-v` | 显示过程 | verbose |

- 参数填写：第一个参数是原目标，第二个是新链接名。符号链接可以跨文件系统，也可以指向目录。

- 示例

```console
$ ln -sv /opt/app/current/app app
'app' -> '/opt/app/current/app'
$ ls -l app
lrwxrwxrwx 1 alice alice 20 Sep 20 10:00 app -> /opt/app/current/app
```

### 3.6 `file`：判断文件类型

- 名称来源：`file` 直接取自英语“文件”，用于识别文件的数据类型。

- 语法

```bash
file [选项] <文件...>
```

- 常用选项

| 选项 | 功能 | 字母来源 |
|---|---|---|
| `-b` | 不显示文件名，只显示类型 | brief |
| `-i` | 输出 MIME 类型及字符集 |  |
| `-L` | 跟随符号链接 | links |
| `-z` | 尝试查看压缩文件内部内容的类型 | zipped / compressed files |

- 参数填写：填写一个或多个文件路径。

- 示例

```console
$ file -i logo.png README.md
logo.png: image/png; charset=binary
README.md: text/plain; charset=utf-8
```

### 3.7 `stat`：显示文件或文件系统详细信息

- 名称来源：`stat` 来自英语 “status”，表示取得文件或文件系统的状态信息。

- 语法

```bash
stat [选项] <文件...>
```

- 常用选项

| 选项 | 功能 | 字母来源 |
|---|---|---|
| `-c <格式>` | 按指定格式输出 | custom format |
| `-f` | 显示文件所在文件系统的信息 | file system |
| `-L` | 跟随符号链接 | dereference links |
| `-t` | 使用简洁格式 | terse |

常用格式符：`%n` 文件名、`%s` 字节数、`%A` 可读权限、`%a` 八进制权限、`%U` 所有者、`%y` 修改时间。

- 参数填写：填写一个或多个存在的路径。

- 示例

```console
$ stat -c '%A %U %s %n' report.txt
-rw-r--r-- alice 1280 report.txt
```

### 3.8 `install`：复制文件并设置属性

- 名称来源：`install` 直接取自英语“安装”，这里特指复制文件并设置安装属性。

- 语法

```bash
install [选项] <源> <目标>
install -d [选项] <目录...>
```

- 常用选项

| 选项 | 功能 | 字母来源 |
|---|---|---|
| `-m <权限>` | 设置权限，默认通常为 `755` | mode |
| `-o <用户>` | 设置所有者，通常需要管理员权限 | owner |
| `-g <组>` | 设置所属组 | group |
| `-d` | 创建目录而不是复制文件 | directory |
| `-D` | 创建目标路径中缺失的父目录 | directories |
| `-v` | 显示过程 | verbose |

- 参数填写：源为已有文件；目标为文件名或目录。常用于安装脚本，不等同于软件包管理器。

- 示例

```console
$ install -Dm755 mytool ./stage/usr/local/bin/mytool
'mytool' -> './stage/usr/local/bin/mytool'
```

---

## 4. 查看与分页显示文本

### 4.1 `cat`：连接并输出文件内容

- 名称来源：`cat` 来自英语 “concatenate”，意为“连接”；最初用途是依次连接文件内容。

- 语法

```bash
cat [选项] [文件...]
```

- 常用选项

| 选项 | 功能 | 字母来源 |
|---|---|---|
| `-n` | 为所有输出行编号 | number |
| `-b` | 只为非空行编号，会覆盖 `-n` | nonblank lines |
| `-s` | 把连续空行压缩为一个空行 | squeeze blank lines |
| `-A` | 显示制表符、行尾等不可见字符 | show all |
| `-E` | 在每行末尾显示 `$` | show ends |
| `-T` | 把制表符显示为 `^I` | show tabs |

- 参数填写：文件可写多个并按顺序连接；省略文件或写 `-` 时读取标准输入。

- 示例

```console
$ cat -n hello.txt
     1  Hello
     2  Linux
```

### 4.2 `less`：分页查看长文本

- 名称来源：`less` 是对早期分页器 `more` 的幽默呼应，取自俗语 “less is more”。

- 语法

```bash
less [选项] <文件>
```

- 常用选项

| 选项 | 功能 | 字母来源 |
|---|---|---|
| `-N` | 显示行号 | line numbers |
| `-S` | 长行不换行，可水平滚动 |  |
| `-i` | 搜索时忽略大小写（模式含大写时仍区分） | ignore case |
| `-R` | 显示 ANSI 颜色控制序列 | raw control characters |
| `+F` | 类似 `tail -f`，持续查看追加内容 | forward forever / follow |

- 参数填写：通常填一个文本文件，也可接收管道输入。常用按键：`Space` 下一页、`b` 上一页、`/词` 搜索、`n` 下一个、`q` 退出。

- 示例（屏幕内容节选）

```console
$ less -N app.log
      1  2026-09-20 10:00:00 server started
      2  2026-09-20 10:00:02 request accepted
app.log (END)
```

### 4.3 `more`：简单分页查看文本

- 名称来源：`more` 取自分页提示 “--More--”，表示还有更多内容可看。

- 语法

```bash
more [选项] <文件...>
```

- 常用选项

| 选项 | 功能 | 字母来源 |
|---|---|---|
| `-d` | 显示按键提示 | display prompts |
| `-s` | 合并连续空行 | squeeze blank lines |
| `-n <行数>` | 指定每屏行数；部分实现也接受 `-<数字>` | number of lines |
| `+<行号>` | 从指定行开始显示 |  |

- 参数填写：填写文件路径，也可接收管道输入。按 `Space` 翻页、`Enter` 下一行、`q` 退出。

- 示例（屏幕内容节选）

```console
$ more +20 notes.txt
This is line 20.
This is line 21.
--More--(35%)
```

### 4.4 `head`：显示开头若干行或字节

- 名称来源：`head` 是英语“头部”，表示取文本开头部分。

- 语法

```bash
head [选项] [文件...]
```

- 常用选项

| 选项 | 功能 | 字母来源 |
|---|---|---|
| `-n <数量>` | 显示前若干行，默认 10 行 | number of lines |
| `-n -<数量>` | 显示除末尾若干行之外的内容 | number of lines |
| `-c <数量>` | 显示前若干字节，可用 `K`、`M` 等后缀 | byte count |
| `-q` | 多文件时不显示文件名标题 | quiet |
| `-v` | 始终显示文件名标题 | verbose |

- 参数填写：可填写多个文件；省略时读取标准输入。

- 示例

```console
$ head -n 2 names.txt
Alice
Bob
```

### 4.5 `tail`：显示末尾内容或持续跟踪文件

- 名称来源：`tail` 是英语“尾部”，表示取文本末尾部分。

- 语法

```bash
tail [选项] [文件...]
```

- 常用选项

| 选项 | 功能 | 字母来源 |
|---|---|---|
| `-n <数量>` | 显示末尾若干行，默认 10 行 | number of lines |
| `-n +<行号>` | 从指定行开始显示到结尾 | number of lines |
| `-c <数量>` | 显示末尾若干字节 | byte count |
| `-f` | 文件增长时持续输出追加内容 | follow |
| `-F` | 持续跟踪文件名；日志轮转后重新打开 | follow by name |
| `--pid=<PID>` | 与 `-f` 配合，指定进程结束后停止 |  |

- 参数填写：填写日志等文件；持续跟踪时按 `Ctrl+C` 停止。

- 示例

```console
$ tail -n 2 app.log
2026-09-20 10:01:12 GET /health 200
2026-09-20 10:01:13 GET /api 200
```

### 4.6 `nl`：给文本添加行号

- 名称来源：`nl` 来自英语 “number lines”，即“给行编号”。

- 语法

```bash
nl [选项] [文件]
```

- 常用选项

| 选项 | 功能 | 字母来源 |
|---|---|---|
| `-ba` | 为所有行编号，包括空行 | b = body；a = all |
| `-bt` | 只为非空行编号，通常为默认值 | b = body；t = nonempty text |
| `-n ln` | 行号左对齐 | number format |
| `-n rz` | 行号右对齐并补零 | number format |
| `-w <宽度>` | 设置行号栏宽度 | width |
| `-s <字符串>` | 设置行号与正文之间的分隔符 | separator |

- 参数填写：文件可省略，省略时读取标准输入。

- 示例

```console
$ nl -ba -w2 -s': ' hello.txt
 1: Hello
 2: 
 3: Linux
```

---

## 5. 文本统计、整理与转换

### 5.1 `wc`：统计行数、单词数和字节数

- 名称来源：`wc` 来自英语 “word count”，即“单词计数”。

- 语法

```bash
wc [选项] [文件...]
```

- 常用选项

| 选项 | 功能 | 字母来源 |
|---|---|---|
| `-l` | 行数 | lines |
| `-w` | 单词数 | words |
| `-c` | 字节数 | byte count |
| `-m` | 字符数，多字节字符下可能不同于 `-c` | multibyte characters |
| `-L` | 最长行的显示宽度 | maximum line length |

- 参数填写：可填多个文件；省略时统计标准输入。

- 示例

```console
$ wc -lwc notes.txt
  12   87  532 notes.txt
```

### 5.2 `sort`：对文本行排序

- 名称来源：`sort` 直接取自英语“排序”。

- 语法

```bash
sort [选项] [文件...]
```

- 常用选项

| 选项 | 功能 | 字母来源 |
|---|---|---|
| `-n` | 按数值排序 | numeric |
| `-h` | 按易读大小排序，如 `2K`、`1M` | human numeric |
| `-r` | 降序 | reverse |
| `-u` | 排序后去除重复行 | unique |
| `-f` | 忽略大小写 | fold case |
| `-t <字符>` | 指定字段分隔符 | field separator |
| `-k <范围>` | 指定排序键，如 `-k2,2n` 表示按第 2 字段数值排序 | key |
| `-o <文件>` | 把结果写入文件 | output |

- 参数填写：文件可省略；字段编号从 1 开始。

- 示例

```console
$ printf 'Bob,8\nAlice,12\nEve,5\n' | sort -t, -k2,2n
Eve,5
Bob,8
Alice,12
```

### 5.3 `uniq`：处理相邻重复行

- 名称来源：`uniq` 是英语 “unique”的缩写，表示识别或合并相邻重复行。

- 语法

```bash
uniq [选项] [输入文件 [输出文件]]
```

- 常用选项

| 选项 | 功能 | 字母来源 |
|---|---|---|
| `-c` | 在每行前显示出现次数 | count |
| `-d` | 只显示重复行 | duplicates |
| `-u` | 只显示未重复行 | unique |
| `-i` | 比较时忽略大小写 | ignore case |
| `-f <数量>` | 比较时跳过前若干字段 | fields |
| `-s <数量>` | 比较时跳过前若干字符 | skip characters |

- 参数填写：只合并相邻重复行，因此通常先用 `sort`。

- 示例

```console
$ printf 'red\nblue\nred\nred\n' | sort | uniq -c
      1 blue
      3 red
```

### 5.4 `cut`：按字符或字段提取列

- 名称来源：`cut` 直接取自英语“切取”，形象表示从每行切出指定字段或字符。

- 语法

```bash
cut [选项] [文件...]
```

- 常用选项

| 选项 | 功能 | 字母来源 |
|---|---|---|
| `-d <分隔符>` | 指定单字符字段分隔符 | delimiter |
| `-f <列表>` | 提取字段，如 `1,3`、`2-4` | fields |
| `-c <列表>` | 提取字符位置 | characters |
| `-b <列表>` | 提取字节位置 | bytes |
| `--complement` | 输出未被选中的部分 |  |
| `-s` | 不输出不含分隔符的行 | suppress undelimited lines |

- 参数填写：位置从 1 开始；列表可写 `1`、`1,3`、`2-`、`1-4`。

- 示例

```console
$ cut -d: -f1,7 /etc/passwd | head -n 3
root:/bin/bash
daemon:/usr/sbin/nologin
bin:/usr/sbin/nologin
```

### 5.5 `paste`：按列合并文件

- 名称来源：`paste` 直接取自英语“粘贴”，与 `cut` 相对，用于把多份文本按列拼合。

- 语法

```bash
paste [选项] <文件...>
```

- 常用选项

| 选项 | 功能 | 字母来源 |
|---|---|---|
| `-d <字符列表>` | 指定输出分隔符，默认是制表符 | delimiters |
| `-s` | 逐个文件串行合并其所有行 | serial |
| `-z` | 以 NUL 字符作为行分隔符 | zero-terminated |

- 参数填写：按行并排合并多个文件；使用 `-` 表示标准输入。

- 示例

```console
$ paste -d, names.txt scores.txt
Alice,95
Bob,88
```

### 5.6 `tr`：替换、删除或压缩字符

- 名称来源：`tr` 来自英语 “translate” 或 “transliterate”，表示字符转换。

- 语法

```bash
tr [选项] <字符集1> [字符集2]
```

- 常用选项

| 选项 | 功能 | 字母来源 |
|---|---|---|
| `-d` | 删除字符集 1 中的字符 | delete |
| `-s` | 把连续重复字符压缩成一个 | squeeze repeats |
| `-c`、`-C` | 使用字符集 1 的补集 | complement |
| `-t` | 先把字符集 1 截短到字符集 2 的长度 | truncate |

- 参数填写：从标准输入读取，不直接接受文件名。可用范围 `a-z` 和字符类 `[:lower:]`。

- 示例

```console
$ printf 'Hello   Linux!\n' | tr '[:lower:]' '[:upper:]' | tr -s ' '
HELLO LINUX!
```

### 5.7 `tee`：同时输出到屏幕和文件

- 名称来源：`tee` 得名于 T 形管接头：数据流像水流一样被分成屏幕和文件两个方向。

- 语法

```bash
tee [选项] <文件...>
```

- 常用选项

| 选项 | 功能 | 字母来源 |
|---|---|---|
| `-a` | 追加到文件，而不是覆盖 | append |
| `-i` | 忽略中断信号 | ignore interrupts |
| `-p` | 更合适地处理写入管道时的错误 | pipes |

- 参数填写：从标准输入读取；可同时写入多个文件。写受保护文件时常用 `命令 | sudo tee 文件`。

- 示例

```console
$ printf 'ready\n' | tee -a status.log
ready
$ tail -n 1 status.log
ready
```

### 5.8 `column`：把文本整理成表格

- 名称来源：`column` 直接取自英语“列”，表示把文本排列成列。

> 通常由 `util-linux` 软件包提供。

- 语法

```bash
column [选项] [文件...]
```

- 常用选项

| 选项 | 功能 | 字母来源 |
|---|---|---|
| `-t` | 自动对齐成表格 | table |
| `-s <分隔符>` | 指定输入分隔符 | separator |
| `-o <字符串>` | 指定输出列分隔符 | output |
| `-N <列名列表>` | 为表格指定列名；新版本支持 | column names |

- 参数填写：可读取文件或标准输入；不同发行版版本的高级选项可能不同。

- 示例

```console
$ printf 'name,score\nAlice,95\nBob,88\n' | column -t -s,
name   score
Alice  95
Bob    88
```

### 5.9 `rev`：反转每一行的字符顺序

- 名称来源：`rev` 是英语 “reverse”的缩写，表示反转。

- 语法

```bash
rev [文件...]
```

- 常用选项：通常只有 `--help`、`--version`。

- 参数填写：可写多个文件；省略时读取标准输入。

- 示例

```console
$ printf 'Linux\n' | rev
xuniL
```

### 5.10 `seq`：生成数字序列

- 名称来源：`seq` 是英语 “sequence”的缩写，表示序列。

- 语法

```bash
seq [选项] <末值>
seq [选项] <首值> <末值>
seq [选项] <首值> <步长> <末值>
```

- 常用选项

| 选项 | 功能 | 字母来源 |
|---|---|---|
| `-w` | 用前导零补齐宽度 | equal width |
| `-s <字符串>` | 指定数字之间的分隔符，默认换行 | separator |
| `-f <格式>` | 使用 `printf` 风格格式，如 `%03g` | format |

- 参数填写：数值可为整数或小数；步长可为负数。

- 示例

```console
$ seq -w -s ', ' 1 2 9
1, 3, 5, 7, 9
```

---

## 6. 搜索、筛选与比较

### 6.1 `grep`：按模式筛选文本行

- 名称来源：`grep` 源自 `ed` 编辑器命令 `g/re/p`，意为“全局搜索正则表达式并打印”。

- 语法

```bash
grep [选项] <模式> [文件...]
```

- 常用选项

| 选项 | 功能 | 字母来源 |
|---|---|---|
| `-i` | 忽略大小写 | ignore case |
| `-v` | 反选，即输出不匹配的行 | invert match |
| `-n` | 显示行号 | line number |
| `-r`、`-R` | 递归搜索目录；`-R` 会跟随所有符号链接 | recursive；recursive with links |
| `-l` | 只显示包含匹配内容的文件名 | list matching files |
| `-c` | 只显示每个文件的匹配行数 | count |
| `-w` | 只匹配完整单词 | word regexp |
| `-x` | 只匹配完整一行 | whole line |
| `-E` | 使用扩展正则表达式 | extended regexp |
| `-F` | 把模式当作普通字符串，不解析正则 | fixed strings |
| `-A/-B/-C <数>` | 显示匹配行之后/之前/前后的若干行 | A = after；B = before；C = context |
| `--include=<模式>` | 只搜索匹配文件名的文件 |  |
| `--exclude=<模式>` | 排除匹配文件名的文件 |  |

- 参数填写：模式含空格或正则符号时用单引号；文件省略时读取标准输入。

- 示例

```console
$ grep -in 'error' app.log
17:2026-09-20 10:12:03 ERROR connection refused
42:2026-09-20 10:16:19 Error retry limit reached
```

### 6.2 `find`：按条件搜索文件并执行操作

- 名称来源：`find` 直接取自英语“查找”。

- 语法

```bash
find <起始路径...> [条件] [动作]
```

- 常用选项、条件和动作

| 写法 | 功能 | 字母来源 |
|---|---|---|
| `-name '<模式>'` | 按文件名匹配，区分大小写 |  |
| `-iname '<模式>'` | 按文件名匹配，忽略大小写 |  |
| `-type f/d/l` | 只匹配普通文件/目录/符号链接 |  |
| `-size +10M` | 大于 10 MiB；`-10M` 表示小于 |  |
| `-mtime -7` | 修改时间在 7×24 小时内 |  |
| `-mmin -30` | 修改时间在 30 分钟内 |  |
| `-user <用户>` | 按所有者匹配 |  |
| `-perm <模式>` | 按权限匹配 |  |
| `-maxdepth <层数>` | 限制搜索深度，应放在条件之前 |  |
| `-print` | 输出路径，默认动作 |  |
| `-delete` | 删除匹配项，使用前先以 `-print` 核对 |  |
| `-exec <命令> {} \;` | 对每项执行一次命令 |  |
| `-exec <命令> {} +` | 批量传给命令，通常更高效 |  |

条件默认用“且”连接；可用 `-o` 表示“或”，用 `\(` `\)` 分组。

- 参数填写：第一个参数是搜索起点，如 `.`、`/var/log`；文件名模式应加引号，防止 Shell 提前展开。

- 示例

```console
$ find ./logs -type f -name '*.log' -size +1M -print
./logs/app.log
./logs/archive/access.log
```

### 6.3 `locate`：通过索引快速查找路径

- 名称来源：`locate` 直接取自英语“定位”。

> 通常由 `plocate` 或 `mlocate` 提供；结果来自数据库，不一定反映刚发生的变化。

- 语法

```bash
locate [选项] <模式...>
```

- 常用选项

| 选项 | 功能 | 字母来源 |
|---|---|---|
| `-i` | 忽略大小写 | ignore case |
| `-b` | 只匹配路径最后的文件名部分 | basename |
| `-e` | 只显示当前仍存在的路径 | existing |
| `-l <数量>` | 限制结果数量 | limit |
| `-r <正则>` | 使用正则表达式 | regular expression |

- 参数填写：模式通常是文件名片段；索引可由管理员运行 `updatedb` 更新。

- 示例

```console
$ locate -b -e -l 3 '\hosts'
/etc/hosts
/usr/share/doc/hosts
```

### 6.4 `which`：查找将被执行的命令文件

- 名称来源：`which` 取自英语疑问词“哪一个”，询问当前环境会使用哪一个命令文件。

- 语法

```bash
which [选项] <命令名...>
```

- 常用选项

| 选项 | 功能 | 字母来源 |
|---|---|---|
| `-a` | 显示 `PATH` 中所有匹配项，而非只显示第一个 | all |
| `--skip-alias` | 某些实现中跳过别名处理 |  |

- 参数填写：填写命令名，不写路径。Shell 内建命令和别名更适合用 `type` 检查。

- 示例

```console
$ which -a python3
/usr/local/bin/python3
/usr/bin/python3
```

### 6.5 `whereis`：查找命令、源码和手册路径

- 名称来源：`whereis` 由英语问句 “where is” 合成，意为“它在哪里”。

- 语法

```bash
whereis [选项] <名称...>
```

- 常用选项

| 选项 | 功能 | 字母来源 |
|---|---|---|
| `-b` | 只查二进制文件 | binaries |
| `-m` | 只查手册文件 | manuals |
| `-s` | 只查源码 | sources |
| `-l` | 显示搜索目录列表 | list paths |

- 参数填写：填写程序的基础名称，如 `bash`，不要写完整路径。

- 示例

```console
$ whereis bash
bash: /usr/bin/bash /usr/share/man/man1/bash.1.gz
```

### 6.6 `type`：说明 Shell 如何解释命令名

- 名称来源：`type` 取自英语“类型”，用于说明一个名称属于别名、内建命令、函数还是外部文件。

- 语法

```bash
type [选项] <名称...>
```

- 常用选项（Bash）

| 选项 | 功能 | 字母来源 |
|---|---|---|
| `-a` | 显示所有匹配定义 | all |
| `-t` | 只输出类型：`alias`、`builtin`、`file` 等 | type |
| `-p` | 如果是外部命令则输出其路径 | path |
| `-P` | 强制从 `PATH` 查找外部命令 | PATH search |

- 参数填写：可填写命令、别名、函数或关键字名称。

- 示例

```console
$ type cd ls
cd is a shell builtin
ls is aliased to 'ls --color=auto'
```

### 6.7 `diff`：逐行比较文本文件或目录

- 名称来源：`diff` 是英语 “difference”的缩写，表示差异。

- 语法

```bash
diff [选项] <文件1> <文件2>
diff [选项] <目录1> <目录2>
```

- 常用选项

| 选项 | 功能 | 字母来源 |
|---|---|---|
| `-u` | 统一差异格式，最常用 | unified |
| `-r` | 递归比较目录 | recursive |
| `-q` | 只报告是否不同 | quiet |
| `-i` | 忽略大小写 | ignore case |
| `-w` | 忽略所有空白差异 | whitespace |
| `-B` | 忽略纯空行变化 | blank lines |
| `--color=auto` | 支持的版本中为差异着色 |  |

- 参数填写：填写两个文件或两个目录；退出码 `0` 表示相同，`1` 表示有差异，`2` 表示出错。

- 示例

```console
$ diff -u old.txt new.txt
--- old.txt
+++ new.txt
@@ -1,2 +1,2 @@
 hello
-world
+Linux
```

### 6.8 `cmp`：按字节比较两个文件

- 名称来源：`cmp` 是英语 “compare”的缩写，表示比较。

- 语法

```bash
cmp [选项] <文件1> <文件2>
```

- 常用选项

| 选项 | 功能 | 字母来源 |
|---|---|---|
| `-s` | 静默，只通过退出码表示结果 | silent |
| `-l` | 列出所有不同字节的位置和值 | list differences |
| `-n <数量>` | 最多比较指定字节数 | number of bytes |
| `-i <跳过量>` | 跳过两个文件开头的若干字节 | ignore initial bytes |

- 参数填写：填写两个文件；可用 `-` 表示标准输入，但不能两个都为 `-`。

- 示例

```console
$ cmp a.bin b.bin
a.bin b.bin differ: byte 5, line 1
```

### 6.9 `comm`：比较两个已排序文件

- 名称来源：`comm` 通常理解为英语 “common”的缩写，名称突出两个已排序文件的共有行。

- 语法

```bash
comm [选项] <已排序文件1> <已排序文件2>
```

- 常用选项

| 选项 | 功能 | 字母来源 |
|---|---|---|
| `-1` | 隐藏只在文件 1 中的行 |  |
| `-2` | 隐藏只在文件 2 中的行 |  |
| `-3` | 隐藏两文件共有的行 |  |
| `--check-order` | 检查输入是否已排序 |  |

- 参数填写：两个输入应按当前区域设置排序；常见写法 `comm -12` 只输出交集。

- 示例

```console
$ comm -12 users_a.txt users_b.txt
alice
bob
```

---

## 7. 简单文本替换

### 7.1 `sed`：按规则编辑文本流

- 名称来源：`sed` 来自英语 “stream editor”，即“流编辑器”。

本节只介绍 `sed` 的简单单行用法；复杂脚本另行学习。

- 语法

```bash
sed [选项] '<脚本>' [文件...]
```

- 常用选项

| 选项 | 功能 | 字母来源 |
|---|---|---|
| `-n` | 默认不输出；配合 `p` 只打印选中内容 | no automatic printing |
| `-E` | 使用扩展正则表达式 | extended regexp |
| `-e <脚本>` | 指定一条脚本，可重复使用 | expression |
| `-f <脚本文件>` | 从文件读取规则 | file |
| `-i[备份后缀]` | 原地修改文件；GNU/BSD 写法有差异，重要文件先备份 | in-place |

常见脚本：`s/旧/新/` 替换每行第一个，`s/旧/新/g` 替换全部，`3p` 打印第 3 行，`/词/d` 删除匹配行。

- 参数填写：脚本通常用单引号保护；文件省略时读取标准输入。

- 示例

```console
$ printf 'red red\nblue\n' | sed 's/red/green/g'
green green
blue
$ sed -n '2p' names.txt
Bob
```

---

## 8. 权限、所有权与用户身份

### 8.1 `chmod`：修改权限

- 名称来源：`chmod` 来自英语 “change mode”，这里的 mode 指 Unix 文件权限模式。

- 语法

```bash
chmod [选项] <权限> <文件或目录...>
```

- 常用选项

| 选项 | 功能 | 字母来源 |
|---|---|---|
| `-R` | 递归修改目录内容 | recursive |
| `-v` | 显示处理详情 | verbose |
| `-c` | 只显示权限确实发生变化的项目 | changes only |
| `--reference=<文件>` | 复制参考文件的权限 |  |

- 权限参数填写：

- 数字法：`r=4`、`w=2`、`x=1`，三位依次表示所有者、组、其他人。如 `755=rwxr-xr-x`、`644=rw-r--r--`。
- 符号法：对象 `u/g/o/a`，操作 `+/-/=`，权限 `r/w/x`。如 `u+x`、`g-w`、`a=r`。
- 递归修改时，应谨慎区分文件与目录所需的执行权限。

- 参数填写：权限参数使用上述数字法或符号法；其后填写一个或多个文件/目录路径。对目录使用 `-R` 时会处理其全部后代。

- 示例

```console
$ chmod u+x script.sh
$ chmod -v 640 secret.txt
mode of 'secret.txt' changed from 0644 (rw-r--r--) to 0640 (rw-r-----)
```

### 8.2 `chown`：修改所有者和所属组

- 名称来源：`chown` 来自英语 “change owner”，即“更改所有者”。

- 语法

```bash
chown [选项] <用户>[:<组>] <文件或目录...>
chown [选项] :<组> <文件或目录...>
```

- 常用选项

| 选项 | 功能 | 字母来源 |
|---|---|---|
| `-R` | 递归修改 | recursive |
| `-h` | 修改符号链接本身，而不是其目标 |  |
| `-v` | 显示处理详情 | verbose |
| `-c` | 只显示确实发生变化的项目 | changes only |
| `--reference=<文件>` | 复制参考文件的所有者和组 |  |

- 参数填写：`alice` 只改所有者；`alice:dev` 同时改用户和组；`:dev` 只改组。通常需要管理员权限。

- 示例

```console
$ sudo chown -v alice:developers report.txt
changed ownership of 'report.txt' from root:root to alice:developers
```

### 8.3 `chgrp`：修改所属组

- 名称来源：`chgrp` 来自英语 “change group”，即“更改所属组”。

- 语法

```bash
chgrp [选项] <组> <文件或目录...>
```

- 常用选项

| 选项 | 功能 | 字母来源 |
|---|---|---|
| `-R` | 递归修改 | recursive |
| `-h` | 修改符号链接本身 |  |
| `-v` | 显示详情 | verbose |
| `--reference=<文件>` | 使用参考文件的所属组 |  |

- 参数填写：组可填写组名或数字 GID；操作人必须有相应权限。

- 示例

```console
$ chgrp -v developers report.txt
changed group of 'report.txt' from alice to developers
```

### 8.4 `umask`：查看或设置新文件的权限掩码

- 名称来源：`umask` 通常解释为 “user mask”；其准确作用是设置文件模式创建掩码。

- 语法

```bash
umask [-S] [掩码]
```

- 常用选项/写法

| 写法 | 功能 | 字母来源 |
|---|---|---|
| `umask` | 以数字显示当前掩码 |  |
| `umask -S` | 以符号形式显示最终允许的权限 | symbolic |
| `umask 022` | 设置数字掩码 |  |
| `umask u=rwx,g=rx,o=` | 以符号形式设置 |  |

- 参数填写：常见 `022` 使新文件通常为 `644`、新目录为 `755`；`077` 只允许当前用户访问。仅影响当前 Shell 及其子进程。

- 示例

```console
$ umask
0022
$ umask -S
u=rwx,g=rx,o=rx
```

### 8.5 `id`：显示用户和组标识

- 名称来源：`id` 来自英语 “identifier/identity”，表示用户与组的身份标识。

- 语法

```bash
id [选项] [用户]
```

- 常用选项

| 选项 | 功能 | 字母来源 |
|---|---|---|
| `-u` | 只显示用户 ID | user |
| `-g` | 只显示主组 ID | group |
| `-G` | 显示全部组 ID | groups |
| `-n` | 与 `-u/-g/-G` 配合，显示名称而非数字 | name |
| `-r` | 显示真实 ID，而不是有效 ID | real ID |

- 参数填写：用户省略时显示当前进程身份；可填用户名或数字 UID。

- 示例

```console
$ id alice
uid=1000(alice) gid=1000(alice) groups=1000(alice),27(sudo),1001(developers)
```

### 8.6 `whoami`：显示当前有效用户名

- 名称来源：`whoami` 直接连写自英语问句 “Who am I?”，即“我是谁”。

- 语法

```bash
whoami [选项]
```

- 常用选项：`--help`、`--version`。

- 参数填写：不接受用户参数；等价于 `id -un`。

- 示例

```console
$ whoami
alice
```

### 8.7 `groups`：显示用户所属组

- 名称来源：`groups` 直接取自英语“组”，表示用户所属的各个用户组。

- 语法

```bash
groups [用户...]
```

- 常用选项：通常只有 `--help`、`--version`。

- 参数填写：省略用户时显示当前进程所属组；可填写多个用户名。

- 示例

```console
$ groups alice
alice : alice sudo developers
```

### 8.8 `who`：显示当前登录用户

- 名称来源：`who` 取自英语疑问词“谁”，用于回答“谁正在登录”。

- 语法

```bash
who [选项]
```

- 常用选项

| 选项 | 功能 | 字母来源 |
|---|---|---|
| `-H` | 显示列标题 | heading |
| `-a` | 显示尽可能完整的信息 | all |
| `-b` | 显示最近一次系统启动时间 | boot |
| `-q` | 只显示登录用户名和人数 | quick count |
| `-u` | 显示空闲时间和 PID | users / idle time |

- 参数填写：通常不填写参数。

- 示例

```console
$ who -H
NAME   LINE  TIME             COMMENT
alice  pts/0 2026-09-20 09:15 (192.168.1.10)
```

### 8.9 `w`：查看登录用户及其活动

- 名称来源：`w` 是单字母命令，可视为 `who` 的简写扩展，同时显示用户正在做什么。

- 语法

```bash
w [选项] [用户]
```

- 常用选项

| 选项 | 功能 | 字母来源 |
|---|---|---|
| `-h` | 不显示标题 | no header |
| `-s` | 使用短格式 | short |
| `-f` | 切换是否显示远程主机字段 | from host |
| `-i` | 以 IP 地址显示远程来源 | IP address |

- 参数填写：可选用户名用于只看该用户。

- 示例

```console
$ w -s
 10:20:04 up 3 days,  2:11,  1 user,  load average: 0.08, 0.10, 0.09
USER   TTY   FROM          IDLE WHAT
alice  pts/0 192.168.1.10  2:03 bash
```

### 8.10 `passwd`：修改登录密码

- 名称来源：`passwd` 是英语 “password”的传统缩写，Unix 早期文件名常受较短命名习惯影响。

- 语法

```bash
passwd [选项] [用户]
```

- 常用选项

| 选项 | 功能 | 字母来源 |
|---|---|---|
| `-S` | 显示密码状态 | status |
| `-l` | 锁定账户密码；通常需管理员权限 | lock |
| `-u` | 解锁账户密码 | unlock |
| `-d` | 删除密码，安全风险高 | delete password |
| `-e` | 让密码立即过期，下次登录必须修改 | expire |

- 参数填写：普通用户省略参数时修改自己的密码；管理员可填写目标用户名。密码输入不会回显。

- 示例

```console
$ passwd
Changing password for alice.
Current password:
New password:
Retype new password:
passwd: password updated successfully
```

### 8.11 `sudo`：以其他用户身份执行命令

- 名称来源：`sudo` 最初通常释为 “superuser do”；因可切换到其他用户，现在也常释为 “substitute user do”。

- 语法

```bash
sudo [选项] <命令> [命令参数...]
```

- 常用选项

| 选项 | 功能 | 字母来源 |
|---|---|---|
| `-u <用户>` | 以指定用户执行，默认是 `root` | user |
| `-i` | 启动目标用户的登录 Shell | initial login environment |
| `-s` | 启动 Shell，但环境处理不同于 `-i` | shell |
| `-k` | 使缓存的认证失效 | kill cached credentials |
| `-v` | 验证并刷新凭据有效期，不执行命令 | validate |
| `-l` | 列出当前用户获准执行的命令 | list |
| `-E` | 请求保留当前环境变量，是否允许取决于配置 | environment |

- 参数填写：`sudo` 后写完整命令及其参数；重定向由当前 Shell 先处理，写受保护文件可用 `printf ... | sudo tee 文件`。

- 示例

```console
$ sudo -u www-data id
uid=33(www-data) gid=33(www-data) groups=33(www-data)
```

### 8.12 `su`：切换用户或执行命令

- 名称来源：`su` 来自英语 “substitute user”，也常被理解为 “switch user”；目标用户默认为 `root`。

- 语法

```bash
su [选项] [用户]
```

- 常用选项

| 选项 | 功能 | 字母来源 |
|---|---|---|
| `-`、`-l` | 使用目标用户的登录环境 | login |
| `-c '<命令>'` | 以目标用户执行一条命令后退出 | command |
| `-s <Shell>` | 指定要使用的 Shell | shell |
| `-p` | 尽量保留当前环境 | preserve environment |

- 参数填写：用户省略时通常为 `root`；一般推荐 `su - <用户>` 获得完整登录环境。

- 示例

```console
$ su -c 'whoami' alice
Password:
alice
```

### 8.13 `groupadd`：创建用户组

- 名称来源：`groupadd` 由英语 “group add” 合成，即“添加用户组”。

- 语法

```bash
groupadd [选项] <组名>
```

- 常用选项

| 选项 | 功能 | 字母来源 |
|---|---|---|
| `-g <GID>` | 指定数字组 ID | GID = Group Identifier |
| `-r` | 创建系统组，通常从系统组 ID 范围分配编号 |  |
| `-f` | 组已存在时仍返回成功；与部分选项组合时还会采用可用 GID | force |
| `-o` | 与 `-g` 配合，允许使用非唯一 GID；通常不推荐 |  |
| `-R <目录>` | 在指定的 chroot 目录中操作账户数据库 | root directory |

- 参数填写：组名通常使用小写字母、数字、下划线和连字符，并应符合本机账户策略。`GID` 来自 **Group Identifier**，应填写未被占用的非负整数。通常需要管理员权限。

- 示例

```console
$ sudo groupadd -g 1500 developers
$ getent group developers
developers:x:1500:
```

`getent` 来自英语 “get entries”，用于从系统配置的名称服务数据库取得条目；其结果不一定只来自本地 `/etc/group`。

### 8.14 `groupmod`：修改用户组

- 名称来源：`groupmod` 由英语 “group modify” 缩合而来，即“修改用户组”。

- 语法

```bash
groupmod [选项] <现有组名>
```

- 常用选项

| 选项          | 功能                          | 字母来源                   |
| ----------- | --------------------------- | ---------------------- |
| `-n <新组名>`  | 修改组名                        | new name               |
| `-g <新GID>` | 修改数字组 ID                    | GID = Group Identifier |
| `-o`        | 与 `-g` 配合，允许使用非唯一 GID；通常不推荐 |                        |
| `-R <目录>`   | 在指定的 chroot 目录中操作账户数据库      | root directory         |
| `-a`        | 添加                          |                        |
|             |                             |                        |

- 参数填写：最后一个参数必须是当前存在的组名。修改 GID 后，应检查文件系统中是否仍有文件保留旧 GID；`groupmod` 不会可靠地替你处理所有文件系统、网络挂载或离线数据。

- 示例

```console
$ sudo groupmod -n appops appteam
$ getent group appops
appops:x:1600:
```

修改 GID 后可先查找旧 GID 对应的文件，再决定是否调整所有权：

```console
$ find /srv -group 1500 -print
/srv/project/report.txt
```

### 8.15 `groupdel`：删除用户组

- 名称来源：`groupdel` 由英语 “group delete” 缩合而来，即“删除用户组”。

- 语法

```bash
groupdel [选项] <组名>
```

- 常用选项

| 选项 | 功能 | 字母来源 |
|---|---|---|
| `-f` | 强制删除，即使该组仍是某用户的主组；风险较高，且并非所有版本都支持 | force |
| `-R <目录>` | 在指定的 chroot 目录中操作账户数据库 | root directory |
| `-P <前缀目录>` | 使用指定目录前缀下的账户文件；行为不同于 chroot | prefix |

- 参数填写：填写现有组名。正常情况下，如果该组仍是某个用户的主组，命令会拒绝删除；应先用 `usermod -g` 为这些用户更换主组。删除组不会自动修改文件原有的数字 GID。

- 示例

```console
$ sudo groupdel obsolete
$ getent group obsolete
$ echo $?
2
```

示例中的空输出和非零退出码表示该组已无法查到。不同 `getent` 实现的具体退出码可能不同。

### 8.16 `useradd`：创建用户账户

- 名称来源：`useradd` 由英语 “user add” 合成，即“添加用户”。它通常来自 shadow-utils，是偏底层、适合脚本的账户创建工具。

- 语法

```bash
useradd [选项] <用户名>
```

- 常用选项

| 选项 | 功能 | 字母来源 |
|---|---|---|
| `-m` | 创建用户主目录 | make home directory |
| `-M` | 明确不创建主目录 | no home directory |
| `-d <目录>` | 指定主目录路径 | directory |
| `-s <Shell>` | 指定登录 Shell | shell |
| `-g <主组>` | 指定主组，可填组名或 GID | group |
| `-G <组列表>` | 指定附加组，多个组用逗号分隔 | supplementary Groups |
| `-u <UID>` | 指定数字用户 ID | UID = User Identifier |
| `-c '<说明>'` | 设置账户说明/GECOS 字段，常填写真实姓名或用途 | comment |
| `-e <日期>` | 设置账户到期日，常用 `YYYY-MM-DD` | expire date |
| `-r` | 创建系统账户；通常从系统 UID 范围分配编号 |  |
| `-N` | 不创建同名用户组 | no user group |
| `-U` | 创建同名用户组 | user group |
| `-k <骨架目录>` | 与 `-m` 配合，从指定 skeleton 目录复制初始文件 |  |

- 参数填写：用户名必须符合本机策略；主组需事先存在，附加组列表不能包含空格。创建账户后通常还要用 `passwd <用户名>` 设置密码。发行版的 `/etc/login.defs` 与 `/etc/default/useradd` 会影响默认 UID、Shell、主目录和同名组行为。

- 示例

```console
$ sudo useradd -m -s /bin/bash -g developers -G sudo -c 'Alice Example' alice
$ sudo passwd alice
New password:
Retype new password:
passwd: password updated successfully
$ id alice
uid=1501(alice) gid=1500(developers) groups=1500(developers),27(sudo)
```

不要把明文密码写进命令行。`useradd -p` 需要的是已经加密的密码散列，而且命令行参数可能被其他用户、审计系统或历史记录看到，因此这里不推荐使用。

### 8.17 `usermod`：修改用户账户

- 名称来源：`usermod` 由英语 “user modify” 缩合而来，即“修改用户”。

- 语法

```bash
usermod [选项] <用户名>
```

- 常用选项

| 选项 | 功能 | 字母来源 |
|---|---|---|
| `-a` | 与 `-G` 配合，把新组追加到现有附加组，而不是替换 | append |
| `-G <组列表>` | 设置附加组列表；不加 `-a` 会替换原列表 | supplementary Groups |
| `-g <主组>` | 修改主组 | group |
| `-l <新用户名>` | 修改登录名 | login name |
| `-d <目录>` | 修改主目录路径 | directory |
| `-m` | 与 `-d` 配合，把原主目录内容移动到新位置 | move home |
| `-s <Shell>` | 修改登录 Shell | shell |
| `-u <UID>` | 修改数字用户 ID | UID = User Identifier |
| `-c '<说明>'` | 修改账户说明/GECOS 字段 | comment |
| `-e <日期>` | 修改账户到期日 | expire date |
| `-L` | 锁定密码 | lock |
| `-U` | 解锁密码 | unlock |

- 参数填写：最后填写现有用户名。最容易误用的是 `-G`：单独使用会把用户现有的附加组替换成新列表；只想增加一个组时应使用 `-aG`。修改 UID、用户名或主目录前，应先停止该用户的进程并检查文件所有权。

- 示例：把 `alice` 追加到 `docker` 组，同时保留原有附加组。

```console
$ sudo usermod -aG docker alice
$ id alice
uid=1501(alice) gid=1500(developers) groups=1500(developers),27(sudo),999(docker)
```

现有登录会话通常不会立即获得新的组列表；用户需要重新登录，或在合适场景下启动新的组环境。

### 8.18 `userdel`：删除用户账户

- 名称来源：`userdel` 由英语 “user delete” 缩合而来，即“删除用户”。

- 语法

```bash
userdel [选项] <用户名>
```

- 常用选项

| 选项 | 功能 | 字母来源 |
|---|---|---|
| `-r` | 同时删除主目录和邮件池 | remove home and mail spool |
| `-f` | 强制删除，即使用户仍已登录；可能留下运行进程或其他数据，风险高 | force |
| `-R <目录>` | 在指定的 chroot 目录中操作账户数据库 | root directory |
| `-P <前缀目录>` | 使用指定目录前缀下的账户文件 | prefix |
| `-Z` | 删除相应的 SELinux 用户映射；仅在支持的系统上有效 |  |

- 参数填写：填写现有用户名。删除前检查该用户的运行进程、计划任务、邮件、主目录之外的文件、服务配置、SSH 密钥和业务数据。`-r` 通常只处理主目录与邮件池，不会删除用户在其他目录中的文件。

- 示例：先检查，再删除测试账户及其主目录。

```console
$ pgrep -a -u testuser
6201 sleep 300
$ sudo pkill -TERM -u testuser
$ sudo userdel -r testuser
$ id testuser
id: 'testuser': no such user
```

若账户拥有需要保留的数据，应先转移所有权或归档。删除后遗留文件只保存数字 UID；将来该 UID 被新账户复用时，旧文件可能意外归属于新用户。

### 8.19 `adduser` / `deluser`：交互式管理用户与组

- 名称来源：`adduser` 和 `deluser` 分别来自英语 “add user” 与 “delete user”。在 Debian/Ubuntu 中，它们通常是对底层账户工具的高层封装；其他发行版可能不存在，或含义不同。

- 语法（Debian/Ubuntu 常见实现）

```bash
adduser [选项] <用户名>
adduser <用户名> <组名>
addgroup [选项] <组名>
deluser [选项] <用户名>
deluser <用户名> <组名>
delgroup [选项] <组名>
```

- 常用选项与写法

| 选项或写法 | 功能 | 字母来源 |
|---|---|---|
| `adduser <用户>` | 交互式创建普通用户，并通常创建主目录、同名组和密码 |  |
| `adduser <用户> <组>` | 把现有用户加入现有组 |  |
| `addgroup <组>` | 创建用户组 |  |
| `--system` | 创建系统用户或系统组 |  |
| `--home <目录>` | 指定主目录 |  |
| `--shell <Shell>` | 指定登录 Shell |  |
| `deluser <用户> <组>` | 从组中移除用户，但不删除用户账户 |  |
| `--remove-home` | 删除账户时同时删除主目录和邮件池 |  |
| `--remove-all-files` | 删除该用户拥有的全部文件；范围很大，必须谨慎 |  |
| `--backup` | 删除前备份用户文件 |  |

- 参数填写：这组命令的具体选项与行为高度依赖发行版；使用前先运行 `adduser --help`、`deluser --help`。不要假设它们在 Fedora、RHEL、Arch 等系统上与 Debian 实现完全相同。

- 示例（Debian/Ubuntu）：

```console
$ sudo adduser bob
Adding user `bob' ...
Adding new group `bob' (1502) ...
Adding new user `bob' (1502) with group `bob' ...
Creating home directory `/home/bob' ...
New password:
Retype new password:
passwd: password updated successfully
$ sudo adduser bob developers
Adding user `bob' to group `developers' ...
Done.
```

### 8.20 `gpasswd`：管理组成员和组管理员

- 名称来源：`gpasswd` 来自英语 “group password”。它历史上用于管理组密码，现在也常用于维护组成员与组管理员。

- 语法

```bash
gpasswd [选项] <组名>
```

- 常用选项

| 选项 | 功能 | 字母来源 |
|---|---|---|
| `-a <用户>` | 把一个用户加入组 | add |
| `-d <用户>` | 把一个用户从组中移除 | delete |
| `-M <用户列表>` | 一次设置完整成员列表，逗号分隔；会替换原列表 | members |
| `-A <管理员列表>` | 设置组管理员列表，逗号分隔 | administrators |
| `-r` | 删除组密码 | remove password |
| `-R` | 限制使用组密码加入该组 | restrict access |

- 参数填写：目标用户和组必须已存在。`-M` 会替换整个成员列表，自动化中使用前应先核对现有成员。普通用户组密码机制很少推荐，通常使用明确的管理员权限和成员列表更安全。

- 示例

```console
$ sudo gpasswd -a alice developers
Adding user alice to group developers
$ getent group developers
developers:x:1500:alice
$ sudo gpasswd -d alice developers
Removing user alice from group developers
```

### 8.21 账户管理文件与操作顺序

| 路径 | 名称来源 | 保存内容 |
|---|---|---|
| `/etc/passwd` | password file；现代系统通常不在这里保存密码散列 | 用户名、UID、GID、说明、主目录、登录 Shell |
| `/etc/shadow` | shadow password file | 受保护的密码散列及密码期限信息 |
| `/etc/group` | group file | 组名、GID 和成员列表 |
| `/etc/gshadow` | group shadow file | 受保护的组管理员、成员和组密码信息 |
| `/etc/login.defs` | login definitions | shadow-utils 的部分默认值和账户策略 |

推荐操作顺序：

1. 创建需要的组：`groupadd`。
2. 创建用户并设置主组、附加组和 Shell：`useradd`。
3. 设置密码：`passwd`；服务账户通常应使用 `nologin` Shell，并按实际需要决定是否设置密码。
4. 用 `id`、`groups`、`getent passwd`、`getent group` 核对结果。
5. 删除前先检查进程、服务、文件、计划任务和密钥；归档需要保留的数据。
6. 先删用户或调整其主组，再删除不再使用的组。

账户数据库可能来自 LDAP、SSSD、NIS 或其他目录服务，而不只是本地文件。在集中身份环境中，应使用对应的目录管理流程，不要仅修改本机账户文件。

---

## 9. 系统与时间信息

### 9.1 `uname`：显示内核和系统信息

- 名称来源：`uname` 来自英语 “Unix name”，用于报告内核和系统名称等信息。

- 语法

```bash
uname [选项]
```

- 常用选项

| 选项 | 功能 | 字母来源 |
|---|---|---|
| `-a` | 显示全部可用信息 | all |
| `-s` | 内核名称 | system / kernel name |
| `-r` | 内核发行版本 | release |
| `-v` | 内核构建版本 | version |
| `-m` | 硬件架构 | machine |
| `-n` | 网络节点名 | node name |
| `-o` | 操作系统名称 | operating system |

- 参数填写：不接受普通参数。

- 示例

```console
$ uname -srmo
Linux 6.8.0-45-generic x86_64 GNU/Linux
```

### 9.2 `hostname`：查看或临时设置主机名

- 名称来源：`hostname` 由英语 “host name” 合成，即网络中主机的名称。

- 语法

```bash
hostname [选项] [新主机名]
```

- 常用选项

| 选项 | 功能 | 字母来源 |
|---|---|---|
| `-s` | 显示短主机名 | short |
| `-f` | 显示完整域名（依赖名称解析配置） | fully qualified domain name |
| `-I` | 显示主机的 IP 地址 | all IP addresses |
| `-i` | 显示主机名对应的地址 | IP address |

- 参数填写：省略参数时查看；填写新名称通常需管理员权限且可能只临时生效。使用 systemd 的系统可用 `hostnamectl` 持久设置。

- 示例

```console
$ hostname -I
192.168.1.25 172.17.0.1
```

### 9.3 `date`：显示或格式化日期时间

- 名称来源：`date` 直接取自英语“日期”，命令也同时处理时间。

- 语法

```bash
date [选项] [+格式]
```

- 常用选项

| 选项 | 功能 | 字母来源 |
|---|---|---|
| `-u` | 使用 UTC | UTC |
| `-d <字符串>` | 显示指定日期，而非当前时间 | date string |
| `-r <文件>` | 显示文件最后修改时间 | reference file |
| `-I[精度]` | 输出 ISO 8601 格式，如 `seconds` | ISO 8601 |
| `-s <时间>` | 设置系统时间，通常需管理员权限 |  |

常用格式符：`%F` 为 `YYYY-MM-DD`、`%T` 为 `HH:MM:SS`、`%s` 为 Unix 时间戳、`%z` 为时区偏移。

- 参数填写：格式必须以 `+` 开头；相对日期如 `date -d 'tomorrow'` 是 GNU 扩展。

- 示例

```console
$ date '+%F %T %z'
2026-09-20 10:30:45 +0800
$ date -u -d '@0' '+%F %T %Z'
1970-01-01 00:00:00 UTC
```

### 9.4 `cal`：显示日历

- 名称来源：`cal` 是英语 “calendar”的缩写，意为“日历”。

- 语法

```bash
cal [选项] [[月] 年]
```

- 常用选项

| 选项 | 功能 | 字母来源 |
|---|---|---|
| `-3` | 显示上月、本月、下月 |  |
| `-y` | 显示全年 | year |
| `-m` | 以星期一为一周首日 | Monday first |
| `-s` | 以星期日为一周首日 | Sunday first |
| `-j` | 显示一年中的第几天 | Julian day |

- 参数填写：只写一个数字时通常表示年份；指定月份时写 `cal 9 2026`。

- 示例

```console
$ cal 9 2026
   September 2026
Su Mo Tu We Th Fr Sa
       1  2  3  4  5
 6  7  8  9 10 11 12
13 14 15 16 17 18 19
20 21 22 23 24 25 26
27 28 29 30
```

### 9.5 `uptime`：显示运行时间和负载

- 名称来源：`uptime` 由英语 “up time” 构成，表示系统持续运行的时间。

- 语法

```bash
uptime [选项]
```

- 常用选项

| 选项 | 功能 | 字母来源 |
|---|---|---|
| `-p` | 以易读形式只显示运行时长 | pretty |
| `-s` | 显示系统启动时间 | since |
| `--since` | 某些实现中等价于 `-s` |  |

- 参数填写：不接受普通参数。三个负载值分别对应最近 1、5、15 分钟。

- 示例

```console
$ uptime
 10:35:02 up 3 days, 2:26, 1 user, load average: 0.12, 0.09, 0.08
$ uptime -p
up 3 days, 2 hours, 26 minutes
```

### 9.6 `lscpu`：显示 CPU 信息

- 名称来源：`lscpu` 由 `ls`（list）和 `CPU` 组合，即“列出 CPU 信息”。

- 语法

```bash
lscpu [选项]
```

- 常用选项

| 选项 | 功能 | 字母来源 |
|---|---|---|
| `-e` | 扩展表格显示每个逻辑 CPU | extended |
| `-p` | 输出便于程序解析的格式 | parseable |
| `-J` | 输出 JSON；较新版本支持 | JSON |
| `-a` | 扩展/解析格式中包含在线和离线 CPU | all |

- 参数填写：通常无参数。

- 示例（节选）

```console
$ lscpu
Architecture:             x86_64
CPU(s):                   8
Model name:               Intel(R) Core(TM) i7 CPU
Thread(s) per core:       2
```

### 9.7 `free`：显示内存使用情况

- 名称来源：`free` 取自英语“空闲”，名称强调查看可用内存，同时也显示整体内存统计。

- 语法

```bash
free [选项]
```

- 常用选项

| 选项 | 功能 | 字母来源 |
|---|---|---|
| `-h` | 自动选择易读单位 | human-readable |
| `-m` | 以 MiB 显示 | mebibytes |
| `-g` | 以 GiB 显示 | gibibytes |
| `-s <秒>` | 按间隔持续刷新 | seconds |
| `-c <次数>` | 与 `-s` 配合，限制刷新次数 | count |
| `-t` | 显示内存与交换区合计 | total |

- 参数填写：通常无参数；间隔可填写小数。

- 示例

```console
$ free -h
               total        used        free      shared  buff/cache   available
Mem:            15Gi       4.2Gi       6.1Gi       420Mi       5.3Gi        10Gi
Swap:          2.0Gi          0B       2.0Gi
```

### 9.8 `env`：查看环境或在修改后的环境中运行命令

- 名称来源：`env` 是英语 “environment”的缩写，指进程环境变量。

- 语法

```bash
env [选项] [名称=值 ...] [命令 [参数...]]
```

- 常用选项

| 选项 | 功能 | 字母来源 |
|---|---|---|
| `-i` | 从空环境开始 | ignore inherited environment |
| `-u <名称>` | 删除指定环境变量 | unset |
| `-C <目录>` | 在指定目录中运行命令；较新 GNU 版本支持 | change directory |
| `-0` | 用 NUL 分隔输出变量 |  |

- 参数填写：无命令时显示环境；赋值只对本次启动的命令有效。

- 示例

```console
$ env LANG=C printenv LANG
C
$ env -i PATH=/usr/bin sh -c 'echo "$PATH"'
/usr/bin
```

### 9.9 `printenv`：输出环境变量

- 名称来源：`printenv` 来自英语 “print environment”，即“打印环境变量”。

- 语法

```bash
printenv [选项] [变量名...]
```

- 常用选项

| 选项 | 功能 | 字母来源 |
|---|---|---|
| `-0` | 使用 NUL 字符分隔结果 |  |
| `--help` | 显示帮助 |  |

- 参数填写：省略变量名时显示全部；填写多个名称时逐个输出其值。

- 示例

```console
$ printenv HOME SHELL
/home/alice
/bin/bash
```

---

## 10. 进程与作业控制

### 10.1 `ps`：显示进程快照

- 名称来源：`ps` 来自英语 “process status”，即“进程状态”。

- 语法

```bash
ps [选项]
```

`ps` 同时支持 UNIX 风格（带 `-`）、BSD 风格（不带 `-`）和 GNU 长选项，混用时需注意。

- 常用选项

| 选项 | 功能 | 字母来源 |
|---|---|---|
| `-e`、`-A` | 显示所有进程 | every process；all |
| `-f` | 完整格式 | full format |
| `-u <用户>` | 显示指定用户的进程 | user |
| `-p <PID列表>` | 只显示指定 PID，逗号分隔 | process ID |
| `-o <字段>` | 自定义列，如 `pid,user,%cpu,cmd` | output format |
| `--sort=<字段>` | 排序；前缀 `-` 表示降序，如 `--sort=-%cpu` |  |
| `aux` | BSD 常见组合：显示所有用户和详细资源信息 | a = all terminals；u = user format；x = include no-TTY processes |
| `--forest` | 以树状关系显示进程 |  |

- 参数填写：PID 可用逗号分隔；字段名参考 `ps --help output`。

- 示例

```console
$ ps -eo pid,user,%cpu,%mem,comm --sort=-%cpu | head -n 4
    PID USER     %CPU %MEM COMMAND
   2841 alice    12.5  1.8 python3
   1022 root      1.2  0.4 dockerd
      1 root      0.0  0.1 systemd
```

### 10.2 `pgrep`：按名称或属性查找进程

- 名称来源：`pgrep` 由 “process” 的 `p` 与 `grep` 组合，表示按模式查找进程。

- 语法

```bash
pgrep [选项] <模式>
```

- 常用选项

| 选项 | 功能 | 字母来源 |
|---|---|---|
| `-a` | 同时显示 PID 和完整命令行 | full argument list |
| `-f` | 匹配完整命令行，而非仅进程名 | full command line |
| `-u <用户>` | 限定有效用户 | effective user |
| `-x` | 要求名称完全匹配 | exact |
| `-n` | 只显示最新进程 | newest |
| `-o` | 只显示最早进程 | oldest |
| `-c` | 只显示匹配数量 | count |
| `-P <PPID>` | 限定父进程号 | parent process ID |

- 参数填写：模式是扩展正则表达式；需要匹配命令参数时加 `-f`。

- 示例

```console
$ pgrep -a -u alice python
2841 python3 worker.py
2910 python3 -m http.server 8000
```

### 10.3 `kill`：向进程发送信号

- 名称来源：`kill` 直接取自英语“终止”；在 Unix 中本质是发送信号，并不一定真的结束进程。

- 语法

```bash
kill [选项] <PID...>
```

- 常用选项/信号

| 写法 | 功能 | 字母来源 |
|---|---|---|
| `-l` | 列出信号名称 | list signals |
| `-s <信号>` | 指定信号名称或编号 | signal |
| `-TERM` 或 `-15` | 请求进程正常终止，默认信号 |  |
| `-HUP` 或 `-1` | 常用于让服务重新加载配置 |  |
| `-INT` 或 `-2` | 类似终端 `Ctrl+C` |  |
| `-KILL` 或 `-9` | 强制终止，进程无法清理资源，应作为最后手段 |  |

- 参数填写：PID 来自 `ps` 或 `pgrep`；可一次填写多个。

- 示例

```console
$ kill -TERM 2841
$ ps -p 2841
    PID TTY          TIME CMD
```

### 10.4 `pkill`：按名称或属性向进程发送信号

- 名称来源：`pkill` 由 “process” 的 `p` 与 `kill` 组合，表示按名称向进程发送信号。

- 语法

```bash
pkill [选项] <模式>
```

- 常用选项

| 选项 | 功能 | 字母来源 |
|---|---|---|
| `-<信号>` | 指定信号，如 `-HUP`、`-TERM` |  |
| `-f` | 匹配完整命令行 | full command line |
| `-u <用户>` | 限定用户 | effective user |
| `-x` | 完整匹配进程名 | exact |
| `-n` | 只作用于最新匹配进程 | newest |
| `-o` | 只作用于最早匹配进程 | oldest |

- 参数填写：模式为扩展正则；执行前可先用相同条件的 `pgrep -a` 核对。

- 示例

```console
$ pgrep -a -x sleep
3201 sleep 300
$ pkill -TERM -x sleep
$ pgrep -a -x sleep
```

### 10.5 `top`：实时查看进程和资源

- 名称来源：`top` 取自英语“顶部”，默认把资源使用较高的进程排在列表前部。

- 语法

```bash
top [选项]
```

- 常用选项

| 选项 | 功能 | 字母来源 |
|---|---|---|
| `-u <用户>` | 只显示指定用户进程 | user |
| `-p <PID列表>` | 只监视指定 PID | process ID |
| `-d <秒>` | 设置刷新间隔 | delay |
| `-n <次数>` | 刷新指定次数后退出 | number of iterations |
| `-b` | 批处理模式，适合保存或管道处理 | batch |
| `-H` | 显示线程 |  |

- 参数填写：PID 用逗号分隔。交互时常用 `P` 按 CPU 排序、`M` 按内存排序、`q` 退出。

- 示例（批处理节选）

```console
$ top -b -n 1 | head -n 5
top - 10:42:10 up 3 days,  2:33,  1 user,  load average: 0.10, 0.09, 0.08
Tasks: 214 total,   1 running, 213 sleeping,   0 stopped,   0 zombie
%Cpu(s):  2.0 us,  0.7 sy, 97.3 id
MiB Mem :  15900.0 total,  6200.0 free,  4300.0 used,  5400.0 buff/cache
```

### 10.6 `nice`：以指定优先级启动命令

- 名称来源：`nice` 取自英语“友善”；进程让出更多 CPU 机会时，被形象地称为对其他进程更“友善”。

- 语法

```bash
nice [选项] <命令> [参数...]
```

- 常用选项

| 选项 | 功能 | 字母来源 |
|---|---|---|
| `-n <增量>` | 在继承的 nice 值基础上增加指定整数 | niceness adjustment |
| `--adjustment=<值>` | 与 `-n` 相同 |  |

- 参数填写：nice 值通常从 `-20`（优先级最高）到 `19`（最低）；普通用户通常只能增大 nice 值。

- 示例

```console
$ nice -n 10 sh -c 'ps -o ni= -p $$'
 10
```

### 10.7 `renice`：调整已有进程优先级

- 名称来源：`renice` 由前缀 `re-` 和 `nice` 构成，表示重新设置进程的 nice 值。

- 语法

```bash
renice <优先级> [-p <PID...>] [-u <用户...>] [-g <组...>]
```

- 常用选项

| 选项 | 功能 | 字母来源 |
|---|---|---|
| `-p` | 后续参数为进程 ID；通常默认 | process |
| `-u` | 调整指定用户的进程 | user |
| `-g` | 调整指定进程组 | process group |
| `-n <值>` | 某些实现中显式指定新 nice 值 | nice value |

- 参数填写：优先级范围通常为 `-20` 至 `19`；提高优先级通常需要管理员权限。

- 示例

```console
$ renice 15 -p 2841
2841 (process ID) old priority 0, new priority 15
```

### 10.8 `jobs`：列出当前 Shell 的后台作业

- 名称来源：`jobs` 直接取自英语“作业”，指当前 Shell 管理的前台或后台任务。

- 语法

```bash
jobs [选项] [作业编号...]
```

- 常用选项

| 选项 | 功能 | 字母来源 |
|---|---|---|
| `-l` | 同时显示 PID | long listing |
| `-p` | 只显示进程组首领 PID | process ID |
| `-r` | 只显示运行中的作业 | running |
| `-s` | 只显示已停止作业 | stopped |

- 参数填写：作业编号写作 `%1`、`%2`；只对当前 Shell 启动的作业有效。

- 示例

```console
$ sleep 300 &
[1] 4120
$ jobs -l
[1]+  4120 Running                 sleep 300 &
```

### 10.9 `bg`：让暂停的作业在后台继续

- 名称来源：`bg` 是英语 “background”的缩写，表示后台。

- 语法

```bash
bg [作业编号...]
```

- 常用选项：Bash 内建命令通常无常用选项。

- 参数填写：使用 `jobs` 看到的 `%1` 等编号；省略时使用当前作业。

- 示例

```console
$ bg %1
[1]+ sleep 300 &
```

### 10.10 `fg`：把后台作业移到前台

- 名称来源：`fg` 是英语 “foreground”的缩写，表示前台。

- 语法

```bash
fg [作业编号]
```

- 常用选项：通常无选项。

- 参数填写：作业编号如 `%1`；省略时使用当前作业。

- 示例

```console
$ fg %1
sleep 300
^C
```

### 10.11 `nohup`：退出终端后继续运行命令

- 名称来源：`nohup` 来自英语 “no hangup”，表示忽略终端挂断信号。

- 语法

```bash
nohup <命令> [参数...] [&]
```

- 常用选项：通常只有 `--help`、`--version`。

- 参数填写：后跟完整命令；通常在末尾加 `&` 放入后台。终端输出默认写入 `nohup.out`，建议显式重定向。

- 示例

```console
$ nohup python3 worker.py >worker.log 2>&1 &
[1] 4250
$ jobs
[1]+  Running                 nohup python3 worker.py > worker.log 2>&1 &
```

### 10.12 `time`：测量命令运行时间

- 名称来源：`time` 直接取自英语“计时”，用于测量命令运行所耗时间。

- 语法

```bash
time <命令> [参数...]
```

- 常用选项

| 选项 | 功能 | 字母来源 |
|---|---|---|
| `-p` | POSIX 简洁格式；Shell 内建版本支持情况不同 | portable format |
| `-f <格式>` | GNU `/usr/bin/time` 自定义格式 | format |
| `-v` | GNU `/usr/bin/time` 显示详细资源使用 | verbose |
| `-o <文件>` | GNU 版本把统计写入文件 | output |

- 参数填写：后面写要测量的完整命令。Shell 关键字 `time` 与 `/usr/bin/time` 功能不完全相同。

- 示例

```console
$ time sleep 1

real    0m1.002s
user    0m0.001s
sys     0m0.000s
```

### 10.13 `watch`：周期性重复执行命令

- 名称来源：`watch` 直接取自英语“监视”，表示反复执行并观察命令输出。

- 语法

```bash
watch [选项] <命令>
```

- 常用选项

| 选项 | 功能 | 字母来源 |
|---|---|---|
| `-n <秒>` | 设置刷新间隔，默认 2 秒 | interval number |
| `-d` | 高亮显示变化 | differences |
| `-t` | 不显示顶部标题 | no title |
| `-g` | 输出发生变化后退出 |  |
| `-e` | 命令出错时停止并显示错误 | error exit |

- 参数填写：命令含管道或重定向时整体加引号；按 `Ctrl+C` 停止。

- 示例（屏幕内容）

```console
$ watch -n 1 -d 'date +%T; free -h | head -n 2'
Every 1.0s: date +%T; free -h | head -n 2
10:45:21
               total        used        free      shared  buff/cache   available
Mem:            15Gi       4.2Gi       6.1Gi       420Mi       5.3Gi        10Gi
```

---

## 11. 磁盘与文件系统

### 11.1 `df`：显示文件系统空间使用情况

- 名称来源：`df` 来自英语 “disk free”，表示文件系统剩余空间。

- 语法

```bash
df [选项] [文件或文件系统...]
```

- 常用选项

| 选项 | 功能 | 字母来源 |
|---|---|---|
| `-h` | 以易读单位显示 | human-readable |
| `-H` | 使用 1000 进制单位 | human-readable, SI units |
| `-T` | 显示文件系统类型 | file-system type |
| `-i` | 显示 inode 使用情况而非字节空间 | inodes |
| `-a` | 包含伪文件系统等全部条目 | all |
| `-x <类型>` | 排除指定文件系统类型 | exclude type |
| `-t <类型>` | 只显示指定文件系统类型 | type |

- 参数填写：可填写挂载点、设备或任意文件路径；省略时显示全部已挂载文件系统。

- 示例

```console
$ df -hT /
Filesystem     Type  Size  Used Avail Use% Mounted on
/dev/nvme0n1p2 ext4  228G   91G  126G  42% /
```

### 11.2 `du`：统计文件或目录占用空间

- 名称来源：`du` 来自英语 “disk usage”，表示磁盘使用量。

- 语法

```bash
du [选项] [文件或目录...]
```

- 常用选项

| 选项 | 功能 | 字母来源 |
|---|---|---|
| `-h` | 使用易读单位 | human-readable |
| `-s` | 只显示每个参数的总计 | summarize |
| `-a` | 同时显示普通文件 | all files |
| `-c` | 最后显示总计 | grand total |
| `-d <层数>`、`--max-depth=<层数>` | 限制显示深度 | depth |
| `-x` | 不跨越文件系统边界 | one file system |
| `--exclude=<模式>` | 排除匹配路径 |  |
| `--apparent-size` | 显示表观大小，而非实际磁盘占用 |  |

- 参数填写：省略时统计当前目录；通常用 `du -sh <目录>` 看总大小。

- 示例

```console
$ du -h --max-depth=1 project
12M     project/.git
3.4M    project/src
520K    project/docs
16M     project
```

### 11.3 `lsblk`：列出块设备

- 名称来源：`lsblk` 由 `ls`（list）和 `blk`（block devices）组合，即“列出块设备”。

- 语法

```bash
lsblk [选项] [设备...]
```

- 常用选项

| 选项 | 功能 | 字母来源 |
|---|---|---|
| `-f` | 显示文件系统、UUID 和挂载点 | file systems |
| `-o <列列表>` | 自定义输出列 | output columns |
| `-p` | 显示完整设备路径 | full paths |
| `-d` | 不显示分区等从属设备 | no dependencies |
| `-J` | 输出 JSON | JSON |
| `-b` | 以字节显示大小 | bytes |
| `-e <主设备号列表>` | 排除指定设备类别，如 `-e 7` 排除 loop | exclude |

- 参数填写：可填写 `/dev/sda` 等设备；省略时列出全部块设备。

- 示例

```console
$ lsblk -f
NAME        FSTYPE FSVER LABEL UUID                                 FSAVAIL MOUNTPOINTS
nvme0n1
├─nvme0n1p1 vfat   FAT32       12AB-34CD                              480M /boot/efi
└─nvme0n1p2 ext4   1.0         1111-2222-3333-4444                    126G /
```

### 11.4 `blkid`：显示块设备属性

- 名称来源：`blkid` 由 `blk`（block）和 `id`（identifier）组合，用于识别块设备属性。

- 语法

```bash
blkid [选项] [设备...]
```

- 常用选项

| 选项 | 功能 | 字母来源 |
|---|---|---|
| `-s <标签>` | 只显示指定属性，如 `UUID`、`TYPE` | select tag |
| `-o <格式>` | 输出格式，如 `value`、`list`、`export` | output format |
| `-L <卷标>` | 按卷标查找设备 | label |
| `-U <UUID>` | 按 UUID 查找设备 | UUID |
| `-p` | 低级探测模式 | low-level probe |

- 参数填写：普通用户看到的设备可能有限；填 `/dev/sda1` 等设备路径。

- 示例

```console
$ sudo blkid -s TYPE -s UUID /dev/nvme0n1p2
/dev/nvme0n1p2: UUID="1111-2222-3333-4444" TYPE="ext4"
```

### 11.5 `mount`：查看或挂载文件系统

- 名称来源：`mount` 取自英语“装载/安装”，表示把文件系统接入目录树。

- 语法

```bash
mount [选项]
mount [选项] <设备> <挂载点>
```

- 常用选项

| 选项 | 功能 | 字母来源 |
|---|---|---|
| `-t <类型>` | 指定文件系统类型，如 `ext4`、`nfs` | file-system type |
| `-o <选项列表>` | 指定挂载选项，逗号分隔 | options |
| `-a` | 挂载 `/etc/fstab` 中符合条件的所有项 | all |
| `-r` | 只读挂载 | read-only |
| `-w` | 读写挂载，通常为默认 | read-write |
| `--bind` | 把已有目录挂载到另一目录 |  |

常见 `-o` 值：`ro` 只读、`rw` 读写、`noexec` 禁止直接执行、`nosuid` 忽略 SUID、`loop` 把镜像文件作为设备。

- 参数填写：设备可为 `/dev/sdb1`、`UUID=...` 或网络地址；挂载点必须是已有目录。通常需要管理员权限。

- 示例

```console
$ sudo mount -o ro /dev/sdb1 /mnt/usb
$ findmnt /mnt/usb
TARGET   SOURCE    FSTYPE OPTIONS
/mnt/usb /dev/sdb1 ext4   ro,relatime
```

### 11.6 `umount`：卸载文件系统

- 名称来源：`umount` 表示 “unmount”；名称省去字母 `n`，沿用了早期 Unix 的短命令命名。

- 语法

```bash
umount [选项] <设备或挂载点...>
```

- 常用选项

| 选项 | 功能 | 字母来源 |
|---|---|---|
| `-a` | 卸载符合条件的所有文件系统 | all |
| `-t <类型列表>` | 只处理指定类型 | types |
| `-l` | 延迟卸载，待不再使用时清理 | lazy |
| `-f` | 强制卸载，主要用于不可达网络文件系统，可能有风险 | force |
| `-R` | 递归卸载挂载点下的文件系统 | recursive |
| `-v` | 显示过程 | verbose |

- 参数填写：填写设备或挂载点；先离开该目录并关闭正在使用其中内容的程序。

- 示例

```console
$ sudo umount -v /mnt/usb
umount: /mnt/usb unmounted
```

### 11.7 `findmnt`：查询挂载关系

- 名称来源：`findmnt` 由 `find` 和 `mnt`（mount）组合，表示查找挂载关系。

- 语法

```bash
findmnt [选项] [设备或挂载点]
```

- 常用选项

| 选项 | 功能 | 字母来源 |
|---|---|---|
| `-t <类型>` | 按文件系统类型筛选 | file-system type |
| `-S <源>` | 按源设备筛选 | source |
| `-T <路径>` | 查找包含指定路径的文件系统 | target path |
| `-o <列列表>` | 自定义输出列 | output columns |
| `-J` | 输出 JSON | JSON |
| `-r` | 使用原始格式 | raw |

- 参数填写：可直接写挂载点；`-T` 后可写任意文件路径。

- 示例

```console
$ findmnt -T /home/alice/report.txt
TARGET SOURCE         FSTYPE OPTIONS
/home  /dev/nvme0n1p3 ext4   rw,relatime
```

### 11.8 `sync`：把缓存写入持久存储

- 名称来源：`sync` 是英语 “synchronize”的缩写，表示同步缓存与持久存储。

- 语法

```bash
sync [选项] [文件...]
```

- 常用选项

| 选项 | 功能 | 字母来源 |
|---|---|---|
| `-d` | 只同步文件数据，不一定同步非必要元数据 | data only |
| `-f` | 同步包含指定文件的整个文件系统 | file system |
| `--help` | 显示帮助 |  |

- 参数填写：省略文件时同步所有待写数据；部分非 GNU 系统不接受文件参数。

- 示例

```console
$ sync
$ echo $?
0
```

---

## 12. 归档与压缩

### 12.1 `tar`：创建、查看和解开归档

- 名称来源：`tar` 来自英语 “tape archive”，即“磁带归档”；如今也广泛用于普通文件归档。

- 语法

```bash
tar [操作] [选项] -f <归档文件> [文件或目录...]
```

- 常用操作与选项

| 选项 | 功能 | 字母来源 |
|---|---|---|
| `-c` | 创建归档 | create |
| `-x` | 解开归档 | extract |
| `-t` | 查看归档内容 | table of contents |
| `-f <文件>` | 指定归档文件；后面紧跟文件名 | file |
| `-v` | 显示详细过程 | verbose |
| `-C <目录>` | 操作前切换到指定目录 | change directory |
| `-z` | 使用 gzip，常见扩展名 `.tar.gz`、`.tgz` |  |
| `-j` | 使用 bzip2，常见扩展名 `.tar.bz2` |  |
| `-J` | 使用 xz，常见扩展名 `.tar.xz` |  |
| `--exclude='<模式>'` | 排除匹配项目 |  |
| `--strip-components=<数>` | 解包时去掉路径开头若干层 |  |

- 参数填写：创建时最后填写要收录的路径；解包时可省略成员名以解开全部。解包不可信归档前先用 `tar -tf` 检查路径。

- 示例

```console
$ tar -czvf project.tar.gz project
project/
project/src/
project/src/main.py
$ tar -tzf project.tar.gz
project/
project/src/
project/src/main.py
```

### 12.2 `gzip` / `gunzip`：使用 gzip 压缩或解压单个文件

- 名称来源：`gzip` 来自 “GNU zip”；`gunzip` 中的 `un-` 表示执行相反的解压操作。

- 语法

```bash
gzip [选项] <文件...>
gunzip [选项] <文件.gz...>
```

- 常用选项

| 选项 | 功能 | 字母来源 |
|---|---|---|
| `-d` | 解压；`gunzip` 等价于 `gzip -d` | decompress |
| `-k` | 保留输入文件 | keep |
| `-c` | 输出到标准输出，不替换原文件 | write to standard output |
| `-1` | 最快压缩、压缩率较低 |  |
| `-9` | 最慢压缩、压缩率较高 |  |
| `-r` | 递归处理目录中的文件 | recursive |
| `-l` | 显示压缩文件信息 | list |
| `-t` | 测试压缩文件完整性 | test |

- 参数填写：直接填写文件；gzip 本身不把多个文件打包，打包应与 `tar` 配合。

- 示例

```console
$ gzip -kv report.txt
report.txt:	 42.3% -- replaced with report.txt.gz
$ gzip -l report.txt.gz
         compressed        uncompressed  ratio uncompressed_name
                812                1280  38.9% report.txt
```

### 12.3 `bzip2` / `bunzip2`：使用 bzip2 压缩或解压

- 名称来源：`bzip2` 是 `bzip` 格式的第二代名称；其压缩方法属于基于块排序/Burrows–Wheeler 变换的一类。

- 语法

```bash
bzip2 [选项] <文件...>
bunzip2 [选项] <文件.bz2...>
```

- 常用选项

| 选项 | 功能 | 字母来源 |
|---|---|---|
| `-d` | 解压 | decompress |
| `-k` | 保留输入文件 | keep |
| `-c` | 输出到标准输出 | write to standard output |
| `-1` 至 `-9` | 调整压缩块大小和压缩率 |  |
| `-t` | 测试完整性 | test |
| `-v` | 显示详情 | verbose |

- 参数填写：填写普通文件或 `.bz2` 文件；不负责多文件归档。

- 示例

```console
$ bzip2 -kv data.csv
  data.csv:  3.210:1,  2.492 bits/byte, 68.85% saved, 10240 in, 3190 out.
```

### 12.4 `xz` / `unxz`：使用 xz 压缩或解压

- 名称来源：`xz` 是 XZ 压缩格式的名称，并非通行英文短语的首字母缩写；`unxz` 的 `un-` 表示解压。

- 语法

```bash
xz [选项] <文件...>
unxz [选项] <文件.xz...>
```

- 常用选项

| 选项 | 功能 | 字母来源 |
|---|---|---|
| `-d` | 解压 | decompress |
| `-k` | 保留输入文件 | keep |
| `-c` | 输出到标准输出 | write to standard output |
| `-0` 至 `-9` | 压缩预设，数字越高通常越慢、越耗内存 |  |
| `-T <线程数>` | 设置线程数；`0` 表示自动 | threads |
| `-t` | 测试完整性 | test |
| `-l` | 列出压缩文件信息 | list |

- 参数填写：填写普通文件或 `.xz` 文件；`xz -T0` 适合多核压缩。

- 示例

```console
$ xz -T0 -k data.sql
$ xz -l data.sql.xz
Strms  Blocks   Compressed Uncompressed  Ratio  Check   Filename
    1       1     120.0 KiB    640.0 KiB  0.188  CRC64   data.sql.xz
```

### 12.5 `zip`：创建或更新 ZIP 压缩包

- 名称来源：`zip` 取自英语“快速移动/拉链合拢”的意象，后来成为常见压缩归档格式名称。

> 某些精简系统需要安装 `zip` 软件包。

- 语法

```bash
zip [选项] <压缩包.zip> <文件或目录...>
```

- 常用选项

| 选项 | 功能 | 字母来源 |
|---|---|---|
| `-r` | 递归加入目录 | recursive |
| `-9` | 使用较高压缩率 |  |
| `-0` | 只存储，不压缩 |  |
| `-u` | 只更新较新的文件或加入新文件 | update |
| `-d` | 从压缩包删除匹配成员 | delete |
| `-x <模式...>` | 排除匹配路径 | exclude |
| `-q` | 静默模式 | quiet |
| `-e` | 交互式设置传统 ZIP 密码；不适合高安全需求 | encrypt |

- 参数填写：先写压缩包名，再写来源路径；模式最好加引号。

- 示例

```console
$ zip -r project.zip project -x 'project/.git/*'
  adding: project/ (stored 0%)
  adding: project/src/ (stored 0%)
  adding: project/src/main.py (deflated 35%)
```

### 12.6 `unzip`：查看或解开 ZIP 压缩包

- 名称来源：`unzip` 由否定/反向前缀 `un-` 与 `zip` 构成，表示解开 ZIP 归档。

- 语法

```bash
unzip [选项] <压缩包.zip> [成员模式...]
```

- 常用选项

| 选项 | 功能 | 字母来源 |
|---|---|---|
| `-l` | 列出内容，不解压 | list |
| `-d <目录>` | 解压到指定目录 | directory |
| `-o` | 覆盖已有文件且不询问 | overwrite |
| `-n` | 永不覆盖已有文件 | never overwrite |
| `-q` | 减少输出 | quiet |
| `-t` | 测试压缩包完整性 | test |
| `-x <模式...>` | 排除匹配成员 | exclude |

- 参数填写：压缩包后可写成员名或模式，只解压部分内容；目标目录不存在时通常会创建。

- 示例

```console
$ unzip -l project.zip
Archive:  project.zip
  Length      Date    Time    Name
---------  ---------- -----   ----
      248  2026-09-20 10:00   project/src/main.py
---------                     -------
      248                     1 file
```

---

## 13. 网络诊断与传输

### 13.1 `ip`：查看和配置网络对象

- 名称来源：`ip` 来自英语 “Internet Protocol”，即“互联网协议”。

- 语法

```bash
ip [通用选项] <对象> <命令> [参数...]
```

常用对象：`address`（可缩写 `a`）、`link`（`l`）、`route`（`r`）、`neigh`（`n`）。

- 常用选项和子命令

| 写法 | 功能 | 字母来源 |
|---|---|---|
| `-br` | 简洁表格格式 | brief |
| `-4` / `-6` | 只处理 IPv4 / IPv6 |  |
| `-c` | 彩色输出 | color |
| `-j` | 输出 JSON | JSON |
| `ip addr show [dev 接口]` | 查看地址 |  |
| `ip link show [接口]` | 查看链路状态 |  |
| `ip route show` | 查看路由表 |  |
| `ip neigh show` | 查看邻居/ARP 表 |  |
| `ip link set <接口> up/down` | 启用/禁用接口，通常需管理员权限 |  |

- 参数填写：接口名如 `eth0`、`ens33`、`wlan0`；IP 前缀如 `192.168.1.25/24`。

- 示例

```console
$ ip -br address
lo               UNKNOWN        127.0.0.1/8 ::1/128
eth0             UP             192.168.1.25/24 fe80::1234/64
$ ip route show default
default via 192.168.1.1 dev eth0 proto dhcp metric 100
```

### 13.2 `ping`：测试 IP 连通性和时延

- 名称来源：`ping` 取自声呐发出的“乒”声；“Packet Internet Groper”是后来形成的反向首字母解释。

- 语法

```bash
ping [选项] <主机或IP>
```

- 常用选项

| 选项 | 功能 | 字母来源 |
|---|---|---|
| `-c <次数>` | 发送指定次数后退出 | count |
| `-i <秒>` | 设置发送间隔 | interval |
| `-W <秒>` | 等待单次回复的超时时间；具体单位依实现而异 | wait per reply |
| `-w <秒>` | 设置整个命令的截止时间 | deadline |
| `-4` / `-6` | 强制 IPv4 / IPv6 |  |
| `-n` | 不把 IP 反向解析成主机名 | numeric |
| `-s <字节>` | 设置 ICMP 数据负载大小 | packet size |

- 参数填写：填写域名或 IP。无回复不一定代表主机宕机，也可能是 ICMP 被防火墙过滤。

- 示例

```console
$ ping -c 3 192.168.1.1
PING 192.168.1.1 (192.168.1.1) 56(84) bytes of data.
64 bytes from 192.168.1.1: icmp_seq=1 ttl=64 time=0.62 ms
64 bytes from 192.168.1.1: icmp_seq=2 ttl=64 time=0.55 ms
64 bytes from 192.168.1.1: icmp_seq=3 ttl=64 time=0.58 ms
--- 192.168.1.1 ping statistics ---
3 packets transmitted, 3 received, 0% packet loss
```

### 13.3 `ss`：查看套接字和监听端口

- 名称来源：`ss` 来自英语 “socket statistics”，即“套接字统计”。

- 语法

```bash
ss [选项] [过滤表达式]
```

- 常用选项

| 选项 | 功能 | 字母来源 |
|---|---|---|
| `-t` | TCP | TCP |
| `-u` | UDP | UDP |
| `-l` | 只显示监听套接字 | listening |
| `-a` | 显示监听和非监听套接字 | all |
| `-n` | 不解析服务名和主机名 | numeric |
| `-p` | 显示使用套接字的进程，部分信息需管理员权限 | process |
| `-4` / `-6` | 只显示 IPv4 / IPv6 |  |
| `-s` | 显示汇总统计 | summary |

- 参数填写：选项常组合为 `ss -lntp`；过滤示例为 `sport = :22`、`state established`。

- 示例

```console
$ sudo ss -lntp
State  Recv-Q Send-Q Local Address:Port Peer Address:Port Process
LISTEN 0      128          0.0.0.0:22        0.0.0.0:* users:(("sshd",pid=812,fd=3))
LISTEN 0      511        127.0.0.1:8080      0.0.0.0:* users:(("nginx",pid=945,fd=6))
```

### 13.4 `curl`：通过 URL 传输数据

- 名称来源：`curl` 通常解释为 “client URL”，表示用于 URL 的客户端工具；项目写法常为 cURL。

- 语法

```bash
curl [选项] <URL...>
```

- 常用选项

| 选项 | 功能 | 字母来源 |
|---|---|---|
| `-O` | 使用远程文件名保存 | remote output name |
| `-o <文件>` | 保存为指定文件名 | output |
| `-L` | 跟随 HTTP 重定向 | location redirect |
| `-I` | 只请求响应头 |  |
| `-i` | 输出中包含响应头 | include headers |
| `-sS` | 静默进度，但仍显示错误 | s = silent；S = show errors |
| `-f` | HTTP 4xx/5xx 时失败且不输出响应正文 | fail on HTTP errors |
| `-X <方法>` | 指定请求方法；很多场景可由其他选项自动推断 |  |
| `-H '<头: 值>'` | 添加请求头，可重复 | header |
| `-d '<数据>'` | 发送表单数据，默认使用 POST | data |
| `--data-urlencode '<键=值>'` | URL 编码后发送数据 |  |
| `-F '<字段=@文件>'` | 发送 multipart 表单/上传文件 | form |
| `-u '<用户:密码>'` | HTTP 认证；避免把密码留在命令历史中 | user |
| `--connect-timeout <秒>` | 设置连接超时 |  |
| `--max-time <秒>` | 限制总耗时 |  |

- 参数填写：URL 应包含协议，如 `https://example.com/file`。敏感令牌建议从受保护文件或环境安全提供，不直接写入共享命令历史。

- 示例（响应因站点而异）

```console
$ curl -sS -I https://example.com
HTTP/2 200
content-type: text/html
content-length: 1256
$ curl -sS -o response.json -w '%{http_code}\n' https://api.example.com/status
200
```

### 13.5 `wget`：下载文件或递归抓取资源

- 名称来源：`wget` 来自英语 “World Wide Web get”，即“从万维网取得内容”。

- 语法

```bash
wget [选项] <URL...>
```

- 常用选项

| 选项 | 功能 | 字母来源 |
|---|---|---|
| `-O <文件>` | 把响应保存为指定文件；多个 URL 会合并，不等同于目录 | output document |
| `-P <目录>` | 指定下载目录前缀 | directory prefix |
| `-c` | 继续未完成的下载 | continue |
| `-q` | 静默 | quiet |
| `--show-progress` | 即使部分静默场景也显示进度 |  |
| `--timeout=<秒>` | 设置网络超时 |  |
| `--tries=<次数>` | 设置重试次数 |  |
| `-r` | 递归下载；使用前注意范围和站点规则 | recursive |
| `--limit-rate=<速率>` | 限速，如 `2m` |  |
| `--content-disposition` | 使用响应头建议的文件名 |  |

- 参数填写：填写一个或多个 URL；递归抓取应尊重站点条款，避免给服务器造成负担。

- 示例

```console
$ wget -O example.html https://example.com/
--2026-09-20 11:00:00--  https://example.com/
Resolving example.com... 93.184.216.34
Connecting to example.com|93.184.216.34|:443... connected.
HTTP request sent, awaiting response... 200 OK
Saving to: 'example.html'
example.html        100%[=================>]   1.23K  --.-KB/s
```

### 13.6 `dig`：查询 DNS

- 名称来源：`dig` 来自英语 “domain information groper”，即“域信息探查器”。

> 常由 `dnsutils` 或 `bind-utils` 软件包提供。

- 语法

```bash
dig [@DNS服务器] <名称> [记录类型] [选项]
```

- 常用写法/选项

| 写法 | 功能 | 字母来源 |
|---|---|---|
| `A` / `AAAA` | 查询 IPv4 / IPv6 地址记录 |  |
| `MX` | 查询邮件交换记录 |  |
| `TXT` | 查询文本记录 |  |
| `NS` | 查询权威 DNS 服务器 |  |
| `-x <IP>` | 反向解析 IP | reverse lookup |
| `+short` | 只输出简短答案 |  |
| `+trace` | 从根服务器开始跟踪解析过程 |  |
| `+tcp` | 使用 TCP 查询 |  |

- 参数填写：可在最前面写 `@1.1.1.1` 指定 DNS 服务器；省略类型时通常查询 `A`。

- 示例

```console
$ dig +short example.com A
93.184.216.34
$ dig +short example.com MX
0 .
```

### 13.7 `host`：进行简单 DNS 查询

- 名称来源：`host` 直接取自英语“主机”，用于查询主机名和 DNS 信息。

- 语法

```bash
host [选项] <名称或IP> [DNS服务器]
```

- 常用选项

| 选项 | 功能 | 字母来源 |
|---|---|---|
| `-t <类型>` | 指定记录类型，如 `A`、`MX`、`TXT` | type |
| `-a` | 显示详细结果，近似查询 `ANY` | all |
| `-v` | 详细模式 | verbose |
| `-W <秒>` | 设置等待时间 | wait |
| `-R <次数>` | 设置 UDP 重试次数 | retries |

- 参数填写：名称可为域名，IP 会执行反向查询；最后可指定 DNS 服务器。

- 示例

```console
$ host example.com
example.com has address 93.184.216.34
example.com has IPv6 address 2606:2800:220:1:248:1893:25c8:1946
```

### 13.8 `traceroute`：显示数据包到目标的网络路径

- 名称来源：`traceroute` 由英语 “trace route” 合成，表示追踪数据包经过的路由。

> 某些系统需安装 `traceroute`；也可能提供 `tracepath`。

- 语法

```bash
traceroute [选项] <主机> [数据包长度]
```

- 常用选项

| 选项 | 功能 | 字母来源 |
|---|---|---|
| `-n` | 不解析主机名 | numeric |
| `-m <跳数>` | 设置最大跳数 | max hops |
| `-w <秒>` | 设置每次探测等待时间 | wait |
| `-q <次数>` | 每一跳发送的探测数 | queries |
| `-I` | 使用 ICMP ECHO | ICMP |
| `-T` | 使用 TCP SYN | TCP |
| `-p <端口>` | 设置 UDP/TCP 目标端口 | port |

- 参数填写：填写域名或 IP；出现 `*` 可能只是中间设备不回复探测包。

- 示例（节选）

```console
$ traceroute -n -m 5 8.8.8.8
traceroute to 8.8.8.8 (8.8.8.8), 5 hops max
 1  192.168.1.1  0.645 ms  0.581 ms  0.552 ms
 2  10.0.0.1     3.112 ms  3.084 ms  3.220 ms
 3  * * *
```

---

## 14. 远程登录与文件同步

### 14.1 `ssh`：安全远程登录和执行命令

- 名称来源：`ssh` 来自英语 “Secure Shell”，即“安全 Shell”。

- 语法

```bash
ssh [选项] [用户@]主机 [远程命令 [参数...]]
```

- 常用选项

| 选项 | 功能 | 字母来源 |
|---|---|---|
| `-p <端口>` | 指定服务器端口，默认 22 | port |
| `-i <私钥文件>` | 指定身份私钥 | identity file |
| `-L <本地端口:目标主机:目标端口>` | 本地端口转发 | local forwarding |
| `-R <远程端口:目标主机:目标端口>` | 远程端口转发 | remote forwarding |
| `-N` | 不执行远程命令，常用于端口转发 | no remote command |
| `-T` | 禁止分配伪终端 | no pseudo-terminal |
| `-t` | 强制分配伪终端 | pseudo-terminal |
| `-v` | 输出调试信息；可用 `-vv`、`-vvv` 增加详细度 | verbose |
| `-J <跳板主机>` | 通过跳板主机连接 | jump host |
| `-o <配置项=值>` | 临时指定 SSH 配置 | option |

- 参数填写：主机可为域名或 IP；用户省略时使用本地用户名。首次连接应核对服务器指纹，私钥文件权限通常应为 `600`。

- 示例

```console
$ ssh -p 2222 alice@server.example.com 'hostname; uptime -p'
server01
up 12 days, 4 hours, 8 minutes
```

### 14.2 `scp`：通过 SSH 复制文件

- 名称来源：`scp` 来自英语 “secure copy”，即“安全复制”。

- 语法

```bash
scp [选项] <源...> <目标>
```

远程路径格式为 `[用户@]主机:路径`。

- 常用选项

| 选项 | 功能 | 字母来源 |
|---|---|---|
| `-r` | 递归复制目录 | recursive |
| `-P <端口>` | 指定 SSH 端口；注意是大写 `P` | port |
| `-i <私钥文件>` | 指定私钥 | identity file |
| `-p` | 保留修改时间、访问时间和权限 | preserve |
| `-C` | 启用传输压缩 | compression |
| `-q` | 减少输出 | quiet |
| `-l <Kbit/s>` | 限制带宽 | limit bandwidth |

- 参数填写：本地与远程路径可互为源和目标；远程路径含空格时需谨慎引用。

- 示例

```console
$ scp -P 2222 report.txt alice@server.example.com:/tmp/
report.txt                                    100% 1280   210.4KB/s   00:00
```

### 14.3 `rsync`：高效复制与增量同步

- 名称来源：`rsync` 通常理解为 “remote sync”，即“远程同步”；同样可以只在本地使用。

> 本地和远端通常都需安装 `rsync`。通过 SSH 使用时，远程格式与 `scp` 类似。

- 语法

```bash
rsync [选项] <源...> <目标>
```

- 常用选项

| 选项 | 功能 | 字母来源 |
|---|---|---|
| `-a` | 归档模式，递归并保留大多数属性 | archive |
| `-v` | 显示详情 | verbose |
| `-h` | 使用易读单位 | human-readable |
| `-z` | 传输时压缩 | compress |
| `-P` | 等价于 `--partial --progress`，保留部分文件并显示进度 | partial + progress |
| `-n`、`--dry-run` | 只预演，不真正修改 | no changes / dry run |
| `--delete` | 删除目标中源端已不存在的文件，使用前务必预演 |  |
| `--exclude='<模式>'` | 排除匹配项 |  |
| `-e '<远程Shell>'` | 指定 SSH 及参数 | remote shell |

- 参数填写：源目录末尾的 `/` 很重要：`src/ dest/` 同步 `src` 内部内容，`src dest/` 会在目标中创建 `src` 目录。

- 示例

```console
$ rsync -avhn --delete project/ backup/project/
sending incremental file list
deleting old.tmp
src/main.py

sent 182 bytes  received 34 bytes  432.00 bytes/sec
total size is 8.20K  speedup is 37.96 (DRY RUN)
```

---

## 15. 软件包管理

> 只使用适合当前发行版的一组命令。安装、升级和删除通常需要 `sudo`。升级生产系统前应阅读发行版文档并做好备份。

### 15.1 `apt`：Debian/Ubuntu 软件包管理

- 名称来源：`apt` 来自英语 “Advanced Package Tool”，即“高级软件包工具”。

- 语法

```bash
apt [选项] <子命令> [软件包...]
```

- 常用子命令与选项

| 写法 | 功能 | 字母来源 |
|---|---|---|
| `apt update` | 更新可用软件包索引 |  |
| `apt upgrade` | 升级已安装软件包，不主动删除包 |  |
| `apt full-upgrade` | 必要时安装或删除依赖以完成升级 |  |
| `apt install <包>` | 安装软件包；`包=版本` 可指定版本 |  |
| `apt remove <包>` | 删除软件包，通常保留配置 |  |
| `apt purge <包>` | 连同系统级配置一起删除 |  |
| `apt autoremove` | 删除不再需要的自动依赖 |  |
| `apt search <词>` | 搜索软件包 |  |
| `apt show <包>` | 显示详情 |  |
| `apt list --installed` | 列出已安装包 |  |
| `-y` | 自动回答“是”；使用前确认操作范围 | yes |
| `--no-install-recommends` | 不安装推荐依赖 |  |

- 参数填写：软件包名如 `curl`、`nginx`；可一次填写多个。`apt` 适合交互使用，脚本常使用更稳定的 `apt-get`。

- 示例（节选）

```console
$ sudo apt install tree
Reading package lists... Done
Building dependency tree... Done
The following NEW packages will be installed:
  tree
0 upgraded, 1 newly installed, 0 to remove.
```

### 15.2 `dnf`：Fedora/RHEL 系软件包管理

- 名称来源：`dnf` 来自英语 “Dandified YUM”，最初是对 YUM 的新一代实现名称。

- 语法

```bash
dnf [选项] <子命令> [软件包...]
```

- 常用子命令与选项

| 写法 | 功能 | 字母来源 |
|---|---|---|
| `dnf check-update` | 检查可用更新 |  |
| `dnf upgrade` | 升级软件包 |  |
| `dnf install <包>` | 安装软件包 |  |
| `dnf remove <包>` | 删除软件包 |  |
| `dnf autoremove` | 删除不再需要的依赖 |  |
| `dnf search <词>` | 搜索软件包 |  |
| `dnf info <包>` | 显示详情 |  |
| `dnf list installed` | 列出已安装包 |  |
| `dnf provides '<路径模式>'` | 查询哪个包提供文件 |  |
| `-y` | 自动确认 | yes |
| `--refresh` | 强制刷新仓库元数据 |  |

- 参数填写：包名可为简单名称、完整 NEVRA 或本地 RPM 路径；RHEL 旧版可能使用 `yum`。

- 示例（节选）

```console
$ sudo dnf install tree
Dependencies resolved.
================================================================================
 Package       Architecture    Version             Repository             Size
================================================================================
Installing:
 tree          x86_64          2.1.1-1.fc42        fedora                 55 k
Transaction Summary
Install  1 Package
```

### 15.3 `pacman`：Arch Linux 软件包管理

- 名称来源：`pacman` 是英语 “package manager”的缩合，同时借用了经典游戏 Pac-Man 的名称意象。

- 语法

```bash
pacman <操作> [选项] [软件包...]
```

- 常用选项与操作

| 写法 | 功能 | 字母来源 |
|---|---|---|
| `pacman -Syu` | 刷新数据库并完整升级系统，推荐的升级方式 | S = sync；y = refresh；u = system upgrade |
| `pacman -S <包>` | 安装仓库软件包 | S = sync |
| `pacman -R <包>` | 删除软件包 | R = remove |
| `pacman -Rs <包>` | 删除包及不再需要的依赖 | R = remove；s = recursive dependencies |
| `pacman -Rns <包>` | 同时删除依赖和备份配置，执行前检查清单 | R = remove；n = no-save；s = recursive dependencies |
| `pacman -Ss <词>` | 搜索仓库 | S = sync；s = search |
| `pacman -Qs <词>` | 搜索已安装包 | Q = query；s = search |
| `pacman -Qi <包>` | 查看已安装包详情 | Q = query；i = info |
| `pacman -Ql <包>` | 列出包安装的文件 | Q = query；l = list files |
| `pacman -Qo <路径>` | 查询文件属于哪个包 | Q = query；o = owns |
| `--needed` | 已是最新的包不重复安装 |  |
| `--noconfirm` | 不询问确认；谨慎使用 |  |

- 参数填写：填写仓库包名；Arch 不支持长期“只刷新数据库而不升级”的部分升级工作流。

- 示例（节选）

```console
$ sudo pacman -S --needed tree
resolving dependencies...
looking for conflicting packages...
Packages (1) tree-2.2.1-1
Total Installed Size:  0.12 MiB
:: Proceed with installation? [Y/n]
```

---

## 16. systemd 服务与日志

> 以下命令适用于使用 systemd 的发行版。其他初始化系统的命令不同。

### 16.1 `systemctl`：管理 systemd 单元

- 名称来源：`systemctl` 由 `system` 与 `ctl`（control）构成，即“系统控制”。

- 语法

```bash
systemctl [选项] <子命令> [单元...]
```

- 常用子命令与选项

| 写法 | 功能 | 字母来源 |
|---|---|---|
| `status <单元>` | 查看状态 |  |
| `start` / `stop <单元>` | 启动/停止 |  |
| `restart <单元>` | 停止后重新启动 |  |
| `reload <单元>` | 让支持的服务重新加载配置 |  |
| `enable` / `disable <单元>` | 启用/禁用开机启动，不立即启动/停止 |  |
| `enable --now <单元>` | 启用并立即启动 |  |
| `is-active <单元>` | 判断当前是否活动 |  |
| `is-enabled <单元>` | 判断是否启用 |  |
| `list-units --type=service` | 列出已加载服务单元 |  |
| `list-unit-files` | 列出单元文件及启用状态 |  |
| `daemon-reload` | 单元文件变化后重新加载管理器配置 |  |
| `--user` | 管理当前用户的 systemd 单元 |  |
| `--failed` | 只显示失败单元 |  |

- 参数填写：单元名如 `nginx.service`；`.service` 常可省略。修改系统服务通常需 `sudo`。

- 示例（节选）

```console
$ systemctl is-active ssh.service
active
$ systemctl is-enabled ssh.service
enabled
```

### 16.2 `journalctl`：查询 systemd 日志

- 名称来源：`journalctl` 由 `journal`（日志）与 `ctl`（control）构成，即“日志控制/查询”。

- 语法

```bash
journalctl [选项] [匹配条件...]
```

- 常用选项

| 选项 | 功能 | 字母来源 |
|---|---|---|
| `-u <单元>` | 只看指定单元日志 | unit |
| `-b [编号]` | 只看本次或指定启动的日志 | boot |
| `-f` | 持续跟踪新日志 | follow |
| `-n <数量>` | 只看末尾若干条 | number of entries |
| `--since '<时间>'` | 指定开始时间 |  |
| `--until '<时间>'` | 指定结束时间 |  |
| `-p <级别>` | 按优先级筛选，如 `err`、`warning` | priority |
| `-k` | 只看内核日志 | kernel |
| `-o <格式>` | 指定格式，如 `short-iso`、`json`、`cat` | output |
| `--disk-usage` | 显示日志占用空间 |  |
| `--no-pager` | 不使用分页器 |  |

- 参数填写：时间可写 `today`、`yesterday`、`2026-09-20 09:00:00`。部分系统查看完整日志需管理员权限或加入特定组。

- 示例

```console
$ journalctl -u ssh.service --since 'today' -n 2 --no-pager
Sep 20 09:15:22 server01 sshd[1204]: Accepted publickey for alice from 192.168.1.10
Sep 20 09:15:22 server01 sshd[1204]: pam_unix(sshd:session): session opened
```

### 16.3 `dmesg`：查看内核环形缓冲区消息

- 名称来源：`dmesg` 通常解释为英语 “display message”，用于显示内核消息缓冲区。

- 语法

```bash
dmesg [选项]
```

- 常用选项

| 选项 | 功能 | 字母来源 |
|---|---|---|
| `-H` | 易读格式并使用分页器 | human-readable |
| `-T` | 尝试显示人类可读时间；休眠等情况下可能不精确 | human-readable time |
| `-w` | 持续等待新消息 | wait / follow |
| `-l <级别>` | 按级别筛选，如 `err,warn` | level |
| `-k` | 只显示内核消息 | kernel |
| `-f <设施>` | 按 facility 筛选 | facility |
| `-C` | 清空缓冲区，需权限且影响诊断，谨慎使用 | clear |

- 参数填写：通常无普通参数；某些系统限制普通用户读取。

- 示例

```console
$ sudo dmesg -T -l err,warn | tail -n 2
[Sun Sep 20 09:01:12 2026] usb 1-2: device descriptor read/64, error -71
[Sun Sep 20 09:01:13 2026] usb 1-2: device not accepting address 4, error -71
```

---

## 17. 帮助与命令发现

### 17.1 `man`：阅读手册页

- 名称来源：`man` 是英语 “manual”的缩写，意为“手册”。

- 语法

```bash
man [选项] [章节] <名称>
```

- 常用选项

| 选项 | 功能 | 字母来源 |
|---|---|---|
| `-k <关键词>` | 搜索手册简介，等价于 `apropos` | keyword |
| `-f <名称>` | 显示简短说明，等价于 `whatis` | one-line description |
| `-a` | 依次显示所有匹配章节 | all |
| `-w` | 只显示手册文件位置 | where |
| `-K <文本>` | 搜索所有手册正文，可能较慢 | search all manual text |

常见章节：`1` 用户命令、`2` 系统调用、`3` 库函数、`5` 配置格式、`8` 管理命令。

- 参数填写：名称如 `printf`；有歧义时写 `man 1 printf` 或 `man 3 printf`。按 `q` 退出。

- 示例

```console
$ man -f passwd
passwd (1)           - change user password
passwd (5)           - the password file
```

### 17.2 `info`：阅读 GNU Info 文档

- 名称来源：`info` 是英语 “information”的缩写，意为“信息”。

- 语法

```bash
info [选项] [主题]
```

- 常用选项

| 选项 | 功能 | 字母来源 |
|---|---|---|
| `--apropos=<词>` | 在索引中搜索 |  |
| `-o <文件>` | 输出到文件而非交互显示 | output |
| `--subnodes` | 输出节点及其子节点 |  |
| `--vi-keys` | 使用类似 vi 的按键 |  |

- 参数填写：主题通常为命令或软件包名，如 `coreutils`。交互中 `n` 下一节点、`p` 上一节点、`u` 上级、`q` 退出。

- 示例（节选）

```console
$ info --apropos='copy files'
* cp: (coreutils)cp invocation.        Copy files and directories.
* install: (coreutils)install invocation. Copy files and set attributes.
```

### 17.3 `apropos`：按关键词搜索手册简介

- 名称来源：`apropos` 来自法语 “à propos”，意为“关于、切题”，用于寻找与关键词相关的手册项。

- 语法

```bash
apropos [选项] <关键词...>
```

- 常用选项

| 选项 | 功能 | 字母来源 |
|---|---|---|
| `-a` | 所有关键词都必须匹配 | and / match all words |
| `-e` | 精确匹配名称和说明 | exact |
| `-s <章节列表>` | 只搜索指定手册章节 | sections |
| `-r` | 把关键词解释为正则表达式，通常为默认 | regular expression |
| `-w` | 使用 Shell 通配符匹配 | wildcard |

- 参数填写：可填写一个或多个主题词；数据库缺失时管理员可运行 `mandb` 更新。

- 示例

```console
$ apropos -a 'copy' 'file' | head -n 2
cp (1)               - copy files and directories
install (1)          - copy files and set attributes
```

### 17.4 `whatis`：显示命令的一行说明

- 名称来源：`whatis` 直接连写自英语问句 “what is”，即“这是什么”。

- 语法

```bash
whatis [选项] <名称...>
```

- 常用选项

| 选项 | 功能 | 字母来源 |
|---|---|---|
| `-a` | 显示所有匹配说明 | all |
| `-s <章节列表>` | 只查询指定章节 | sections |
| `-w` | 使用通配符 | wildcard |
| `-r` | 使用正则表达式 | regular expression |

- 参数填写：填写一个或多个命令/主题名称。

- 示例

```console
$ whatis ls cp
ls (1)               - list directory contents
cp (1)               - copy files and directories
```

### 17.5 `help`：查看 Bash 内建命令帮助

- 名称来源：`help` 直接取自英语“帮助”。

- 语法

```bash
help [选项] [模式]
```

- 常用选项

| 选项 | 功能 | 字母来源 |
|---|---|---|
| `-d` | 只显示简短描述 | description |
| `-m` | 使用类似手册页的格式 | manpage-like format |
| `-s` | 只显示简短用法 | synopsis |

- 参数填写：填写 Bash 内建命令名，如 `cd`、`export`、`history`；省略时列出所有内建命令。

- 示例

```console
$ help -s cd
cd: cd [-L|[-P [-e]] [-@]] [dir]
```

---

## 18. Shell 输出、变量与历史

### 18.1 `echo`：输出文本或变量值

- 名称来源：`echo` 取自英语“回声”，表示把收到的文字再次输出。

- 语法

```bash
echo [选项] [字符串...]
```

- 常用选项

| 选项 | 功能 | 字母来源 |
|---|---|---|
| `-n` | 末尾不输出换行 | no trailing newline |
| `-e` | 解释反斜杠转义；不同 Shell 兼容性不完全一致 | enable escapes |
| `-E` | 不解释转义，通常为默认 | disable escapes |

- 参数填写：多个参数以空格分隔；包含空格或通配符时加引号。需可移植的精确格式时优先用 `printf`。

- 示例

```console
$ echo "User: $USER"
User: alice
$ echo -n 'ready'; echo ' now'
ready now
```

### 18.2 `printf`：按格式输出

- 名称来源：`printf` 来自英语 “print formatted”，即“按格式打印”。

- 语法

```bash
printf <格式> [参数...]
```

- 常用格式

| 格式 | 功能 |
|---|---|
| `%s` | 字符串 |
| `%d` | 十进制整数 |
| `%f` | 浮点数 |
| `%q` | 输出可被 Shell 重用的引用形式；Bash 扩展 |
| `%-10s` | 字符串左对齐，占 10 列 |
| `%.2f` | 浮点数保留两位小数 |
| `\n` / `\t` | 换行 / 制表符 |

- 参数填写：第一个参数是格式字符串，后续参数依次填入格式占位符；格式会在参数有剩余时重复使用。

- 示例

```console
$ printf '%-8s %6.2f\n' apple 3.5 banana 12
apple      3.50
banana    12.00
```

### 18.3 `export`：导出环境变量

- 名称来源：`export` 取自英语“导出”，表示把 Shell 变量导出给子进程环境。

- 语法

```bash
export [选项] [名称[=值] ...]
```

- 常用选项

| 选项 | 功能 | 字母来源 |
|---|---|---|
| `-p` | 列出已导出的变量 | print |
| `-n` | 取消变量的导出属性，但不删除变量 | remove export attribute |
| `-f` | 在 Bash 中导出函数；谨慎使用 | functions |

- 参数填写：变量名通常由字母、数字、下划线组成且不能以数字开头；赋值两侧不能有空格。只影响当前 Shell 及之后启动的子进程。

- 示例

```console
$ export APP_ENV=production
$ sh -c 'echo "$APP_ENV"'
production
```

### 18.4 `unset`：删除变量或函数

- 名称来源：`unset` 由否定前缀 `un-` 与 `set` 构成，表示取消设置。

- 语法

```bash
unset [选项] <名称...>
```

- 常用选项

| 选项 | 功能 | 字母来源 |
|---|---|---|
| `-v` | 删除变量，通常为默认 | variable |
| `-f` | 删除 Shell 函数 | function |
| `-n` | Bash 中删除名称引用变量本身，而非其引用目标 | name reference |

- 参数填写：填写变量名，不写 `$`；只影响当前 Shell。

- 示例

```console
$ TEMP_VALUE=123
$ unset TEMP_VALUE
$ printf '<%s>\n' "$TEMP_VALUE"
<>
```

### 18.5 `alias`：创建或查看命令别名

- 名称来源：`alias` 源自拉丁语，含“另一个名字/又名”之意。

- 语法

```bash
alias [名称[='替换文本'] ...]
```

- 常用选项：Bash 的 `alias` 通常无常用选项；`alias -p` 以可重用格式列出全部别名。

- 参数填写：赋值两侧不能有空格；替换文本通常用单引号。当前 Shell 中有效，持久化需写入相应 Shell 配置文件。

- 示例

```console
$ alias ll='ls -lah'
$ alias ll
alias ll='ls -lah'
```

### 18.6 `unalias`：删除命令别名

- 名称来源：`unalias` 由反向前缀 `un-` 与 `alias` 构成，表示取消别名。

- 语法

```bash
unalias [选项] <名称...>
```

- 常用选项

| 选项 | 功能 | 字母来源 |
|---|---|---|
| `-a` | 删除当前 Shell 的全部别名 | all |

- 参数填写：填写别名名称，不写其展开内容。

- 示例

```console
$ unalias ll
$ alias ll
bash: alias: ll: not found
```

### 18.7 `history`：查看和管理 Bash 命令历史

- 名称来源：`history` 直接取自英语“历史”，指此前执行过的命令记录。

- 语法

```bash
history [选项] [数量]
```

- 常用选项

| 选项 | 功能 | 字母来源 |
|---|---|---|
| `history <数量>` | 显示最近若干条 |  |
| `-c` | 清空当前会话历史列表；谨慎使用 | clear |
| `-d <位置>` | 删除指定历史项 | delete |
| `-a` | 把本会话新增记录追加到历史文件 | append |
| `-n` | 读取历史文件中尚未载入的新记录 | new lines |
| `-r` | 读取历史文件并追加到当前列表 | read |
| `-w` | 用当前列表覆盖历史文件；谨慎使用 | write |

- 参数填写：数量或位置为历史编号。历史文件通常由 `$HISTFILE` 指定。不要在命令行直接输入密码、令牌等秘密。

- 示例

```console
$ history 3
  501  pwd
  502  ls -lah
  503  history 3
```

### 18.8 `source`：在当前 Shell 中读取并执行文件

- 名称来源：`source` 取自英语“来源/引入”，表示把文件内容引入当前 Shell 执行。

- 语法

```bash
source <文件> [参数...]
. <文件> [参数...]
```

- 常用选项：通常无选项；`.` 是 POSIX 形式，`source` 常见于 Bash。

- 参数填写：填写可信的 Shell 文件路径；后续参数会在执行期间成为位置参数。它会直接改变当前 Shell 的变量、目录和函数。

- 示例

```console
$ printf 'export COLOR=blue\n' > settings.sh
$ source ./settings.sh
$ echo "$COLOR"
blue
```

### 18.9 `clear`：清理终端显示

- 名称来源：`clear` 直接取自英语“清除”，表示清理终端显示。

- 语法

```bash
clear [选项]
```

- 常用选项

| 选项 | 功能 | 字母来源 |
|---|---|---|
| `-x` | 只清当前可见屏幕，不尝试清除回滚缓冲区 |  |
| `-T <终端类型>` | 使用指定终端类型 | terminal type |

- 参数填写：通常无参数；清屏不会删除命令历史。

- 示例（效果描述）

```console
$ clear
[终端当前可见内容被清除，光标移到左上角]
```

### 18.10 `sleep`：等待指定时间

- 名称来源：`sleep` 直接取自英语“睡眠”，形象表示让进程暂停一段时间。

- 语法

```bash
sleep <时长...>
```

- 常用后缀

| 后缀 | 功能 |
|---|---|
| `s` | 秒，默认单位 |
| `m` | 分钟 |
| `h` | 小时 |
| `d` | 天 |

- 参数填写：可用小数，如 `0.5s`；GNU 版本可把多个时长相加。按 `Ctrl+C` 可中断。

- 示例

```console
$ date +%T; sleep 2; date +%T
11:20:00
11:20:02
```

---

## 19. 批量参数、校验与底层复制

### 19.1 `xargs`：把标准输入转换成命令参数

- 名称来源：`xargs` 来自英语 “extended arguments”，即把输入扩展为命令参数。

- 语法

```bash
生成输入的命令 | xargs [选项] <命令> [固定参数...]
```

- 常用选项

| 选项 | 功能 | 字母来源 |
|---|---|---|
| `-0` | 输入项以 NUL 分隔，安全处理空格和换行文件名 |  |
| `-n <数量>` | 每次最多传递指定数量的参数 | number of arguments |
| `-P <数量>` | 并行运行指定数量的进程；`0` 表示尽可能多 | parallel processes |
| `-I <占位符>` | 在命令任意位置替换输入项，通常每项运行一次 |  |
| `-r` | 无输入时不执行命令；GNU 选项 | no run if empty |
| `-t` | 执行前打印命令 | trace |
| `-p` | 执行前交互确认 | prompt |

- 参数填写：文件名场景优先使用 `find ... -print0 | xargs -0 ...`。若命令支持 `find -exec ... +`，后者往往更直接。

- 示例

```console
$ printf 'one\ntwo\nthree\n' | xargs -n 2 echo item:
item: one two
item: three
$ find . -maxdepth 1 -name '*.tmp' -print0 | xargs -0 -r -n 1 echo
./old file.tmp
./cache.tmp
```

### 19.2 `sha256sum`：计算或校验 SHA-256 摘要

- 名称来源：`sha256sum` 由算法名 SHA-256 与 `sum`（校验和）组成；SHA 是 “Secure Hash Algorithm”。

- 语法

```bash
sha256sum [选项] [文件...]
sha256sum -c [选项] <校验文件>
```

- 常用选项

| 选项 | 功能 | 字母来源 |
|---|---|---|
| `-c` | 按校验文件验证 | check |
| `--ignore-missing` | 校验时忽略不存在的文件 |  |
| `--quiet` | 校验成功时不逐项输出 |  |
| `--status` | 不输出，只通过退出码表示结果 |  |
| `--strict` | 格式不正确的校验行使验证失败 |  |

- 参数填写：省略文件或写 `-` 时读取标准输入；校验文件通常由 `sha256sum 文件 > checksums.txt` 生成。

- 示例

```console
$ sha256sum report.txt > checksums.txt
$ sha256sum -c checksums.txt
report.txt: OK
```

### 19.3 `md5sum`：计算或校验 MD5 摘要

- 名称来源：`md5sum` 由 MD5 与 `sum`（校验和）组成；MD5 是 “Message-Digest Algorithm 5”。

- 语法

```bash
md5sum [选项] [文件...]
md5sum -c [选项] <校验文件>
```

- 常用选项：`-c` 校验、`--quiet` 隐藏成功项、`--status` 仅返回状态、`--ignore-missing` 忽略缺失文件。

- 参数填写：与 `sha256sum` 相同。MD5 可用于意外损坏检测，但已不适合验证对抗恶意篡改的安全场景。

- 示例

```console
$ md5sum hello.txt
09f7e02f1290be211da707a266f153b3  hello.txt
```

### 19.4 `dd`：按块复制和转换数据

- 名称来源：`dd` 的名称源自 IBM 作业控制语言中的 “Data Definition”语句；它并非 “disk dump”的正式缩写。

- 语法

```bash
dd if=<输入> of=<输出> [操作数...]
```

- 常用操作数

| 操作数 | 功能 |
|---|---|
| `if=<路径>` | 输入文件或设备，省略时为标准输入 |
| `of=<路径>` | 输出文件或设备，省略时为标准输出 |
| `bs=<大小>` | 同时设置读写块大小，如 `4M` |
| `count=<数量>` | 复制指定数量的输入块 |
| `skip=<数量>` | 跳过若干输入块 |
| `seek=<数量>` | 跳过若干输出块位置 |
| `status=progress` | 持续显示进度 |
| `conv=fsync` | 结束前把输出数据同步到设备 |
| `conv=noerror,sync` | 读错时继续并填充坏块，常用于救援但并非专业恢复工具的替代品 |

- 参数填写：这是 `名称=值` 风格，等号两侧不能有空格。写错 `of=` 设备会不可逆覆盖数据；对磁盘操作前务必用 `lsblk` 多次核对。

- 示例（创建 10 MiB 测试文件）

```console
$ dd if=/dev/zero of=test.img bs=1M count=10 status=progress
10485760 bytes (10 MB, 10 MiB) copied, 0.01 s, 1.0 GB/s
10+0 records in
10+0 records out
10485760 bytes (10 MB, 10 MiB) copied, 0.011 s, 953 MB/s
```

---

## 20. 常见组合范例

这些范例只组合前文已经介绍过的简单命令。

### 20.1 找出当前目录最大的 5 个普通文件

```console
$ find . -type f -printf '%s\t%p\n' | sort -nr | head -n 5
52428800        ./backup/data.bin
12582912        ./logs/app.log
4194304         ./build/app
1048576         ./docs/manual.pdf
524288          ./assets/logo.png
```

其中 `find -printf` 是 GNU 扩展；第一列为字节数。

### 20.2 统计日志中各 HTTP 状态码数量

假设状态码位于空格分隔的第 9 列：

```console
$ cut -d' ' -f9 access.log | sort | uniq -c | sort -nr
   1240 200
     83 404
     12 500
```

### 20.3 查找最近一天修改的日志并归档

先检查列表，再创建归档：

```console
$ find /var/log/myapp -type f -name '*.log' -mtime -1 -print
/var/log/myapp/app.log
/var/log/myapp/worker.log
$ find /var/log/myapp -type f -name '*.log' -mtime -1 -print0 | tar --null -T - -czf recent-logs.tar.gz
$ tar -tzf recent-logs.tar.gz
var/log/myapp/app.log
var/log/myapp/worker.log
```

### 20.4 查看最占内存的 5 个进程

```console
$ ps -eo pid,user,%mem,rss,comm --sort=-%mem | head -n 6
    PID USER     %MEM   RSS COMMAND
   2841 alice     8.2 1345200 java
   1920 alice     5.1 835400 firefox
   1022 root      2.4 393200 dockerd
    945 www-data  1.2 196608 nginx
   3110 alice     0.9 147456 python3
```

### 20.5 安全预演目录镜像同步

```console
$ rsync -avhn --delete source/ backup/
sending incremental file list
deleting obsolete.txt
docs/new.md

sent 156 bytes  received 28 bytes  368.00 bytes/sec
total size is 24.80K  speedup is 134.78 (DRY RUN)
```

确认列表无误后，去掉 `-n` 才会真正执行。

---

## 21. 退出码、管道和重定向速记

这些不是独立外部命令，但阅读前面范例时经常用到。

| 写法 | 含义 | 示例 |
|---|---|---|
| `$?` | 上一条命令的退出码；通常 `0` 成功，非 `0` 失败 | `grep word file; echo $?` |
| `命令1 \| 命令2` | 把命令 1 的标准输出交给命令 2 | `ps aux \| grep nginx` |
| `>` | 覆盖写入标准输出 | `date > now.txt` |
| `>>` | 追加标准输出 | `date >> history.txt` |
| `2>` | 覆盖写入标准错误 | `find /root 2>errors.log` |
| `2>&1` | 把标准错误合并到当前标准输出目标 | `cmd >all.log 2>&1` |
| `<` | 从文件提供标准输入 | `sort < names.txt` |
| `&&` | 前一条成功才运行后一条 | `mkdir build && cd build` |
| `\|\|` | 前一条失败才运行后一条 | `ping -c1 host \|\| echo failed` |
| `;` | 无论前一条是否成功都继续 | `date; uptime` |
| `&` | 在后台启动 | `sleep 300 &` |

- 示例

```console
$ grep -q 'ready' status.txt && echo 'service ready' || echo 'not ready'
service ready
$ echo $?
0
```

---

## 22. 使用建议

1. 不确定选项时先运行 `命令 --help`，再查看 `man 命令`。
2. 删除、覆盖、递归改权限、镜像同步前，先用只读命令核对范围；`rsync` 优先加 `--dry-run`。
3. 路径和模式尽量加引号，尤其是含空格、`*`、`?`、`[` 的内容。
4. 文本处理优先组合小命令：筛选用 `grep`，排序用 `sort`，相邻去重用 `uniq`，列提取用 `cut`。
5. 自动化脚本中要检查退出码，并避免依赖仅适用于某一发行版或 GNU 版本的选项。
6. 从互联网复制来的命令应先逐段理解，特别警惕直接管道给 Shell、`rm -rf`、`dd of=/dev/...`、递归 `chmod/chown`。
