# MyConfig

个人配置文件仓库，包含 Zsh、komorebi、Yazi、Ableton Live / SMK25 II 的配置。

---

## 目录结构

```
myconfig/
├── .zshrc                          # Zsh Shell 配置
├── komorebiconf/
│   ├── komorebi.json               # 窗口管理器主配置
│   ├── komorebi.bar.json           # 状态栏配置
│   └── whkdrc                      # 快捷键绑定 → ~/.config/whkdrc
├── yaziconf/
│   ├── yazi.toml                   # Yazi 通用设置
│   ├── keymap.toml                 # Yazi 快捷键
│   ├── theme.toml                  # Yazi 主题配色
│   └── vfs.toml                    # Yazi 虚拟文件系统 (SFTP)
└── music/
    ├── mysmk25iiconf.mkcII         # SMK25 II MIDI 键盘预设
    └── abletonliveconf/
        └── SMK25II/
            └── UserConfiguration.txt  # Ableton Live SMK25 II 映射
```

---

## 快速部署

```bash
git clone git@github.com:microfatrat/myconfig.git ~/myconfig
```

### Zsh

```bash
ln -sf ~/myconfig/.zshrc ~/.zshrc
source ~/.zshrc
```

### Komorebi

```powershell
# 1. 创建符号链接

# 确保 .config 目录存在
New-Item -ItemType Directory -Path "$HOME\.config" -Force | Out-Null

# 窗口管理器
New-Item -ItemType SymbolicLink `
    -Path "$HOME\komorebi.json" `
    -Target "$HOME\myconfig\komorebiconf\komorebi.json" `
    -Force

# 状态栏
New-Item -ItemType SymbolicLink `
    -Path "$HOME\komorebi.bar.json" `
    -Target "$HOME\myconfig\komorebiconf\komorebi.bar.json" `
    -Force

# 快捷键
New-Item -ItemType SymbolicLink `
    -Path "$HOME\.config\whkdrc" `
    -Target "$HOME\myconfig\komorebiconf\whkdrc" `
    -Force
```

```powershell
# 2. 启动服务
komorebic start          # 启动平铺窗口管理器
komorebic bar start      # 启动状态栏
whkd                     # 启动快捷键守护进程
```

```powershell
# 3. 修改配置后热重载
komorebic reload-configuration
komorebic bar reload-configuration
whkd -r                  # 重载快捷键
```

```powershell
# 4. 设置开机自启（bar 和 whkd 跟随 komorebi 启动）
komorebic enable-autostart

# 然后编辑计划任务: taskschd.msc → 找到 komorebi → 将操作改为:
#   "C:\Program Files\komorebi\bin\komorebic-no-console.exe" start --whkd --bar
```

### Yazi

```powershell
# yazi 从 %APPDATA%\yazi\config\ 读取配置
New-Item -ItemType Directory -Path "$env:APPDATA\yazi\config" -Force | Out-Null

New-Item -ItemType SymbolicLink `
    -Path "$env:APPDATA\yazi\config\yazi.toml" `
    -Target "$HOME\myconfig\yaziconf\yazi.toml" -Force

New-Item -ItemType SymbolicLink `
    -Path "$env:APPDATA\yazi\config\keymap.toml" `
    -Target "$HOME\myconfig\yaziconf\keymap.toml" -Force

New-Item -ItemType SymbolicLink `
    -Path "$env:APPDATA\yazi\config\theme.toml" `
    -Target "$HOME\myconfig\yaziconf\theme.toml" -Force

New-Item -ItemType SymbolicLink `
    -Path "$env:APPDATA\yazi\config\vfs.toml" `
    -Target "$HOME\myconfig\yaziconf\vfs.toml" -Force
```

### Ableton Live / SMK25 II

```powershell
# 将 UserConfiguration.txt 放入 Ableton 的 User Remote Scripts 目录
# 通常是 Documents\Ableton\User Library\Remote Scripts\SMK25II\

