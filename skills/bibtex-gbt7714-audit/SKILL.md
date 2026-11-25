---
name: bibtex-gbt7714-audit
description: 依据 GB/T 7714—2015 顺序编码制规范校验 BibTeX（refs.bib）条目完整性、重复 key、作者格式与正文引用一致性。
---

# GB/T 7714—2015 参考文献与 BibTeX 校验

## 校验步骤
1. **必填字段检查**：
   - `@article`：`author`, `title`, `journal`, `year`, `volume`, `number`, `pages`
   - `@inproceedings`：`author`, `title`, `booktitle`, `year`, `pages`
   - `@book`：`author`, `title`, `publisher`, `year`, `address`
2. **格式规范**：
   - 英文文献标题中的专有名词与缩写（如 `{Typst}`, `{CQU}`, `{DAG}`）用花括号保护大小写。
   - 多位作者之间统一使用 `and` 分隔，避免混用逗号或分号。
   - 检查是否存在重复的 citation key 或未在正文引用的孤立条目。
3. **正文引用**：
   - Typst 中使用 `@key` 引用，编译后检查参考文献页是否按正文首次出现顺序编号（`[1]`, `[2]`, ...）。
