#import "../cquthesis.typ": three-line-table

= 系统设计与实验分析

== 问题建模

设工作流任务集合为 $V = {v_1, v_2, dots, v_n}$，任务依赖关系构成有向无环图 $G = (V, E)$。整体目标为最小化总完成时间：

$ T_"total" = max_(v_i in V) (t_"start"(v_i) + t_"exec"(v_i)) $

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
