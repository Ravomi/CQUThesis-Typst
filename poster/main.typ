#import "cquposter.typ": cquposter, poster-card, highlight-box
#import "@preview/cetz:0.3.4"
#import "@preview/tiaoma:0.3.0"

#show: cquposter.with(
  paper: "a0",
  landscape: false,
  columns-count: 3,
  theme-name: "cqu-blue",
  lang: "zh",
  title: "基于多智能体协同的工作流编排优化技术研究",
  subtitle: "Multi-Agent Collaborative Workflow Orchestration Optimization",
  authors: "张三¹*, 李四¹, 王五²",
  affiliations: "¹重庆大学计算机学院   ²信息物理社会可信服务计算教育部重点实验室",
  contact: "zhangsan@cqu.edu.cn | https://github.com/Ravomi/CQUThesis-Typst",
  footer-left: "重庆大学计算机学院 · College of Computer Science, CQU",
  footer-right: "2026 Academic Poster · Powered by Typst",
)

#poster-card("1. 研究背景与动机")[
  随着大语言模型（LLM）与自动化工具链的发展，复杂任务往往需要多个专业化智能体协同完成。然而，现有编排框架普遍存在以下痛点：
  - *上下文膨胀*：多轮工具调用导致上下文窗口迅速耗尽，推理成本急剧上升。
  - *串行瓶颈*：独立子任务未能充分并行，端到端响应延迟高。
  - *缺乏容错*：局部步骤失败时难以自动回退、隔离或局部重试。
  - *异构调度难*：不同规模模型（Pro / Flash / Lite）缺乏动态路由策略。

  #v(12pt)
  #highlight-box(title: "核心目标")[
    提出一种*分层任务分解 + 动态并发调度*的协同编排架构，在保证输出质量的前提下显著降低端到端延迟与 Token 开销。
  ]
]

#v(20pt)

#poster-card("2. 系统架构与核心方法")[
  系统由规划器（Planner）、并发执行器（Executor）与状态校验器（Verifier）三部分组成，通过有向无环图（DAG）实现动态调度与闭环反馈：

  #v(14pt)
  #align(center)[
    #cetz.canvas(length: 1.35cm, {
      import cetz.draw: *
      rect((0, 0), (4.6, 2.2), fill: rgb("#DBEAFE"), stroke: 2pt + rgb("#1E5AA8"), radius: 8pt, name: "planner")
      content("planner", align(center)[#text(size: 22pt, weight: "bold")[Planner]\ #v(4pt) #text(size: 16pt)[DAG 任务拆解]])

      rect((5.6, 0), (10.4, 2.2), fill: rgb("#003B73"), stroke: none, radius: 8pt, name: "exec")
      content("exec", align(center, text(fill: white)[#text(size: 22pt, weight: "bold")[Executor]\ #v(4pt) #text(size: 16pt)[动态并发调度]]))

      rect((11.4, 0), (16.0, 2.2), fill: rgb("#FEF3C7"), stroke: 2pt + rgb("#D97706"), radius: 8pt, name: "ver")
      content("ver", align(center)[#text(size: 22pt, weight: "bold")[Verifier]\ #v(4pt) #text(size: 16pt)[闭环断言校验]])

      line("planner.east", "exec.west", mark: (end: ">", fill: black), stroke: 2.2pt)
      line("exec.east", "ver.west", mark: (end: ">", fill: black), stroke: 2.2pt)
      line("ver.south", (13.7, -1.2), (2.3, -1.2), "planner.south", mark: (end: ">", fill: rgb("#D97706")), stroke: (paint: rgb("#D97706"), thickness: 2pt, dash: "dashed"))
      content((8.0, -1.7), text(size: 16pt, weight: "bold", fill: rgb("#B45309"))[失败局部重规划与状态裁剪])
    })
  ]

  #v(14pt)
  1. *任务规划器*：将复杂目标拆解为带依赖关系的 DAG 子任务。
  2. *并发执行器*：对无依赖节点自动批处理与并行调度。
  3. *状态校验器*：基于运行时反馈进行闭环验证与上下文裁剪。

  #v(10pt)
  $ cal(L)_("total") = alpha dot T_("latency") + beta dot C_("token") + gamma dot (1 - R_("success")) $
  $ eta_("parallel") = frac(sum_(i=1)^N t_i, T_("makespan") dot K) $
]

#v(20pt)

#poster-card("3. 典型应用场景")[
  - *科研文献综述*：多 Agent 并行检索 arXiv / PubMed 并交叉验证。
  - *自动化代码重构*：Planner 划分模块，Executor 并发修改与单测。
  - *多模态数据分析*：表格清洗、统计建模与可视化流水线协同。
]

#colbreak()

#poster-card("4. 实验设计与性能对比")[
  我们在三类典型基准任务上进行了对比测试（基线：单智能体串行执行）：

  #table(
    columns: (1.4fr, 1fr, 1fr, 1fr),
    inset: 12pt,
    align: center + horizon,
    [*方法*], [*成功率*], [*平均耗时*], [*Token 消耗*],
    [Single-Agent], [78.4%], [42.6 s], [18.2k],
    [Static-DAG], [85.1%], [28.3 s], [14.5k],
    [AutoGen-Seq], [86.9%], [31.0 s], [16.1k],
    [*Ours (Dynamic)*], [*93.6%*], [*16.8 s*], [*11.4k*],
  )

  #v(14pt)
  == 关键指标对比（成功率）
  #let bar-row(label, pct, val-text, color) = grid(
    columns: (5.2cm, 1fr, 2.6cm),
    gutter: 12pt,
    align: (left + horizon, left + horizon, right + horizon),
    text(size: 18pt, label),
    box(width: 100%, height: 22pt, fill: rgb("#E2E8F0"), radius: 5pt,
      box(width: pct, height: 22pt, fill: color, radius: 5pt)
    ),
    text(size: 18pt, weight: "bold", val-text),
  )
  #bar-row("Single-Agent", 78.4%, "78.4%", rgb("#94A3B8"))
  #v(8pt)
  #bar-row("Static-DAG", 85.1%, "85.1%", rgb("#60A5FA"))
  #v(8pt)
  #bar-row("AutoGen-Seq", 86.9%, "86.9%", rgb("#3B82F6"))
  #v(8pt)
  #bar-row("Ours (Dynamic)", 93.6%, "93.6%", rgb("#003B73"))

  #v(14pt)
  == 并发度与延迟趋势
  #align(center)[
    #cetz.canvas(length: 1.2cm, {
      import cetz.draw: *
      line((0, 0), (14, 0), mark: (end: ">"), stroke: 1.5pt)
      line((0, 0), (0, 4.5), mark: (end: ">"), stroke: 1.5pt)
      content((14.4, 0), text(size: 14pt)[并发数])
      content((0, 4.9), text(size: 14pt)[耗时 (s)])
      line((1, 4.0), (4, 2.8), (7, 1.9), (10, 1.5), (13, 1.4), stroke: 2.5pt + rgb("#003B73"))
      for (x, y, lbl) in ((1, 4.0, "42s"), (4, 2.8, "28s"), (7, 1.9, "19s"), (10, 1.5, "17s"), (13, 1.4, "16s")) {
        circle((x, y), radius: 0.14, fill: rgb("#D97706"), stroke: none)
        content((x, y + 0.45), text(size: 13pt, weight: "bold")[#lbl])
      }
    })
  ]
]

