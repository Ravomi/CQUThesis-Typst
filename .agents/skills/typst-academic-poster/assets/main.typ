#import "cquposter.typ": cquposter, poster-card, highlight-box

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
  - *上下文膨胀*：多轮工具调用导致上下文窗口迅速耗尽。
  - *串行瓶颈*：独立子任务未能充分并行，端到端延迟高。
  - *缺乏容错*：局部步骤失败时难以自动回退或局部重试。

  #v(8pt)
  #highlight-box(title: "核心目标")[
    提出一种*分层任务分解 + 动态并发调度*的协同编排架构，在保证输出质量的前提下显著降低延迟与 Token 开销。
  ]
]

#v(18pt)

#poster-card("2. 方法架构")[
  系统由三个核心模块组成：
  1. *任务规划器（Planner）*：将用户目标拆解为有向无环图（DAG）。
  2. *并发执行器（Executor）*：对无依赖节点自动批处理与并行调度。
  3. *状态校验器（Verifier）*：基于断言与运行时反馈进行闭环验证。

  $ cal(L)_("total") = alpha dot T_("latency") + beta dot C_("token") + gamma dot (1 - R_("success")) $
]

#colbreak()

#poster-card("3. 实验设计与对比")[
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

  #v(10pt)
  == 关键发现
  - 动态并发调度将端到端耗时降低了 *60.5%*。
  - 局部状态裁剪使上下文 Token 消耗减少 *37.4%*。
]

#v(18pt)

#poster-card("4. 消融实验")[
  移除状态校验器后，复杂多步任务的最终成功率下降 8.2 个百分点；移除并发批处理后，平均耗时增加 1.9 倍。这验证了两个模块在效率与可靠性上的互补性。
]

#colbreak()

#poster-card("5. 总结与展望")[
  本文提出的多智能体协同编排方法在多个基准上取得了显著的效率与精度提升。未来工作将聚焦于：
  - 跨异构模型的自适应路由策略；
  - 面向长周期任务的持久化断点恢复机制；
  - 开源工具链与标准化评测基准建设。
]

#v(18pt)

#poster-card("6. 致谢与参考文献")[
  感谢重庆大学计算机学院提供计算资源支持。

  1. Ravomi. *CQUThesis-Typst: Chongqing University Thesis Template for Typst*. GitHub, 2026.
  2. Typst GmbH. *Typst Documentation (v0.14)*. https://typst.app/docs
]
