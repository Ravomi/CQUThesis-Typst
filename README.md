# CQUThesis-Typst：重庆大学毕业论文 Typst 模板（2026）

[![Build Typst Thesis](https://github.com/Ravomi/CQUThesis-Typst/actions/workflows/build.yml/badge.svg)](https://github.com/Ravomi/CQUThesis-Typst/actions/workflows/build.yml)
[![Typst](https://img.shields.io/badge/Typst-0.14%2B-239DAD?logo=typst&logoColor=white)](https://typst.app/)
[![GitHub repo](https://img.shields.io/badge/GitHub-CQUThesis--Typst-181717?logo=github)](https://github.com/Ravomi/CQUThesis-Typst)
[![License](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

**CQUThesis-Typst** 表示的是 **C**hong**Q**ing **U**niversity **Thesis** (**Typst** Edition)。

本模板是重庆大学毕业论文的 **Typst** 模板，支持学士、硕士、博士以及国际生英文论文的排版，旨在以更简洁的标记语法和毫秒级编译速度减轻毕业论文撰写过程中的排版工作量。

CQUThesis-Typst 根据重庆大学现行《重庆大学博士、硕士学位论文格式标准（2023年修订）》与《重庆大学本科毕业设计（论文）撰写规范化要求》编写，力求合规、简洁、易于实现、用户友好。

# 模板特色

* 支持重庆大学**本科**（`bachelor`）、**硕士**（学术型与专业型 `professional-master`）、**博士**（`doctor`）的毕业论文格式；
* 支持**中文论文**（`lang: "zh"`）与**国际生/英文论文**（`lang: "en"`，保留重庆大学要求的中文封面与授权书）；
* 内置封面、英文题名页、中英文摘要、目录、插图索引、表格索引、符号说明、致谢、附录、原创性声明与版权使用授权书，可按需自动生成；
* 支持**盲审模式**（`blind-trial: true`）：自动隐去封面作者/学号/导师信息，并自动省略致谢页与原创性声明/版权授权书；
* 支持**单面/双面打印**（`print-mode: "oneside" | "twoside"`），双面模式下每章自动从奇数页开启；
* 预置三线表辅助函数（`three-line-table`）及 `GB/T 7714—2015` 顺序编码制参考文献支持；
* 内置社区精选的 AI 论文写作与 Typst 排版项目级 Skills（[`.agents/skills/`](.agents/skills/)，打开仓库即可被 Claude Code / Codex / Cursor / Pi / Antigravity 自动加载）。

![CQUThesis-Typst 排版预览](figures/poster.png)

## 学术海报模板（`poster/`）

仓库同时内置了基于重庆大学视觉规范的学术海报 Typst 模板（[poster/](poster/)），支持 A0/A1/A2、横竖版、多栏卡片布局与双主题配色：

```bash
cd poster
typst compile main.typ poster.pdf
typst compile --format png --ppi 100 main.typ figures/preview.png
```

详细配置说明与组件用法请见 [poster/README.md](poster/README.md)。

![CQUPoster-Typst 海报预览](poster/figures/preview.png?v=4)

## 学术幻灯片模板（`slides/`）

仓库同时内置了 16:9 宽屏、零外部依赖的重庆大学学术幻灯片模板（[slides/](slides/)），支持标题页、章节过渡页、标准内容页与双栏布局：

```bash
cd slides
typst compile main.typ slides.pdf
typst compile --format png --ppi 120 main.typ "figures/preview-{p}.png"
```

![CQUSlides-Typst 首页预览](slides/figures/preview-1.png?v=3)

# 用户协议

1. 本模板按照 [MIT License](https://opensource.org/licenses/MIT) 开源发布；
2. 截止本文档编辑时，重庆大学教务处和研究生院只提供了毕业论文写作指南，没有提供官方模板，也没有授权或认证任何第三方模板为官方模板。本模板是按照写作指南的参考实现，模板作者自当尽力，但不保证审查老师不提意见。在开始使用前，您同意，任何由于本模板而引起的论文格式审查问题与本模板作者无关。

# 获取与部署

## 下载

| 版本 | 下载地址 | 描述 |
| --- | --- | --- |
| 开发版 | [GitHub 仓库（main 分支）](https://github.com/Ravomi/CQUThesis-Typst) | 推荐，最新的 2026 规范适配与 BugFix |
| ZIP 压缩包 | [点我下载 ZIP](https://github.com/Ravomi/CQUThesis-Typst/archive/refs/heads/main.zip) | 无需 Git，解压即用 |

```bash
git clone https://github.com/Ravomi/CQUThesis-Typst.git
cd CQUThesis-Typst
```

## 环境配置方案

### 1. 安装 Typst 编译器

无需安装庞大的 TeX Live，仅需安装 [Typst](https://github.com/typst/typst)（推荐 `0.14+`）：

- **macOS (Homebrew)**：
  ```bash
  brew install typst
  ```
- **Windows (Winget)**：
  ```powershell
  winget install --id Typst.Typst
  ```
- **Linux (Arch / Cargo)**：
  ```bash
  sudo pacman -S typst
  # 或 cargo install --locked typst-cli
  ```

推荐使用 VS Code 搭配 **Tinymist Typst** 插件，可获得语法高亮、跳转与实时 PDF 预览。

### 2. 字体配置（思源宋体）

本仓库三套模板（论文、海报、幻灯片）均默认优先使用**思源宋体（Source Han Serif）**作为中文正文字体（兼容 `Noto Serif CJK SC` / `SimSun`），英文与数字搭配 `Times New Roman` / `Liberation Serif`，标题搭配**思源黑体（Source Han Sans）**。

- **官方下载（Windows / macOS / Linux 通用）**：
  前往 [adobe-fonts/source-han-serif Releases](https://github.com/adobe-fonts/source-han-serif/releases) 与 [adobe-fonts/source-han-sans Releases](https://github.com/adobe-fonts/source-han-sans/releases) 下载简体中文版（`SubsetOTF/CN` 或 `OTC`），解压安装即可。
- **Linux 包管理器快速安装**：
  ```bash
  # Arch Linux / CachyOS
  sudo pacman -S adobe-source-han-serif-cn-fonts adobe-source-han-sans-cn-fonts

  # Ubuntu / Debian（同源 Noto CJK 字体）
  sudo apt update && sudo apt install -y fonts-noto-cjk
  ```
- **验证字体是否生效**：
  ```bash
  typst fonts | grep -i "Source Han"
  ```
  若字体放置在项目 `fonts/` 目录或自定义路径下，编译时可附加 `--font-path fonts`：
  ```bash
  typst compile --font-path fonts main.typ
  ```

## 编译

```bash
# 单次编译生成 main.pdf
typst compile main.typ

# 实时监听文件改动并毫秒级增量编译
typst watch main.typ

# 或使用 Makefile（支持一键生成盲审版 main-blind.pdf）：
make        # 编译 main.pdf
make blind  # 一键生成盲审版 main-blind.pdf
make clean  # 清理生成文件
```

## 学位类型与模式配置

在 [`main.typ`](main.typ) 顶部修改 `#show: cquthesis.with(...)` 参数即可切换学位类型与模式：

| 模式 | `main.typ` 配置参数 |
| --- | --- |
| 学术型硕士（默认） | `thesis-type: "master", professional-master: false` |
| 专业型硕士 | `thesis-type: "master", professional-master: true` |
| 博士学位论文 | `thesis-type: "doctor"` |
| 本科毕业论文（设计） | `thesis-type: "bachelor"` |
| 国际生/英文论文 | `lang: "en"` |
| 双面打印 | `print-mode: "twoside"` |
| 盲审模式 | `blind-trial: true` |

# 目录结构

```text
CQUThesis-Typst/
├── cquthesis.typ          # 核心模板库
├── main.typ               # 论文主文件（配置封面信息、摘要与章节引入）
├── contents/              # 各章节正文
│   ├── introduction.typ   # 绪论
│   ├── experiment.typ     # 实验参数和流程
│   ├── analysis.typ       # 系统设计与实验分析
│   ├── conclusion.typ     # 结论
│   ├── denotation.typ     # 符号与缩略语说明
│   └── ack.typ            # 致谢
├── figures/               # 图片资源（含重庆大学校徽 CQUbadge.png 与预览图）
├── ref/
│   └── refs.bib           # BibTeX 参考文献库
└── .agents/skills/        # 项目级社区 Agent Skills（自动发现）
    ├── typst/                 # Typst 0.14.2 完整排版与 API 索引 (lucifer1004/claude-skill-typst)
    ├── research-paper-writing/# 学术论文写作与结构规范 (Master-cai/Research-Paper-Writing-Skills)
    └── sciwrite/              # 科学写作与审稿润色 (labarba/sciwrite)
```

# AI 论文写作 Skills（项目级安装）

本仓库已在 [`.agents/skills/`](.agents/skills/) 中预装 3 个社区高星开源 Agent Skills，使用 Claude Code / Codex / Cursor / Pi / Antigravity 打开本项目即可自动加载：

| Skill | 来源仓库 | 用途 |
| --- | --- | --- |
| `typst` | [lucifer1004/claude-skill-typst](https://github.com/lucifer1004/claude-skill-typst) | Typst 0.14.2 语法、样式、表格、学术排版与完整 API 索引 |
| `research-paper-writing` | [Master-cai/Research-Paper-Writing-Skills](https://github.com/Master-cai/Research-Paper-Writing-Skills) | 学术论文结构、论证对齐与投稿前呈现检查 |
| `sciwrite` | [labarba/sciwrite](https://github.com/labarba/sciwrite) | 基于 *Writing in the Sciences* 方法论的论文润色与多轮审稿 |

# 提问和支持

* [GitHub Issues](https://github.com/Ravomi/CQUThesis-Typst/issues)

# 致谢 / Acknowledgements

感谢 [Typst](https://github.com/typst/typst) 开源社区及所有为重庆大学学位论文排版规范做出贡献的开发者：

- **Original upstream**: [nanmu42/CQUThesis](https://github.com/nanmu42/CQUThesis) by Zhennan Li and contributors
- **Modified community baseline**: [yinguoweiOvO/CQU_Thesis2024](https://github.com/yinguoweiOvO/CQU_Thesis2024)
- **International adaptation**: [mishaown/CQUThesis-International-2026](https://github.com/mishaown/CQUThesis-International-2026) by Md Minhazul Islam
- **Full credit and lineage**: [ACKNOWLEDGMENTS.md](ACKNOWLEDGMENTS.md)

世界因你们更美好。

# 论文写作规范（2026 现行参考）

- 《重庆大学博士、硕士学位论文格式标准（2023年修订）》— 请前往 [重庆大学研究生院官网](https://graduate.cqu.edu.cn)「学位工作 / 办事指南」获取最新附件
- 《重庆大学本科毕业设计（论文）撰写规范化要求》— 请前往 [重庆大学本科生院（教务处）官网](https://jwc.cqu.edu.cn) 或所在学院下载专区获取当年最新模板与细则
- 《GB/T 7714—2015 信息与文献 参考文献著录规则》— 可于 [国家标准全文公开系统](https://openstd.samr.gov.cn) 查阅原文

# About CQUThesis-Typst

CQUThesis-Typst stands for Chongqing University Thesis Template for Typst, bearing the ability to support bachelor, master, doctor, and international dissertations with grace and speed.
