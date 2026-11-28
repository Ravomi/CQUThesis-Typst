// 重庆大学学术海报 Typst 模板 (CQUPoster-Typst)
// 借鉴 CQUThesis-Typst 的字体与校徽规范，适配 A0/A1/A2 学术海报排版

#let cqu-fonts = (
  song: ("Times New Roman", "Liberation Serif", "Source Han Serif", "Noto Serif CJK SC", "SimSun"),
  hei: ("Liberation Sans", "Source Han Sans", "HarmonyOS Sans SC", "Microsoft YaHei", "SimHei"),
  mono: ("DejaVu Sans Mono", "Consolas", "Courier New"),
)

#let cqu-themes = (
  cqu-blue: (
    primary: rgb("#003B73"),
    primary-deep: rgb("#002247"),
    secondary: rgb("#1E5AA8"),
    accent: rgb("#D97706"),
    accent-soft: rgb("#FEF3C7"),
    bg: rgb("#F0F4F8"),
    card-bg: white,
    border: rgb("#CBD8E8"),
    soft-fill: rgb("#EEF4FB"),
    text: rgb("#1E293B"),
    muted: rgb("#475569"),
  ),
  academic-slate: (
    primary: rgb("#0F172A"),
    primary-deep: rgb("#020617"),
    secondary: rgb("#334155"),
    accent: rgb("#0284C7"),
    accent-soft: rgb("#E0F2FE"),
    bg: rgb("#F1F5F9"),
    card-bg: white,
    border: rgb("#CBD5E1"),
    soft-fill: rgb("#EFF6FF"),
    text: rgb("#0F172A"),
    muted: rgb("#475569"),
  ),
)

#let cqu-paper-scales = (
  a0: 1.0,
  a1: 0.72,
  a2: 0.52,
)

#let poster-theme-state = state("poster-theme", cqu-themes.cqu-blue)
#let poster-scale-state = state("poster-scale", 1.0)

/// 关键数据指标卡片（用于突出核心实验结论或量化提升）
#let stat-card(value, label, sublabel: none, accent: false) = context {
  let theme = poster-theme-state.get()
  let s = poster-scale-state.get()
  let num-color = if accent { theme.accent } else { theme.primary }
  block(
    width: 100%,
    fill: if accent { theme.accent-soft.transparentize(45%) } else { theme.soft-fill },
    stroke: (
      top: (3.5pt * s) + num-color,
      rest: (1pt * s) + theme.border,
    ),
    radius: 8pt * s,
    inset: (x: 16pt * s, y: 18pt * s),
    breakable: false,
    align(center)[
      #text(
        font: cqu-fonts.hei,
        size: 50pt * s,
        weight: "bold",
        fill: num-color,
        value,
      )
      #v(5pt * s)
      #text(
        font: cqu-fonts.hei,
        size: 22pt * s,
        weight: "bold",
        fill: theme.text,
        label,
      )
      #if sublabel != none [
        #v(3pt * s)
        #text(
          size: 18.5pt * s,
          fill: theme.muted,
          sublabel,
        )
      ]
    ],
  )
}

/// 关键指标横向排列容器
#let kpi-row(..cards) = context {
  let s = poster-scale-state.get()
  let items = cards.pos()
  grid(
    columns: (1fr,) * items.len(),
    gutter: 14pt * s,
    ..items,
  )
}

/// 学术公式展示框
#let formula-box(eq, caption: none) = context {
  let theme = poster-theme-state.get()
  let s = poster-scale-state.get()
  block(
    width: 100%,
    fill: theme.soft-fill,
    stroke: (left: (5pt * s) + theme.secondary, rest: (1pt * s) + theme.border),
    radius: 8pt * s,
    inset: (x: 22pt * s, y: 18pt * s),
    breakable: false,
    [
      #align(center, eq)
      #if caption != none [
        #v(8pt * s)
        #align(center, text(size: 21pt * s, fill: theme.muted, caption))
      ]
    ],
  )
}

/// 海报内容卡片组件
#let poster-card(title, body, number: none, accent-bar: true) = context {
  let theme = poster-theme-state.get()
  let s = poster-scale-state.get()
  block(
    width: 100%,
    fill: theme.card-bg,
    stroke: (1.5pt * s) + theme.border,
    radius: 14pt * s,
    inset: (x: 30pt * s, y: 26pt * s),
    breakable: false,
    [
      #if title != none [
        #block(
          width: 100%,
          below: 18pt * s,
          inset: (bottom: 12pt * s),
          stroke: (bottom: if accent-bar { (3pt * s) + theme.primary } else { (1pt * s) + theme.border }),
          grid(
            columns: if number != none { (auto, 1fr) } else { (1fr,) },
            gutter: 14pt * s,
            align: horizon,
            ..if number != none {
              (
                box(
                  fill: theme.primary,
                  radius: 7pt * s,
                  inset: (x: 13pt * s, y: 6pt * s),
                  text(
                    font: cqu-fonts.hei,
                    size: 25pt * s,
                    weight: "bold",
                    fill: white,
                    number,
                  ),
                ),
              )
            } else { () },
            text(
              font: cqu-fonts.hei,
              size: 37pt * s,
              weight: "bold",
              fill: theme.primary,
              title,
            ),
          ),
        )
      ]
      #set text(fill: theme.text)
      #body
    ],
  )
}

/// 突出结论/指标的高亮框
#let highlight-box(title: none, body) = context {
  let theme = poster-theme-state.get()
  let s = poster-scale-state.get()
  block(
    width: 100%,
    fill: theme.soft-fill,
    stroke: (left: (6pt * s) + theme.accent, rest: (1pt * s) + theme.border),
    radius: 8pt * s,
    inset: (x: 20pt * s, y: 18pt * s),
    breakable: false,
    [
      #if title != none [
        #text(
          font: cqu-fonts.hei,
          size: 27pt * s,
          weight: "bold",
          fill: theme.primary,
          title,
        )
        #v(8pt * s)
      ]
      #body
    ],
  )
}

