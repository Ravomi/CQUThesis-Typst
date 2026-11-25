---
name: cqu-thesis-typst
description: 重庆大学学位论文 Typst 模板（CQUThesis-Typst）排版、格式自检与盲审检查。当编辑 main.typ、cquthesis.typ 或各章节 .typ 文件时使用。
---

# 重庆大学 Typst 学位论文排版规范

## 核心检查清单

1. **学位类型与模式**：检查 `main.typ` 中的 `thesis-type`（`bachelor` / `master` / `doctor`）、`professional-master`、`lang`（`zh` / `en`）、`print-mode`（`oneside` / `twoside`）是否与提交要求一致。
2. **盲审自检**：开启 `blind-trial: true` 后，编译 PDF 并用 `pdftotext` 检查全文是否已彻底隐去作者姓名、学号、导师姓名、致谢与授权书页。
3. **链接与语法**：Typst 中插入超链接必须使用 `#link("https://...")`，不要写成 Markdown 语法 `[text](url)`；水平间距使用 `#h(2em)`，不要使用 LaTeX 的 `\quad`。
4. **编译与视觉验收**：每次修改后必须运行 `typst compile main.typ`，并检查页眉章节标题、目录页码、参考文献列表与三线表渲染无误。
