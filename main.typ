#import "cquthesis.typ": cquthesis, three-line-table

#show: cquthesis.with(
  thesis-type: "master", // 可选: "bachelor" | "master" | "doctor"
  professional-master: false, // 仅 master 有效
  blind-trial: false, // 盲审模式
  title: "面向多智能体协同的工作流编排优化技术研究",
  title-en: "Research on Workflow Orchestration Optimization for Multi-Agent Collaboration",
  author: "王阳",
  student-id: "2023000001",
  college: "计算机学院",
  major: "计算机科学与技术",
  supervisor: "导师姓名 教授",
  date: "2026年5月",
  date-en: "May, 2026",
  abstract-cn: [
    本文基于重庆大学学位论文格式规范，使用 Typst 排版引擎实现了 `CQUThesis` 模板。模板支持本科、学术型硕士、专业型硕士及博士学位论文，内置封面、中英文题名页、中英文摘要、目录、插图索引、表格索引、符号说明、三线表、GB/T 7714 参考文献、致谢与原创性声明等完整部件。
  ],
  keywords-cn: ("重庆大学", "学位论文", "Typst", "多智能体协同"),
  abstract-en: [
    This template implements the Chongqing University thesis format specification using the Typst typesetting system. It supports bachelor's, academic master's, professional master's, and doctoral dissertations, including cover pages, bilingual abstracts, tables of contents, lists of figures and tables, GB/T 7714 bibliography, acknowledgments, and originality declaration.
  ],
  keywords-en: ("Chongqing University", "Thesis Template", "Typst", "Multi-Agent Collaboration"),
  denotation: include "contents/denotation.typ",
  ack: include "contents/ack.typ",
  appendix-content: [
    = 攻读学位期间发表的学术论文及科研成果
    1. 示例论文，2026 年。
  ],
  bib-file: "ref/refs.bib",
)

#include "contents/introduction.typ"
#include "contents/experiment.typ"
#include "contents/analysis.typ"
#include "contents/conclusion.typ"