/// 参考文献左对齐容器（避免长英文条目两端对齐出现词距过宽）
#let ref-list(body) = {
  set par(justify: false)
  body
}

/// 主海报模板函数
#let cquposter(
  paper: "a0", // "a0" | "a1" | "a2"
  landscape: false,
  columns-count: 3, // 2 | 3 | 4
  theme-name: "cqu-blue", // "cqu-blue" | "academic-slate"
  lang: "zh", // "zh" | "en"
  font-style: "sans", // "sans" | "serif"
  title: "学术海报标题",
  subtitle: none,
  authors: "作者姓名¹, 导师姓名²",
  affiliations: "¹重庆大学计算机学院  ²通信作者单位",
  contact: "email@cqu.edu.cn",
  badge: image("figures/CQUbadge.png", width: 6.8cm),
  footer-left: "重庆大学 · Chongqing University",
  footer-right: "2026 学术海报",
  body,
) = {
  let theme = cqu-themes.at(theme-name, default: cqu-themes.cqu-blue)
  let s = cqu-paper-scales.at(paper, default: 1.0)
  let body-font = if font-style == "serif" { cqu-fonts.song } else { cqu-fonts.hei }

  poster-theme-state.update(theme)
  poster-scale-state.update(s)

  set document(title: title)
  set page(
    paper: paper,
    flipped: landscape,
    margin: (top: 2.0cm * s, bottom: 2.6cm * s, left: 2.0cm * s, right: 2.0cm * s),
    fill: theme.bg,
  )

  set text(
    font: body-font,
    size: 30pt * s,
    lang: lang,
    region: if lang == "zh" { "CN" } else { "US" },
    fill: theme.text,
  )

  set par(leading: 0.85em, justify: true)
  set list(indent: 1em, body-indent: 0.6em)
  set enum(indent: 1em, body-indent: 0.6em)

  // 现代学术三线表样式
  set table(
    stroke: (x, y) => if y == 0 {
      (top: (2.5pt * s) + theme.primary, bottom: (1.5pt * s) + theme.primary)
    } else {
      (bottom: (0.75pt * s) + theme.border)
    },
    fill: (x, y) => if y == 0 {
      theme.soft-fill
    } else if calc.odd(y) {
      white
    } else {
      theme.bg.transparentize(35%)
    },
  )
  show table.cell.where(y: 0): set text(
    font: cqu-fonts.hei,
    weight: "bold",
    fill: theme.primary,
  )

  show heading.where(level: 2): it => {
    v(14pt * s)
    text(font: cqu-fonts.hei, size: 31pt * s, weight: "bold", fill: theme.secondary, it.body)
    v(8pt * s)
  }

  // 顶部横幅 Header（渐变背景 + 几何装饰 + 圆形校徽 + 底部强调色带）
  block(
    width: 100%,
    fill: gradient.linear(theme.primary, theme.primary-deep, angle: 135deg),
    radius: 14pt * s,
    clip: true,
    below: 30pt * s,
    [
      #box(width: 100%, inset: (x: 44pt * s, y: 38pt * s))[
        // 背景装饰圆环（低透明度，增加纵深感）
        #place(
          top + right,
          dx: 3.5cm * s,
          dy: -2.8cm * s,
          circle(radius: 7.5cm * s, stroke: (1.5pt * s) + white.transparentize(90%), fill: white.transparentize(96%)),
        )
        #place(
          top + right,
          dx: 1.5cm * s,
          dy: -1.2cm * s,
          circle(radius: 4.8cm * s, stroke: (1pt * s) + white.transparentize(88%)),
        )
        #grid(
          columns: if badge != none { (1fr, auto) } else { (1fr,) },
          gutter: 28pt * s,
          align: horizon,
          [
            #text(
              font: cqu-fonts.hei,
              size: 64pt * s,
              weight: "bold",
              fill: white,
              title,
            )
            #if subtitle != none [
              #v(12pt * s)
              #text(font: cqu-fonts.hei, size: 30pt * s, fill: rgb("#DBEAFE"), subtitle)
            ]
            #v(18pt * s)
            #text(font: cqu-fonts.hei, size: 27pt * s, weight: "medium", fill: white, authors)
            #v(8pt * s)
            #text(size: 23pt * s, fill: rgb("#E2E8F0"), affiliations)
            #if contact != none [
              #v(6pt * s)
              #text(font: cqu-fonts.hei, size: 20pt * s, fill: rgb("#BFDBFE"), contact)
            ]
          ],
          ..if badge != none {
            (
              box(
                fill: white,
                radius: 50%,
                inset: 10pt * s,
                stroke: (3pt * s) + theme.accent.transparentize(25%),
                clip: true,
                badge,
              ),
            )
          } else { () },
        )
      ]
      // 底部强调色带
      #block(width: 100%, height: 6pt * s, fill: theme.accent)
    ],
  )

  // 主体多栏区域
  columns(columns-count, gutter: 26pt * s)[
    #body
  ]

  // 底部栏 Footer
  place(
    bottom + center,
    dy: 1.4cm * s,
    block(
      width: 100%,
      inset: (x: 16pt * s, y: 12pt * s),
      stroke: (top: (1.5pt * s) + theme.border),
      grid(
        columns: (1fr, 1fr),
        align(left, text(font: cqu-fonts.hei, size: 21pt * s, fill: theme.muted, footer-left)),
        align(right, text(font: cqu-fonts.hei, size: 21pt * s, fill: theme.muted, footer-right)),
      ),
    ),
  )
}
