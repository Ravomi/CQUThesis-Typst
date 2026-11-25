---
name: typst-basics
description: Typst 现代排版系统完整语法速查与最佳实践（含 LaTeX 对照、数学公式、表格、插图、交叉引用、set/show 规则与常见排错）。当编写、调试或将 LaTeX 迁移到 Typst 文档时使用。
---

# Typst 使用与排版速查指南（0.14+）

## 1. 核心模式切换
- **标记模式（默认）**：直接写正文、`= 一级标题`、`== 二级标题`、`*加粗*`、`_斜体_`、`- 列表`、`+ 编号列表`。
- **脚本模式（`#` 开头）**：调用函数、变量与控制流，如 `#let x = 1`、`#image("a.png", width: 80%)`、`#for i in range(3) [...]`。
- **数学模式（`$ ... $`）**：
  - 行内公式：`$x^2 + y^2 = r^2$`（美元符号紧贴内容，无空格）。
  - 独立公式：`$ sum_(i=1)^n x_i = 0 $`（美元符号内外留空格）。

## 2. LaTeX → Typst 常用对照

| 功能 | LaTeX | Typst |
| --- | --- | --- |
| 标题 | `\section{绪论}` | `= 绪论` |
| 加粗 / 斜体 | `\textbf{粗}` / `\emph{斜}` | `*粗*` / `_斜_` |
| 水平间距 | `\quad` / `\qquad` | `#h(2em)` / `#h(4em)` |
| 垂直间距 | `\vspace{1em}` | `#v(1em)` |
| 超链接 | `\url{https://...}` | `#link("https://...")` |
| 参考文献引用 | `\cite{r1}` | `@r1` |
| 图表交叉引用 | `\ref{fig:a}` | `@fig-a`（配合 `<fig-a>` 标签） |
| 注释 | `% 注释` | `// 单行注释` 或 `/* 多行 */` |

## 3. 样式定制（`set` 与 `show`）
- **`#set`**：修改元素默认参数，如 `#set text(size: 12pt)`、`#set par(leading: 0.9em, first-line-indent: 2em)`。
- **`#show`**：重写特定元素的渲染方式，如：
  ```typst
  #show heading.where(level: 1): it => align(center)[#text(size: 16pt, weight: "bold")[#it]]
  ```
- **`context`**：读取当前页码、计数器或查询标题时必须包裹在 `context { ... }` 中（Typst 0.11+ 规范）。

## 4. 常见坑与排错
1. **Markdown 链接无效**：不要写 `[文本](url)`，必须写 `#link("url")[文本]`。
2. **数学模式中的正体多字母下标**：写 `$T_"total"$`，不要写 `$T_{total}$`。
3. **动态页码/状态查询报错**：报错 `can only be used when context is known` 时，在表达式外层加 `context`。
4. **字体警告**：Linux 下如遇可变字体（variable font）警告，可安装静态版字体并用 `typst compile --font-path fonts main.typ` 编译。
