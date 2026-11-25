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

  #v(10pt)
  #highlight-box(title: "核心目标")[
    提出一种*分层任务分解 + 动态并发调度*的协同编排架构，在保证输出质量的前提下显著降低端到端延迟与 Token 开销。
  ]
]

#v(18pt)

#poster-card("2. 系统架构与核心方法")[
  系统由规划器（Planner）、并发执行器（Executor）与状态校验器（Verifier）三部分组成，通过有向无环图（DAG）实现动态调度与闭环反馈：

  #v(10pt)
  #align(center)[
    #cetz.canvas({
      import cetz.draw: *
      rect((0, 0), (4.2, 1.8), fill: rgb("#DBEAFE"), stroke: 1.5pt + rgb("#1E5AA8"), radius: 6pt, name: "planner")
      content("planner", align(center)[*Planner*\ #text(size: 14pt)[DAG 任务拆解]])

      rect((5.4, 0), (9.8, 1.8), fill: rgb("#003B73"), stroke: none, radius: 6pt, name: "exec")
      content("exec", align(center, text(fill: white)[*Executor*\ #text(size: 14pt)[动态并发调度]]))

      rect((11.0, 0), (15.2, 1.8), fill: rgb("#FEF3C7"), stroke: 1.5pt + rgb("#D97706"), radius: 6pt, name: "ver")
      content("ver", align(center)[*Verifier*\ #text(size: 14pt)[闭环断言校验]])

      line("planner.east", "exec.west", mark: (end: ">", fill: black), stroke: 1.8pt)
      line("exec.east", "ver.west", mark: (end: ">", fill: black), stroke: 1.8pt)
      line("ver.south", (13.1, -1.1), (2.1, -1.1), "planner.south", mark: (end: ">", fill: rgb("#D97706")), stroke: (paint: rgb("#D97706"), thickness: 1.5pt, dash: "dashed"))
      content((7.6, -1.6), text(size: 14pt, fill: rgb("#B45309"))[失败局部重规划与状态裁剪])
    })
  ]

  #v(10pt)
  1. *任务规划器*：将复杂目标拆解为带依赖关系的 DAG 子任务。
  2. *并发执行器*：对无依赖节点自动批处理与并行调度。
  3. *状态校验器*：基于运行时反馈进行闭环验证与上下文裁剪。

  $ cal(L)_("total") = alpha dot T_("latency") + beta dot C_("token") + gamma dot (1 - R_("success")) $
]

#colbreak()

#poster-card("3. 实验设计与性能对比")[
  我们在三类典型基准任务上进行了对比测试（基线：单智能体串行执行）：

  #table(
    columns: (1.4fr, 1fr, 1fr, 1fr),
    inset: 10pt,
    align: center + horizon,
    [*方法*], [*成功率*], [*平均耗时*], [*Token 消耗*],
    [Single-Agent], [78.4%], [42.6 s], [18.2k],
    [Static-DAG], [85.1%], [28.3 s], [14.5k],
    [*Ours (Dynamic)*], [*93.6%*], [*16.8 s*], [*11.4k*],
  )

  #v(12pt)
  == 关键指标对比
  #let bar-row(label, pct, val-text, color) = grid(
    columns: (4.8cm, 1fr, 2.4cm),
    gutter: 10pt,
    align: (left + horizon, left + horizon, right + horizon),
    text(size: 16pt, label),
    box(width: 100%, height: 18pt, fill: rgb("#E2E8F0"), radius: 4pt,
      box(width: pct, height: 18pt, fill: color, radius: 4pt)
    ),
    text(size: 16pt, weight: "bold", val-text),
  )
  #bar-row("Single-Agent", 78.4%, "78.4%", rgb("#94A3B8"))
  #v(6pt)
  #bar-row("Static-DAG", 85.1%, "85.1%", rgb("#3B82F6"))
  #v(6pt)
  #bar-row("Ours (Dynamic)", 93.6%, "93.6%", rgb("#003B73"))

  #v(10pt)
  == 关键发现
  - 动态并发调度将端到端耗时降低了 *60.5%*。
  - 局部状态裁剪使上下文 Token 消耗减少 *37.4%*。
]

#v(18pt)

#poster-card("4. 消融实验与误差分析")[
  移除状态校验器后，复杂多步任务的最终成功率下降 *8.2 个百分点*；移除并发批处理后，平均耗时增加 *1.9 倍*。这验证了两个模块在效率与可靠性上的互补性。
]

#colbreak()

#poster-card("5. 总结与未来展望")[
  本文提出的多智能体协同编排方法在多个基准上取得了显著的效率与精度提升。未来工作将聚焦于：
  - 跨异构模型的自适应路由策略；
  - 面向长周期任务的持久化断点恢复机制；
  - 开源工具链与标准化评测基准建设。

  #v(10pt)
  #highlight-box(title: "Take-Home Message")[
    将*结构化 DAG 调度*与*运行时状态裁剪*结合，是突破多智能体系统延迟与上下文瓶颈的有效路径。
  ]
]

#v(18pt)

#poster-card("6. 致谢、参考文献与开源地址")[
  感谢重庆大学计算机学院提供计算资源支持。

  1. Ravomi. *CQUThesis-Typst: Chongqing University Thesis Template for Typst*. GitHub, 2026.
  2. Typst GmbH. *Typst Documentation (v0.14)*. https://typst.app/docs

  #v(12pt)
  #grid(
    columns: (auto, 1fr),
    gutter: 18pt,
    align: horizon,
    box(fill: white, stroke: 1pt + rgb("#CBD5E1"), radius: 6pt, inset: 8pt,
      tiaoma.qrcode("https://github.com/Ravomi/CQUThesis-Typst", width: 3.4cm)
    ),
    [
      *扫码获取模板源码与文档*\
      #text(size: 16pt, fill: rgb("#4B5563"))[
        GitHub: `Ravomi/CQUThesis-Typst`\
        包含学位论文、学术海报与幻灯片模板
      ]
    ],
  )
]
