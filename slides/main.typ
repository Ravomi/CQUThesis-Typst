#import "cquslides.typ": cquslides, title-slide, section-slide, slide, two-col

#show: cquslides.with(footer: "重庆大学计算机学院 · 多智能体协同编排汇报")

#title-slide(
  title: "基于多智能体协同的工作流编排优化技术研究",
  subtitle: "Multi-Agent Collaborative Workflow Orchestration Optimization",
  author: "张三",
  affiliation: "重庆大学计算机学院",
  date: "2026年5月",
)

#section-slide("01", "研究背景与核心方法")

#slide("研究动机与系统架构")[
  #two-col(
    [
      *现有痛点*
      - 上下文膨胀：多轮工具调用导致 Token 成本高。
      - 串行瓶颈：独立子任务未充分并行。
      - 缺乏容错：局部失败难以自动回退。
    ],
    [
      *本文方案*
      1. *Planner*：将任务拆解为带依赖的 DAG。
      2. *Executor*：无依赖节点自动并发批处理。
      3. *Verifier*：基于运行时反馈闭环校验。
    ],
  )
]

#slide("实验结果对比")[
  #table(
    columns: (1.5fr, 1fr, 1fr, 1fr),
    inset: 10pt,
    align: center + horizon,
    [*方法*], [*成功率*], [*平均耗时*], [*Token 消耗*],
    [Single-Agent], [78.4%], [42.6 s], [18.2k],
    [Static-DAG], [85.1%], [28.3 s], [14.5k],
    [*Ours (Dynamic)*], [*93.6%*], [*16.8 s*], [*11.4k*],
  )
  #v(12pt)
  - 端到端耗时降低 *60.5%*，上下文 Token 消耗减少 *37.4%*。
]
