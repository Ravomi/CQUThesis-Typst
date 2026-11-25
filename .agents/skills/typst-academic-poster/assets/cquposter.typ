// 重庆大学学术海报 Typst 模板 (CQUPoster-Typst)
// 借鉴 CQUThesis-Typst 的字体与校徽规范，适配 A0/A1/A2 学术海报排版

#let cqu-fonts = (
  song: ("Times New Roman", "Liberation Serif", "SimSun", "Noto Serif CJK SC"),
  hei: ("Times New Roman", "Liberation Sans", "SimHei", "Noto Sans CJK SC"),
  mono: ("DejaVu Sans Mono", "Consolas", "Courier New"),
)

#let cqu-themes = (
  cqu-blue: (
    primary: rgb("#003B73"),
    secondary: rgb("#1E5AA8"),
    accent: rgb("#D97706"),
    bg: rgb("#F3F6FA"),
    card-bg: white,
    border: rgb("#D0DCEB"),
    text: rgb("#1F2937"),
    muted: rgb("#4B5563"),
  ),
  academic-slate: (
    primary: rgb("#0F172A"),
    secondary: rgb("#334155"),
    accent: rgb("#0284C7"),
    bg: rgb("#F8FAFC"),
    card-bg: white,
    border: rgb("#CBD5E1"),
    text: rgb("#0F172A"),
    muted: rgb("#475569"),
  ),
)

#let poster-theme-state = state("poster-theme", cqu-themes.cqu-blue)

/// 海报内容卡片组件
#let poster-card(title, body, accent-bar: true) = context {
  let theme = poster-theme-state.get()
  block(
    width: 100%,
    fill: theme.card-bg,
    stroke: 1.5pt + theme.border,
    radius: 10pt,
    inset: (x: 24pt, y: 20pt),
    breakable: false,
    [
      #if title != none [
        #block(
          width: 100%,
          below: 14pt,
          inset: (bottom: 8pt),
          stroke: (bottom: if accent-bar { 2.5pt + theme.primary } else { 1pt + theme.border }),
          text(
            font: cqu-fonts.hei,
            size: 28pt,
            weight: "bold",
            fill: theme.primary,
            title,
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
  block(
    width: 100%,
    fill: theme.bg,
    stroke: (left: 5pt + theme.accent, rest: 1pt + theme.border),
    radius: 6pt,
    inset: 16pt,
    breakable: false,
    [
      #if title != none [
        #text(font: cqu-fonts.hei, weight: "bold", fill: theme.primary, title)
        #v(6pt)
      ]
      #body
    ],
  )
}

/// 主海报模板函数
#let cquposter(
  paper: "a0", // "a0" | "a1" | "a2"
  landscape: false,
  columns-count: 3, // 2 | 3 | 4
  theme-name: "cqu-blue", // "cqu-blue" | "academic-slate"
  lang: "zh", // "zh" | "en"
  title: "学术海报标题",
  subtitle: none,
  authors: "作者姓名¹, 导师姓名²",
  affiliations: "¹重庆大学计算机学院  ²通信作者单位",
  contact: "email@cqu.edu.cn",
  badge: image("figures/CQUbadge.png", width: 5.5cm),
  footer-left: "重庆大学 · Chongqing University",
  footer-right: "2026 学术海报",
  body,
) = {
  let theme = cqu-themes.at(theme-name, default: cqu-themes.cqu-blue)
  poster-theme-state.update(theme)

  set document(title: title)
  set page(
    paper: paper,
    flipped: landscape,
    margin: (top: 2.2cm, bottom: 2.2cm, left: 2.2cm, right: 2.2cm),
    fill: theme.bg,
  )

  set text(
    font: cqu-fonts.song,
    size: 20pt,
    lang: lang,
    region: if lang == "zh" { "CN" } else { "US" },
    fill: theme.text,
  )

  set par(leading: 0.72em, justify: true)
  set list(indent: 1em, body-indent: 0.6em)
  set enum(indent: 1em, body-indent: 0.6em)

  show heading.where(level: 2): it => {
    v(10pt)
    text(font: cqu-fonts.hei, size: 22pt, weight: "bold", fill: theme.secondary, it.body)
    v(6pt)
  }

  // 顶部横幅 Header
  block(
    width: 100%,
    fill: theme.primary,
    radius: 12pt,
    inset: (x: 36pt, y: 30pt),
    below: 24pt,
    grid(
      columns: if badge != none { (1fr, auto) } else { (1fr,) },
      gutter: 24pt,
      align: horizon,
      [
        #text(
          font: cqu-fonts.hei,
          size: 46pt,
          weight: "bold",
          fill: white,
          title,
        )
        #if subtitle != none [
          #v(10pt)
          #text(font: cqu-fonts.hei, size: 26pt, fill: rgb("#DBEAFE"), subtitle)
        ]
        #v(14pt)
        #text(font: cqu-fonts.hei, size: 22pt, fill: white, authors)
        #v(6pt)
        #text(size: 18pt, fill: rgb("#E2E8F0"), affiliations)
        #if contact != none [
          #v(4pt)
          #text(font: cqu-fonts.mono, size: 16pt, fill: rgb("#BFDBFE"), contact)
        ]
      ],
      ..if badge != none {
        (
          box(
            fill: white,
            radius: 10pt,
            inset: 10pt,
            badge,
          ),
        )
      } else { () },
    ),
  )

  // 主体多栏区域
  columns(columns-count, gutter: 24pt)[
    #body
  ]

  // 底部栏 Footer
  place(
    bottom + center,
    dy: 1.1cm,
    block(
      width: 100%,
      inset: (x: 16pt, y: 10pt),
      stroke: (top: 1.5pt + theme.border),
      grid(
        columns: (1fr, 1fr),
        align(left, text(size: 16pt, fill: theme.muted, footer-left)),
        align(right, text(size: 16pt, fill: theme.muted, footer-right)),
      ),
    ),
  )
}
