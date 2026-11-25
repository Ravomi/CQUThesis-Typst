#import "../cquthesis.typ": three-line-table, definition, theorem, proof, algorithm

= 系统设计与实验分析

== 问题建模

#definition(title: "任务依赖图")[
  设工作流任务集合为 $V = {v_1, v_2, dots, v_n}$，任务依赖关系构成有向无环图 $G = (V, E)$。
]

整体目标为最小化总完成时间：

$ T_"total" = max_(v_i in V) (t_"start"(v_i) + t_"exec"(v_i)) $

#theorem(title: "关键路径下界")[
  任意可行调度方案的总完成时间均不小于有向无环图 $G$ 的关键路径长度 $L_"cp"$。
]

#proof[
  由依赖约束可知，关键路径上相邻任务不可并行执行，故其总耗时之和构成 $T_"total"$ 的紧下界。
]

#algorithm(
  title: "动态反馈工作流编排算法",
  input: [任务依赖图 $G = (V, E)$，可用智能体集合 $A$],
  output: [最优调度方案 $S^*$],
)[
  1. 计算所有节点的拓扑序与最早开始时间；
  2. *while* 存在未完成任务 *do*
  3. #h(1.5em) 选取就绪队列中关键路径权重最大的任务分配给空闲智能体；
  4. #h(1.5em) 根据实时执行反馈动态更新剩余节点耗时估计；
  5. *return* 调度方案 $S^*$。
]

== 性能对比

如 @tab-perf 所示，本文方法在平均耗时与成功率上均优于基线策略。

#figure(
  three-line-table(
    columns: 4,
    align: (left, center, center, center),
    [*策略名称*], [*平均耗时 (s)*], [*成功率 (%)*], [*通信开销*],
    [静态串行编排], [42.5], [88.0], [低],
    [动态并行编排], [18.2], [95.4], [中],
    [*本文优化方法*], [*12.6*], [*98.2*], [中],
  ),
  caption: [不同工作流编排策略性能对比],
) <tab-perf>

#figure(
  image("../figures/CQUbadge.png", width: 3cm),
  caption: [重庆大学校徽示例插图],
) <fig-badge>