# SMK25 II 预设文件 mysmk25iiconf.mkcII 通过 MIDI Keyboard Center 加载
```

---

## .zshrc — Zsh Shell

### 依赖

- **Zsh** 5.0+
- 推荐安装：

```bash
sudo apt install zsh-fast-syntax-highlighting zsh-autosuggestions
```

### Shell 选项

| 功能 | 说明 |
|---|---|
| **历史记录** | 10000 条，跨终端实时共享，自动去重 |
| **自动 cd** | 直接输入目录名即可跳转 |
| **自动 pushd** | cd 时自动维护目录栈 |
| **扩展 glob** | 支持 `^`、`#` 等高级通配符 |
| **自动纠错** | 命令拼写错误时自动纠正 |

### 补全系统

- `compinit -C` 跳过安全检查，快速启动
- 大小写不敏感匹配 + 智能分隔符处理
- 匹配 `LS_COLORS` 的彩色输出

### 别名

#### 文件列表

| 别名 | 展开 |
|---|---|
| `ll` | `ls -alF` |
| `la` | `ls -A` |
| `l` | `ls -CF` |

`ls` 会根据系统自动彩色化（Linux `--color=auto`，macOS `-G`）。

#### 安全操作（交互 + 详细）

| 别名 | 展开 |
|---|---|
| `cp` | `cp -iv` |
| `mv` | `mv -iv` |
| `rm` | `rm -i` |
| `mkdir` | `mkdir -p` |

#### 导航

| 别名 | 操作 |
|---|---|
| `..` | 上一级目录 |
| `...` | 上两级目录 |
| `-` | 返回上一个目录 |
| `d` | 显示目录栈 |

#### 其他

| 别名 | 展开 |
|---|---|
| `grep` | `grep --color=auto` |

### 快捷键

| 按键 | 操作 |
|---|---|
| `Home` | 行首 |
| `End` | 行尾 |
| `Delete` | 删除字符 |
| `Ctrl+→` | 前进一个词 |
| `Ctrl+←` | 后退一个词 |
| `Ctrl+R` | 历史增量搜索 |

### 提示符

- **左侧**：`user@host` (青) `当前目录` (绿) `%`/`#` (黄)
- **右侧**：当前时间 (紫)

### 插件（有则自动加载）

