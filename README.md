# CQUThesis-Typst

重庆大学学位论文 **Typst** 模板，参考并转换自 [nanmu42/CQUThesis](https://github.com/nanmu42/CQUThesis)（LaTeX）。

## 特性

- 支持 **本科（`bachelor`）**、**硕士（`master`，含学术型与专业型 `professional-master`）**、**博士（`doctor`）**
- 支持 **盲审模式（`blind-trial: true`）**，自动隐藏作者、学号、导师与致谢信息
- 完整包含：封面、英文题名页、中英文摘要、目录、插图索引、表格索引、符号说明、三线表（`three-line-table`）、GB/T 7714-2015 参考文献、致谢、附录、原创性声明与版权使用授权书

## 快速开始

确保已安装 Typst（推荐 0.14+）：

```bash
typst compile main.typ
# 或实时监听编译：
typst watch main.typ
```

## 目录结构

- `cquthesis.typ`：核心模板库
- `main.typ`：论文主文件（配置封面信息、摘要与章节引入）
- `contents/`：各章节正文文件
- `figures/`：图片资源（含重庆大学校徽 `CQUbadge.png`）
- `ref/refs.bib`：BibTeX 参考文献库
