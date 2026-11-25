= 绪论

== 欢迎！

欢迎来到 CQUThesis-Typst 示例文档！

本文档使用 `cquthesis.typ` 作为模板，旨在展现 CQUThesis-Typst 的使用方法。祝毕设成功，答辩拿优！

== 关于 Typst 与 LaTeX

提示：下面是一些基本思路和知识，如果你已经对 Typst 比较熟悉，请直接跳转到第 3 章。

=== 为什么选择 Typst

Typst 是一套现代化的开源排版系统，与传统 LaTeX 一样遵循 *内容与样式分离*（所想即所得）的理念，但拥有更简洁的标记语法、原生 UTF-8 与现代字体支持，以及毫秒级的增量编译速度。

=== CQUThesis-Typst 背后的思路

出于性能和管理方面的考虑，CQUThesis-Typst 采用分布式的源文件方案，将论文的各个部分（通常以章为单位）分散到 `.typ` 文件中，然后在主文档 `main.typ` 中统一引入。@fig-filetree 展示了一个典型的文件目录结构。

#figure(
  block(
    fill: luma(248),
    inset: 10pt,
    radius: 4pt,
    stroke: 0.5pt + luma(200),
    align(left)[
      ```
      CQUThesis-Typst/
      ├── cquthesis.typ          # 核心模板库
      ├── main.typ               # 论文主文件
      ├── contents/              # 各章节正文
      │   ├── introduction.typ
      │   ├── experiment.typ
      │   ├── analysis.typ
      │   ├── conclusion.typ
      │   ├── denotation.typ
      │   └── ack.typ
      ├── figures/               # 图片资源
      │   └── CQUbadge.png
      └── ref/
          └── refs.bib           # 参考文献库
      ```
    ],
  ),
  caption: [CQUThesis-Typst 文件结构图示],
) <fig-filetree>