| 插件 | 包名 | 用途 |
|---|---|---|
| [fast-syntax-highlighting](https://github.com/zdharma-continuum/fast-syntax-highlighting) | `zsh-fast-syntax-highlighting` | 异步语法高亮 |
| [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions) | `zsh-autosuggestions` | 历史命令建议 |

---

## Komorebi — 平铺窗口管理器

### 依赖

```powershell
winget install LGUG2Z.komorebi    # 窗口管理器 + 状态栏
winget install LGUG2Z.whkd        # 快捷键守护进程
```

### komorebi.json — 窗口管理器配置

| 设置 | 值 |
|---|---|
| **布局** | BSP（二叉空间分割） |
| **边框** | 启用，宽 4px，偏移 -1，样式 `Square`（Win10 方角） |
| **间距** | 容器 4px，工作区 4px |
| **动画** | 120ms，EaseInOutSine，60fps |
| **跨屏移动** | Swap（交换） |

#### 工作区（共 7 个）

| 快捷键 | 名称 | 应用绑定 |
|---|---|---|
| `Alt+1` | home | — |
| `Alt+2` | term | — |
| `Alt+3` | code | — |
| `Alt+4` | web | — |
| `Alt+5` | chat | QQ、WeChat |
| `Alt+6` | game | — |
| `Alt+7` | misc | — |

#### 边框颜色

| 状态 | 颜色 | 色值 |
|---|---|---|
| 聚焦 | 蓝 | `#89B4FA` |
| 堆叠 | 粉 | `#F38BA8` |
| 单窗口 | 绿 | `#A6E3A1` |
| 失焦 | 灰 | `#585B70` |

#### 浮动窗口

| 应用 | 规则 |
|---|---|
| 任务管理器 | `Taskmgr.exe` |
| 设置 | `ApplicationFrameHost.exe` + 标题 `设置` |
| 计算器 | `ApplicationFrameHost.exe` + 标题 `Calculator` |
| 截图工具 | `SnippingTool.exe` |
| Steam 弹窗 | `steamwebhelper.exe` + 类 `SDL_app` + 标题开头 `notificationtoasts` |

### komorebi.bar.json — 状态栏

- **字体**：JetBrains Mono
- **主题**：Base16-Ashes，强调色 `Base0D`

#### 左侧组件

| 组件 | 详情 |
|---|---|
| Komorebi | 工作区列表、布局名、当前窗口名（含图标） |

#### 右侧组件

| 组件 | 详情 |
|---|---|
| 媒体 | 启用 |
| 存储 | 启用 |
| 内存 | 启用 |
| 网络 | 启用，仅显示实时活动 |
| 日期 | `DayDateMonthYear` 格式 |
| 时间 | 24 小时制 |
| 电池 | 禁用（台式机） |

#### 启停

```powershell
komorebic bar start
komorebic bar stop
komorebic bar reload-configuration
```

### whkdrc — 快捷键绑定

#### 工作区

| 快捷键 | 操作 |
|---|---|
| `Alt + 1-7` | 切换工作区 |
| `Alt + Shift + 1-7` | 移动窗口到工作区 |
| `Alt + Ctrl + 1-7` | 发送到工作区并跟随 |

#### 焦点 / 移动 / 调整

| 快捷键 | 操作 |
|---|---|
| `Alt + H/J/K/L` | 焦点 左/下/上/右 |
| `Alt + Shift + H/J/K/L` | 移动窗口 |
| `Alt + Ctrl + H/J/K/L` | 调整窗口大小 |
| `Alt + [` / `]` | 循环焦点 上一个/下一个 |
| `Alt + Shift + [` / `]` | 循环堆叠 上一个/下一个 |

#### 布局

| 快捷键 | 操作 |
|---|---|
| `Alt + V` | BSP 布局 |
| `Alt + Shift + V` | 垂直堆叠 |
| `Alt + M` | 切换单窗口 |
| `Alt + F` | 切换浮动 |
| `Alt + Shift + F` | 添加浮动规则 |
| `Alt + X` | 水平翻转布局 |
| `Alt + Shift + X` | 垂直翻转布局 |

#### 窗口 / 其他

| 快捷键 | 操作 |
|---|---|
| `Alt + Return` | 提升窗口 |
| `Alt + Q` | 关闭窗口 |
| `Alt + Shift + Q` | 强制聚焦 |
| `Alt + R` | 重新排列 |
| `Alt + Shift + Space` | 暂停/恢复平铺 |
| `Alt + S` | 保存工作区布局 |
| `Alt + Shift + S` | 加载工作区布局 |

---

## Yazi — 终端文件管理器

### 依赖

```powershell
winget install sxyazi.yazi          # 本体
winget install sharkdp.fd           # fd — 快速搜索
winget install BurntSushi.ripgrep   # rg — 内容搜索
winget install junegunn.fzf         # fzf — 模糊查找
winget install ajeetdsouza.zoxide   # zoxide — 目录跳转
```

### yazi.toml — 通用设置

| 分类 | 设置 |
|---|---|
| **布局** | 三栏（父目录 1 : 当前 4 : 预览 3） |
| **排序** | 按字母排序，目录优先，不区分大小写 |
| **隐藏文件** | 默认隐藏（`.` 切换） |
| **编辑器** | Windows 用 `zed`，Unix 用 `$EDITOR` |
| **预览** | 最大 600×900px，不换行，catmull-rom 缩放 |
| **鼠标** | 点击、滚动、拖拽 |

### keymap.toml — 快捷键

#### 导航

| 按键 | 操作 |
|---|---|
| `j` / `k` | 下 / 上 |
| `h` / `l` | 返回上级 / 进入目录 |
| `H` / `L` | 后退 / 前进（历史） |
| `gg` / `G` | 顶部 / 底部 |
| `Ctrl+u` / `Ctrl+d` | 滚动半页 |
| `K` / `J` | 预览区上滚 / 下滚 |

#### 选择

| 按键 | 操作 |
|---|---|
| `Space` | 切换选中 |
| `v` / `V` | 可视模式 / 取消选择模式 |
| `Ctrl+a` | 全选 |
| `Ctrl+r` | 反选 |

#### 文件操作

| 按键 | 操作 |
|---|---|
| `Enter` / `o` | 打开文件 |
| `O` | 选择打开方式 |
| `y` / `x` | 复制 / 剪切 |
| `p` / `P` | 粘贴 / 强制粘贴 |
| `d` / `D` | 回收站 / 永久删除 |
| `a` | 创建文件（以 `/` 结尾则创建目录） |
| `r` | 重命名 |
| `-` / `_` | 符号链接（绝对 / 相对路径） |

#### 搜索与过滤

| 按键 | 操作 |
|---|---|
| `/` / `?` | 向下 / 向上查找 |
| `n` / `N` | 下一个 / 上一个匹配 |
| `f` | 过滤当前目录 |
| `s` | 按文件名搜索（fd） |
| `S` | 按内容搜索（rg） |
| `z` | FZF 快速跳转 |
| `Z` | Zoxide 目录跳转 |

#### 标签页 / 其他

| 按键 | 操作 |
|---|---|
| `1-9` | 切换到标签页 N |
| `[` / `]` | 上一个 / 下一个标签页 |
| `{` / `}` | 左移 / 右移标签页 |
| `tt` | 新建标签页（当前目录） |
| `Tab` | 文件信息 |
| `w` | 任务管理器 |
| `~` / `F1` | 帮助 |
| `q` / `Q` | 退出 / 退出不保存 cwd |
| `:` / `;` | Shell 命令（阻塞 / 异步） |

#### 路径复制

| 按键 | 操作 |
|---|---|
| `cc` | 复制绝对路径 |
| `cd` | 复制目录路径 |
| `cf` | 复制文件名 |
| `cn` | 复制文件名（不含扩展名） |

#### 排序

| 按键 | 排序 |
|---|---|
| `,a` / `,A` | 字母 正序/倒序 |
| `,m` / `,M` | 修改时间 |
| `,b` / `,B` | 创建时间 |
| `,s` / `,S` | 文件大小 |
| `,e` / `,E` | 扩展名 |
| `,n` / `,N` | 自然排序 |
| `,r` | 随机 |

### theme.toml — 主题配色

- **当前目录**：青绿 (`#81c8be`)，**目录图标**：蓝 (`#7da6d9`)
- **可执行文件**：绿，**图片**：黄，**媒体**：紫 (`#c4a0d4`)
- **压缩包**：红，**文档**：青绿
- **标签栏**：蓝激活/灰未激活，圆角分隔符
- **Which-key 面板**：三列，紫色描述

### vfs.toml — 虚拟文件系统

```toml
[services.my-server]
type = "sftp"
host = "1.2.3.4"
user = "root"
port = 22
```

通过 `yazi sftp://my-server` 访问。

---

## Music — Ableton Live / SMK25 II

### 依赖

- Ableton Live
- SMK25 II MIDI 控制器 + USB 连接
- [MIDI Keyboard Center](https://m-audio.com/support/downloads)（可选，用于加载 .mkcII 预设）

### UserConfiguration.txt

放入 Ableton 的 User Remote Scripts 目录：
`Documents\Ableton\User Library\Remote Scripts\SMK25II\`，
然后在 Live → MIDI 设置中选择 `SMK25II` 控制面板。

#### 映射概要

| 分组 | 控制项 | 详情 |
|---|---|---|
| **打击垫** | 16 个 Pad | Note 36-51 |
| **编码器** | 8 个 Encoder | CC 30-37，Absolute 模式 |
| **推子** | 8 个 Volume Slider | CC 38-45 |
| **走带控制** | Play / Stop / Rec / Rwd / Ffwd | CC 54-58 |
| **音轨开关** | Track Arm 1-4 | CC 46-49 |
| **翻页** | Prev / Next bank | CC 59-60 |
| **循环** | Loop | CC 61 |

### mysmk25iiconf.mkcII

SMK25 II 的 MIDI Keyboard Center 预设文件。打开 MIDI Keyboard Center，连接键盘后导入此文件即可将按键映射写入键盘硬件。

---

## 许可

个人配置，随意使用、修改、分享。
