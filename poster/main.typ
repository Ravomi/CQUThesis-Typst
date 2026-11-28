#import "cquposter.typ": cquposter, poster-card, highlight-box, stat-card, kpi-row, formula-box, ref-list

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
  contact: "zhangsan@cqu.edu.cn  ·  github.com/Ravomi/CQUThesis-Typst",
  footer-left: "重庆大学计算机学院 · College of Computer Science, CQU",
  footer-right: "2026 Academic Poster · Powered by Typst",
)

// ==================== 第一栏 ====================

#poster-card("研究背景与动机", number: "01")[
  随着大语言模型（LLM）与自动化工具链的快速发展，复杂科研与工程任务往往需要多个专业化智能体协同完成。然而，现有编排框架普遍面临三大核心瓶颈：
  - *上下文膨胀*：多轮工具调用与历史日志累积导致上下文窗口迅速耗尽，推理精度显著退化。
  - *串行瓶颈*：相互独立的子任务未能充分并发调度，端到端响应延迟居高不下。
  - *缺乏容错*：局部步骤执行失败时缺少状态校验与局部重试机制，易引发级联错误。

  #v(18pt)
  #highlight-box(title: "核心研究目标")[
    提出一种*分层任务分解 + 动态并发调度*的协同编排架构，在保证复杂任务最终准确率的前提下，显著降低端到端延迟与 Token 开销。
  ]
]

#v(28pt)

#poster-card("方法架构与核心机制", number: "02")[
  // 纯 Typst 矢量架构流程图
  #block(
    width: 100%,
    fill: rgb("#F8FAFC"),
    stroke: 1.2pt + rgb("#CBD8E8"),
    radius: 10pt,
    inset: (x: 20pt, y: 20pt),
    [
      #align(center, text(size: 24pt, weight: "bold", fill: rgb("#003B73"), "多智能体协同编排闭环架构"))
      #v(16pt)
      #grid(
        columns: (1fr, auto, 1fr, auto, 1fr),
        gutter: 6pt,
        align: center + horizon,
        rect(width: 100%, fill: rgb("#003B73"), radius: 8pt, inset: 14pt)[
          #text(fill: white, weight: "bold", size: 23pt, "1. Planner")\
          #text(fill: rgb("#DBEAFE"), size: 19pt, "DAG 任务拆解")
        ],
        text(size: 28pt, weight: "bold", fill: rgb("#1E5AA8"), "→"),
        rect(width: 100%, fill: rgb("#1E5AA8"), radius: 8pt, inset: 14pt)[
          #text(fill: white, weight: "bold", size: 23pt, "2. Executor")\
          #text(fill: rgb("#DBEAFE"), size: 19pt, "并发批处理")
        ],
        text(size: 28pt, weight: "bold", fill: rgb("#D97706"), "→"),
        rect(width: 100%, fill: rgb("#D97706"), radius: 8pt, inset: 14pt)[
          #text(fill: white, weight: "bold", size: 23pt, "3. Verifier")\
          #text(fill: rgb("#FEF3C7"), size: 19pt, "闭环断言校验")
        ],
      )
      #v(12pt)
      #align(center)[
        #box(
          fill: rgb("#FEF3C7"),
          stroke: 1pt + rgb("#D97706"),
          radius: 6pt,
          inset: (x: 16pt, y: 8pt),
          text(size: 19.5pt, fill: rgb("#92400E"), "↺ 局部失败触发精准回退与状态裁剪，避免全流程重算"),
        )
      ]
    ],
  )

  #v(18pt)
  系统由三个紧耦合的核心模块组成：
  1. *任务规划器（Planner）*：基于语义依赖分析，将用户复杂目标动态拆解为有向无环图（DAG）。
  2. *并发执行器（Executor）*：自动识别无前置依赖的就绪节点，进行并发批处理调度与上下文隔离。
  3. *状态校验器（Verifier）*：结合结构化断言与运行时反馈实施闭环验证，支持局部断点重试。

  #v(18pt)
  #formula-box(
    $ cal(L)_("total") = alpha dot T_("latency") + beta dot C_("token") + gamma dot (1 - R_("success")) $,
    caption: [其中 $T_("latency")$ 为端到端耗时，$C_("token")$ 为总上下文开销，$R_("success")$ 为任务最终成功率],
  )
]

#v(32pt)

#poster-card("关键调度策略对比", number: "03")[
  #grid(
    columns: (1fr, 1fr),
    gutter: 16pt,
    highlight-box(title: "传统静态编排")[
      预设固定流水线，无法感知运行时分支变化，单点异常即导致全链路失败。
    ],
    highlight-box(title: "本文动态编排")[
      基于 DAG 拓扑实时重调度，局部失败仅触发受影响子图回退，兼顾吞吐与鲁棒性。
    ],
  )
]