#v(20pt)

#poster-card("5. 消融实验与误差分析")[
  - 移除*状态校验器*后，复杂多步任务的最终成功率下降 *8.2 个百分点*。
  - 移除*并发批处理*后，平均耗时增加 *1.9 倍*。
  - 两者在效率与可靠性上形成显著互补，缺一不可。
]

#v(20pt)

#poster-card("6. 跨模型泛化与鲁棒性")[
  我们在不同基座模型上测试了编排框架的通用性：
  - *Qwen-Max / DeepSeek-V3*：成功率提升 *+14.1%*，平均延迟降低 *58.3%*。
  - *混合异构路由（Pro + Flash）*：在保持 92.8% 成功率的同时，API 成本进一步降低 *41.0%*。
]

#colbreak()

#poster-card("7. 总结与未来展望")[
  本文提出的多智能体协同编排方法在多个基准上取得了显著的效率与精度提升。未来工作将聚焦于：
  - 跨异构模型的自适应路由策略；
  - 面向长周期任务的持久化断点恢复机制；
  - 开源工具链与标准化评测基准建设。

  #v(12pt)
  #highlight-box(title: "Take-Home Message")[
    将*结构化 DAG 调度*与*运行时状态裁剪*结合，是突破多智能体系统延迟与上下文瓶颈的有效路径。
  ]
]

#v(20pt)

#poster-card("8. 开源工具链与快速复现")[
  本模板与实验脚本已全部开源，支持一键编译与自动化测试：
  ```bash
  git clone https://github.com/Ravomi/CQUThesis-Typst.git
  cd CQUThesis-Typst/poster && typst compile main.typ
  ```
  - 支持 *A0 / A1 / A2* 多种展板尺寸与横竖版切换；
  - 内置 *`cqu-blue`* 与 *`academic-slate`* 双主题；
  - 配套 *`typst-academic-poster`* Agent Skill，支持自动排版与视觉验收。
]

#v(20pt)

#poster-card("9. 致谢、参考文献与开源地址")[
  感谢重庆大学计算机学院提供计算资源支持。

  1. Ravomi. *CQUThesis-Typst: Chongqing University Thesis Template for Typst*. GitHub, 2026.
  2. Typst GmbH. *Typst Documentation (v0.14)*. https://typst.app/docs
  3. Vaswani et al. *Attention Is All You Need*. NeurIPS, 2017.

  #v(16pt)
  #grid(
    columns: (auto, 1fr),
    gutter: 20pt,
    align: horizon,
    box(fill: white, stroke: 1.5pt + rgb("#CBD5E1"), radius: 8pt, inset: 10pt,
      tiaoma.qrcode("https://github.com/Ravomi/CQUThesis-Typst", width: 4.2cm)
    ),
    [
      *扫码获取模板源码与文档*\
      #v(6pt)
      #text(size: 18pt, fill: rgb("#4B5563"))[
        GitHub: `Ravomi/CQUThesis-Typst`\
        包含学位论文、学术海报与幻灯片模板
      ]
    ],
  )
]
