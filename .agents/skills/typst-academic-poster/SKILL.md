---
name: typst-academic-poster
description: 使用 Typst 创建、定制、编译并视觉验收学术海报（基于 CQUPoster-Typst / CQUThesis-Typst 规范）。当用户需要制作学术海报、会议 Poster、A0/A1/A2 展板，或将论文/项目内容转化为 Typst 海报时使用。
---

# Typst 学术海报制作 Skill

本 Skill 内置 `CQUPoster-Typst` 模板（位于本 Skill 目录下的 `assets/`），指导 Agent 快速生成结构清晰、排版工整、可直接印刷的学术海报（PDF & PNG 预览）。

## 1. 模板结构（`assets/`）

- `cquposter.typ`：核心样式与组件库
  - `cquposter(...)`：页面尺寸（`a0` / `a1` / `a2`）、横竖版（`landscape`）、栏数（`columns-count: 2 | 3 | 4`）、主题（`cqu-blue` / `academic-slate`）、顶部横幅与底部栏。
  - `poster-card(title, body)`：带标题与边框的内容卡片（自动禁止跨栏截断 `breakable: false`）。
  - `highlight-box(title: none, body)`：结论/核心指标高亮框。
- `main.typ`：海报内容入口，使用 `#colbreak()` 手动控制分栏换列。
- `figures/CQUbadge.png`：校徽资源（可通过 `badge: none` 隐藏或替换为其他图片）。

## 2. 制作流程

1. **初始化工作区**：
   - 将本 Skill 目录下的 `assets/`（包含 `cquposter.typ`、`main.typ`、`typst.toml`、`figures/`）复制到用户的目标输出目录。
2. **确认需求与内容**：
   - 纸张大小（默认 `a0` 竖版 3 栏；横版可设 `landscape: true, columns-count: 3` 或 `4`）。
   - 主题色（`cqu-blue` 或 `academic-slate`）与语言（`zh` / `en`）。
   - 提取论文/项目的核心模块：背景与动机、方法架构、实验对比（表格/图表）、消融/分析、总结与参考文献。
2. **编写 `main.typ`**：
   - 每个独立章节使用 `#poster-card("标题")[ ... ]`。
   - 卡片之间用 `#v(18pt)` 保持间距，栏末使用 `#colbreak()` 切换到下一栏。
   - 避免单栏内容过多导致溢出底部页边距。
3. **编译与视觉验收（必须执行）**：
   - 编译 PDF：`typst compile main.typ poster.pdf`
   - 导出 PNG 预览：`typst compile --format png --ppi 100 main.typ poster.png`
   - 使用 `read` 工具查看 `poster.png`，检查：
     - 是否有文字溢出卡片或超出页面底部；
     - 各栏高度是否大体均衡；
     - 中英文字体、公式、表格是否渲染正常。
   - 若发现溢出或失衡，调整字号、间距或 `#colbreak()` 位置后重新编译并复查。