#colbreak()

// ==================== 第二栏 ====================

#poster-card("核心成果总览", number: "04")[
  #kpi-row(
    stat-card("93.6%", "任务成功率", sublabel: "较基线 +15.2%", accent: true),
    stat-card("-60.5%", "端到端耗时", sublabel: "42.6s → 16.8s"),
    stat-card("-37.4%", "Token 消耗", sublabel: "18.2k → 11.4k"),
  )
]

#v(32pt)

#poster-card("实验设计与性能对比", number: "05")[
  我们在三类典型多步推理与工具调用基准任务上进行了对比测试（基线为单智能体串行执行）：

  #v(12pt)
  #block(width: 100%)[
    #set text(size: 24pt)
    #table(
      columns: (1.6fr, 0.9fr, 1.0fr, 1.15fr),
      inset: 12pt,
      align: center + horizon,
      [*编排方法*], [*成功率*], [*平均耗时*], [*Token 消耗*],
      [Single-Agent], [78.4%], [42.6 s], [18.2k],
      [Static-DAG], [85.1%], [28.3 s], [14.5k],
      table.cell(fill: rgb("#FEF3C7"), text(weight: "bold", fill: rgb("#003B73"), [Ours (Dynamic)])),
      table.cell(fill: rgb("#FEF3C7"), text(weight: "bold", fill: rgb("#D97706"), [93.6%])),
      table.cell(fill: rgb("#FEF3C7"), text(weight: "bold", fill: rgb("#003B73"), [16.8 s])),
      table.cell(fill: rgb("#FEF3C7"), text(weight: "bold", fill: rgb("#003B73"), [11.4k])),
    )
  ]

  #v(20pt)
  // 纯 Typst 矢量双指标对比柱状图
  #block(
    width: 100%,
    fill: rgb("#F8FAFC"),
    stroke: 1.2pt + rgb("#CBD8E8"),
    radius: 10pt,
    inset: (x: 20pt, y: 18pt),
    [
      #text(size: 22pt, weight: "bold", fill: rgb("#003B73"), "任务成功率对比（越高越好）")
      #v(12pt)
      #let bar-row(name, pct, val-str, color) = grid(
        columns: (190pt, 1fr, 100pt),
        gutter: 12pt,
        align: horizon,
        text(size: 21pt, weight: "medium", name),
        box(width: 100%, height: 28pt, fill: rgb("#E2E8F0"), radius: 6pt, clip: true)[
          #rect(width: pct * 1%, height: 28pt, fill: color, radius: 6pt)
        ],
        align(right, text(size: 21pt, weight: "bold", fill: color, val-str)),
      )
      #bar-row("Single-Agent", 78.4, "78.4%", rgb("#64748B"))
      #v(9pt)
      #bar-row("Static-DAG", 85.1, "85.1%", rgb("#1E5AA8"))
      #v(9pt)
      #bar-row("Ours (Dynamic)", 93.6, "93.6%", rgb("#D97706"))

      #v(18pt)
      #text(size: 22pt, weight: "bold", fill: rgb("#003B73"), "端到端平均耗时对比（越低越好）")
      #v(12pt)
      #bar-row("Single-Agent", 100.0, "42.6 s", rgb("#64748B"))
      #v(9pt)
      #bar-row("Static-DAG", 66.4, "28.3 s", rgb("#1E5AA8"))
      #v(9pt)
      #bar-row("Ours (Dynamic)", 39.4, "16.8 s", rgb("#D97706"))
    ],
  )

  #v(16pt)
  == 关键发现
  - *并发加速显著*：动态并发调度将端到端平均耗时从 42.6 s 降至 16.8 s（降低 *60.5%*）。
  - *上下文更精简*：局部状态裁剪与按需注入使 Token 消耗减少 *37.4%*。
]

#v(32pt)

#poster-card("消融实验分析", number: "06")[
  分别移除状态校验器与并发批处理模块，验证各组件贡献：
  #v(12pt)
  #grid(
    columns: (1fr, 1fr),
    gutter: 14pt,
    highlight-box(title: "移除 Verifier")[
      最终成功率由 93.6% 降至 *85.4%*（*-8.2%*），验证闭环校验对抑制级联错误的作用。
    ],
    highlight-box(title: "移除 Batching")[
      平均端到端耗时增至 *1.9×*（31.9 s），表明无依赖子图并行调度是降延迟的关键。
    ],
  )
]

#colbreak()

// ==================== 第三栏 ====================

