// 重庆大学学术幻灯片 Typst 模板 (CQUSlides-Typst)
// 16:9 宽屏，零外部依赖，适配组会汇报、学位答辩与学术报告

#let cqu-fonts = (
  song: ("Times New Roman", "Liberation Serif", "SimSun", "Noto Serif CJK SC"),
  hei: ("Times New Roman", "Liberation Sans", "SimHei", "Noto Sans CJK SC"),
  mono: ("DejaVu Sans Mono", "Consolas", "Courier New"),
)

#let cqu-blue = rgb("#003B73")
#let cqu-light = rgb("#EFF6FF")
#let cqu-accent = rgb("#D97706")
#let text-dark = rgb("#1F2937")
#let text-muted = rgb("#6B7280")

#let slide-footer-state = state("slide-footer", "重庆大学 · Chongqing University")

#let cquslides(
  footer: "重庆大学计算机学院 · 学术汇报",
  body,
) = {
  slide-footer-state.update(footer)
  set page(
    paper: "presentation-16-9",
    margin: (top: 2.2cm, bottom: 1.4cm, left: 1.6cm, right: 1.6cm),
    fill: white,
  )
  set text(
    font: cqu-fonts.song,
    size: 18pt,
    lang: "zh",
    region: "CN",
    fill: text-dark,
  )
  set par(leading: 0.7em)
  body
}

/// 首页标题页
#let title-slide(
  title: "学术汇报标题",
  subtitle: none,
  author: "汇报人",
  affiliation: "重庆大学计算机学院",
  date: "2026年5月",
  badge: image("figures/CQUbadge.png", width: 2.8cm),
) = {
  page(
    margin: 0pt,
    fill: cqu-blue,
    [
      #place(top + right, dx: -1.4cm, dy: 1.2cm,
        if badge != none {
          box(fill: white, radius: 8pt, inset: 8pt, badge)
        }
      )
      #pad(x: 2.2cm, y: 2.4cm)[
        #v(1fr)
        #pad(right: 3.8cm)[
          #text(font: cqu-fonts.hei, size: 34pt, weight: "bold", fill: white, title)
        ]
        #if subtitle != none [
          #v(0.5cm)
          #text(font: cqu-fonts.hei, size: 20pt, fill: rgb("#BFDBFE"), subtitle)
        ]
        #v(1.2cm)
        #line(length: 4cm, stroke: 3pt + cqu-accent)
        #v(0.8cm)
        #text(font: cqu-fonts.hei, size: 20pt, fill: white, author)
        #v(0.3cm)
        #text(size: 16pt, fill: rgb("#E2E8F0"), [#affiliation · #date])
        #v(1fr)
      ]
    ],
  )
}

/// 章节过渡页
#let section-slide(number, title) = {
  page(
    margin: 0pt,
    fill: cqu-light,
    align(center + horizon)[
      #text(font: cqu-fonts.hei, size: 48pt, weight: "bold", fill: cqu-blue, number)
      #v(0.3cm)
      #text(font: cqu-fonts.hei, size: 30pt, weight: "bold", fill: text-dark, title)
    ],
  )
}

/// 标准内容页
#let slide(title, body) = context {
  let footer-text = slide-footer-state.get()
  page(
    header: block(
      width: 100%,
      inset: (bottom: 8pt),
      stroke: (bottom: 2pt + cqu-blue),
      grid(
        columns: (1fr, auto),
        align: (left + bottom, right + bottom),
        text(font: cqu-fonts.hei, size: 22pt, weight: "bold", fill: cqu-blue, title),
        text(size: 12pt, fill: text-muted, "CQU"),
      ),
    ),
    footer: grid(
      columns: (1fr, auto),
      text(size: 12pt, fill: text-muted, footer-text),
      text(size: 12pt, fill: text-muted, counter(page).display("1 / 1", both: true)),
    ),
    body,
  )
}

/// 双栏辅助布局
#let two-col(left, right, ratio: (1fr, 1fr)) = grid(
  columns: ratio,
  gutter: 1.2cm,
  left,
  right,
)