#poster-card("执行轨迹甘特对比", number: "07")[
  以包含 5 个子任务的典型文献调研与代码验证工作流为例，按真实时间比例尺对比串行与动态并发时序：
  #v(14pt)
  #block(
    width: 100%,
    fill: rgb("#F8FAFC"),
    stroke: 1.2pt + rgb("#CBD8E8"),
    radius: 10pt,
    inset: (x: 20pt, y: 18pt),
    [
      #text(size: 21pt, weight: "bold", fill: rgb("#475569"), "传统串行执行（总耗时 42.6 s · 100%）")
      #v(8pt)
      #grid(
        columns: (1fr, 1.1fr, 1fr, 1.2fr, 0.9fr),
        gutter: 4pt,
        rect(width: 100%, height: 34pt, fill: rgb("#94A3B8"), radius: 5pt, align(center + horizon, text(fill: white, size: 18pt, "T1 检索"))),
        rect(width: 100%, height: 34pt, fill: rgb("#94A3B8"), radius: 5pt, align(center + horizon, text(fill: white, size: 18pt, "T2 解析"))),
        rect(width: 100%, height: 34pt, fill: rgb("#94A3B8"), radius: 5pt, align(center + horizon, text(fill: white, size: 18pt, "T3 编码"))),
        rect(width: 100%, height: 34pt, fill: rgb("#94A3B8"), radius: 5pt, align(center + horizon, text(fill: white, size: 18pt, "T4 测试"))),
        rect(width: 100%, height: 34pt, fill: rgb("#64748B"), radius: 5pt, align(center + horizon, text(fill: white, size: 18pt, "汇总"))),
      )
      #v(18pt)
      #text(size: 21pt, weight: "bold", fill: rgb("#003B73"), "Ours 动态并发调度（总耗时 16.8 s · 39.4%，提速 2.54×）")
      #v(8pt)
      #grid(
        columns: (39.4%, 1fr),
        gutter: 8pt,
        align: horizon,
        grid(
          columns: (0.8fr, 1.4fr, 0.8fr),
          gutter: 4pt,
          rect(width: 100%, height: 72pt, fill: rgb("#003B73"), radius: 5pt, align(center + horizon, text(fill: white, size: 17pt, "DAG\n规划"))),
          stack(
            spacing: 4pt,
            rect(width: 100%, height: 34pt, fill: rgb("#1E5AA8"), radius: 5pt, align(center + horizon, text(fill: white, size: 16.5pt, "T1 // T2"))),
            rect(width: 100%, height: 34pt, fill: rgb("#1E5AA8"), radius: 5pt, align(center + horizon, text(fill: white, size: 16.5pt, "T3 // T4"))),
          ),
          rect(width: 100%, height: 72pt, fill: rgb("#D97706"), radius: 5pt, align(center + horizon, text(fill: white, size: 17pt, "闭环\n校验"))),
        ),
        rect(
          width: 100%,
          height: 72pt,
          fill: rgb("#FEF3C7"),
          stroke: (dash: "dashed", paint: rgb("#D97706"), thickness: 1.5pt),
          radius: 5pt,
          align(center + horizon, text(size: 20pt, weight: "bold", fill: rgb("#B45309"), "节省 25.8 s (-60.5%)")),
        ),
      )
      #v(10pt)
      // 时间刻度标尺
      #line(length: 100%, stroke: 1.2pt + rgb("#94A3B8"))
      #v(4pt)
      #grid(
        columns: (39.4%, 1fr),
        text(size: 17pt, fill: rgb("#64748B"), "0 s"),
        grid(
          columns: (1fr, 1fr),
          text(size: 17pt, weight: "bold", fill: rgb("#003B73"), "16.8 s"),
          align(right, text(size: 17pt, fill: rgb("#64748B"), "42.6 s")),
        ),
      )
    ],
  )
]

#v(32pt)

#poster-card("总结与未来展望", number: "08")[
  本文面向多智能体复杂工作流，提出了兼具高并发效率与强闭环可靠性的动态编排方案，在多个基准任务上显著超越现有基线。未来工作将聚焦于：
  - *异构模型自适应路由*：依据节点难度动态匹配轻量级与高推理模型，进一步优化成本。
  - *长周期持久化断点恢复*：支持跨会话状态快照与分钟级以上异步工具链编排。
  - *开源工具链与基准建设*：发布标准化多智能体协同评测套件与可视化调试面板。
]

#v(32pt)

#poster-card("致谢与参考文献", number: "09")[
  感谢重庆大学计算机学院及信息物理社会可信服务计算教育部重点实验室提供计算资源支持。

  #v(12pt)
  #ref-list[
    1. Ravomi. *CQUThesis-Typst: Chongqing University Thesis Template for Typst*. GitHub, 2026.
    2. Typst GmbH. *Typst Documentation (v0.14)*. #link("https://typst.app/docs")[typst.app/docs]
    3. Wu Q, et al. *AutoGen: Enabling Next-Gen LLM Applications via Multi-Agent Conversation*. ICLR, 2024.
  ]
]
