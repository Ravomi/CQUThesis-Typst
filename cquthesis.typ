// 重庆大学学位论文 Typst 模板 (CQUThesis-Typst)

#let thesis-state = state("cqu-thesis", (:))

#let cqu-fonts = (
  song: ("Times New Roman", "Liberation Serif", "Source Han Serif", "Noto Serif CJK SC", "SimSun"),
  hei: ("Times New Roman", "Liberation Sans", "Source Han Sans", "Noto Sans CJK SC", "SimHei"),
  kai: ("Times New Roman", "KaiTi", "STKaiti", "Source Han Serif", "Noto Serif CJK SC"),
  mono: ("DejaVu Sans Mono", "Consolas", "Courier New"),
)

#let degree-title(thesis-type, professional-master) = {
  if thesis-type == "bachelor" {
    "重庆大学本科学生毕业论文（设计）"
  } else if thesis-type == "master" {
    if professional-master {
      "重庆大学硕士学位论文（专业学位）"
    } else {
      "重庆大学硕士学位论文（学术学位）"
    }
  } else {
    "重庆大学博士学位论文（学术学位）"
  }
}

#let degree-title-en(thesis-type, professional-master) = {
  if thesis-type == "bachelor" {
    "A Thesis Submitted to Chongqing University in Partial Fulfillment of the Requirement for the Bachelor's Degree"
  } else if thesis-type == "master" {
    if professional-master {
      "A Thesis Submitted to Chongqing University in Partial Fulfillment of the Requirement for the Professional Master's Degree"
    } else {
      "A Thesis Submitted to Chongqing University in Partial Fulfillment of the Requirement for the Master's Degree"
    }
  } else {
    "A Dissertation Submitted to Chongqing University in Partial Fulfillment of the Requirement for the Doctor's Degree"
  }
}

#let cquthesis(
  thesis-type: "master", // "bachelor" | "master" | "doctor"
  professional-master: false,
  blind-trial: false,
  lang: "zh", // "zh" (中文论文) | "en" (国际生/英文论文，保留中文封面与授权书)
  print-mode: "oneside", // "oneside" (电子版/单面) | "twoside" (纸质双面打印)
  title: "基于多智能体协同的工作流编排优化技术研究",
  title-en: "Research on Workflow Orchestration Optimization Based on Multi-Agent Collaboration",
  author: "作者姓名",
  student-id: "20230000",
  college: "计算机学院",
  major: "计算机科学与技术",
  supervisor: "导师姓名 教授",
  assist-supervisor: "",
  date: "2026年5月",
  date-en: "May, 2026",
  clc: "TP311",
  udc: "004.4",
  secret-level: "公开",
  abstract-cn: [],
  keywords-cn: (),
  abstract-en: [],
  keywords-en: (),
  denotation: none,
  ack: none,
  appendix-content: none,
  bib-file: none,
  body,
) = {
  set document(title: title, author: if blind-trial { "" } else { author })

  set page(
    paper: "a4",
    margin: (top: 2.5cm, bottom: 2.5cm, left: 2.5cm, right: 2.5cm),
  )

  set text(
    font: cqu-fonts.song,
    size: 12pt, // 小四
    lang: lang,
    region: if lang == "zh" { "CN" } else { "US" },
  )

  // 1. 封面页
  page(header: none, footer: none, numbering: none)[
    #v(0.5cm)
    #grid(
      columns: (1fr, 1fr),
      align: (left, right),
      [#text(size: 10.5pt)[中图分类号：#clc \ UDC：#udc]],
      [#text(size: 10.5pt)[密级：#secret-level]],
    )
    #v(1.2cm)
    #align(center)[
      #image("figures/CQUbadge.png", width: 2.8cm)
      #v(0.6cm)
      #text(font: cqu-fonts.hei, size: 22pt, weight: "bold")[#degree-title(thesis-type, professional-master)]
      #v(1.2cm)
      #text(font: cqu-fonts.hei, size: 18pt, weight: "bold")[#title]
      #v(0.6cm)
      #text(size: 13pt, weight: "bold")[#title-en]
    ]
    #v(1.5cm)
    #align(center)[
      #let info-row(label, val) = (
        text(font: cqu-fonts.hei, size: 12pt)[#label],
        text(size: 12pt)[：],
        text(size: 12pt)[#val],
      )
      #table(
        columns: (auto, auto, 7cm),
        stroke: (x, y) => if x == 2 { (bottom: 0.6pt + black) } else { none },
        inset: (x: 4pt, y: 8pt),
        align: (right, center, center),
        ..info-row("作 者 姓 名", if blind-trial { "（盲审隐去）" } else { author }),
        ..info-row("学       号", if blind-trial { "（盲审隐去）" } else { student-id }),
        ..info-row("指 导 教 师", if blind-trial { "（盲审隐去）" } else { supervisor }),
        ..(if assist-supervisor != "" { info-row("副 导 师", if blind-trial { "（盲审隐去）" } else { assist-supervisor }) } else { () }),
        ..info-row("学 科 专 业", major),
        ..info-row("学 院（系）", college),
        ..info-row("提交论文日期", date),
      )
    ]
    #v(1fr)
    #align(center)[
      #text(size: 12pt)[重庆大学 \ #date]
    ]
  ]

  // 英文题名页
  page(header: none, footer: none, numbering: none)[
    #v(2.5cm)
    #align(center)[
      #text(size: 16pt, weight: "bold")[#title-en]
      #v(2.5cm)
      #text(size: 12pt)[#degree-title-en(thesis-type, professional-master)]
      #v(2.5cm)
      #if not blind-trial [
        #text(size: 12pt)[By \ #v(0.5cm) #author]
        #v(1.5cm)
        #text(size: 12pt)[Supervised by \ #v(0.5cm) #supervisor]
      ] else [
        #text(size: 12pt)[(Blind Review Copy)]
      ]
      #v(1fr)
      #text(size: 12pt)[Chongqing University \ #date-en]
    ]
  ]

  // 2. 前置部分（罗马数字页码）
  counter(page).update(1)
  set page(
    numbering: "I",
    header: align(center)[#text(size: 9pt)[#degree-title(thesis-type, professional-master)]],
    footer: context align(center)[#text(size: 9pt)[#counter(page).display("I")]],
  )

  set par(justify: true, leading: 0.95em, first-line-indent: 2em)

  // 中文摘要
  heading(level: 1, numbering: none, outlined: true)[摘 要]
  v(0.5em)
  abstract-cn
  v(1em)
  par(first-line-indent: 0em)[
    *关键词：* #keywords-cn.join("；")
  ]
  pagebreak()

  // 英文摘要
  heading(level: 1, numbering: none, outlined: true)[ABSTRACT]
  v(0.5em)
  abstract-en
  v(1em)
  par(first-line-indent: 0em)[
    *Key Words:* #keywords-en.join("; ")
  ]
  pagebreak()

  // 目录
  outline(title: "目 录", indent: auto)
  pagebreak()

  // 插图索引与表格索引
  outline(title: "插图索引", target: figure.where(kind: image))
  pagebreak()
  outline(title: "表格索引", target: figure.where(kind: table))
  pagebreak()

  // 符号对照表（可选）
  if denotation != none {
    heading(level: 1, numbering: none, outlined: true)[符号与缩略语说明]
    denotation
    pagebreak()
  }

  // 3. 正文部分（阿拉伯数字页码）
  counter(page).update(1)
  set page(
    numbering: "1",
    header: context {
      // 优先取本页新开章的标题，否则沿用上一章标题
      let page-no = here().page()
      let on-page = query(heading.where(level: 1)).filter(h => h.location().page() == page-no)
      let elems = query(heading.where(level: 1).before(here()))
      let chapter-title = if on-page.len() > 0 {
        on-page.first().body
      } else if elems.len() > 0 {
        elems.last().body
      } else { title }
      grid(
        columns: (1fr, 1fr),
        align: (left, right),
        [#text(size: 9pt)[#degree-title(thesis-type, professional-master)]],
        [#text(size: 9pt)[#chapter-title]],
      )
      v(-0.6em)
      line(length: 100%, stroke: 0.5pt)
    },
    footer: context align(center)[#text(size: 9pt)[#counter(page).display("1")]],
  )

  set heading(numbering: "1.1")
  // 表格、图片与公式按章编号（符合重庆大学 2023 版格式标准：图 1.1 / 表 2.1 / (3-1)）
  show heading.where(level: 1): it => {
    counter(figure.where(kind: image)).update(0)
    counter(figure.where(kind: table)).update(0)
    counter(math.equation).update(0)
    counter("cqu-theorem").update(0)
    counter("cqu-definition").update(0)
    counter("cqu-algorithm").update(0)
    if print-mode == "twoside" {
      pagebreak(to: "odd", weak: true)
    } else {
      pagebreak(weak: true)
    }
    set text(font: cqu-fonts.hei, size: 16pt, weight: "bold")
    block(above: 1.2em, below: 1em, align(center)[#it])
  }
  show heading.where(level: 2): it => {
    set text(font: cqu-fonts.hei, size: 14pt, weight: "bold")
    block(above: 1.1em, below: 0.8em, it)
  }
  show heading.where(level: 3): it => {
    set text(font: cqu-fonts.hei, size: 12pt, weight: "bold")
    block(above: 0.9em, below: 0.6em, it)
  }
  show figure.where(kind: table): set figure.caption(position: top)
  set figure(numbering: n => {
    let ch = counter(heading).get().first()
    str(ch) + "." + str(n)
  })
  set math.equation(numbering: n => {
    let ch = counter(heading).get().first()
    "(" + str(ch) + "-" + str(n) + ")"
  })
  set table(stroke: none)

  body

  // 4. 后置部分
  if not blind-trial and ack != none {
    heading(level: 1, numbering: none, outlined: true)[致 谢]
    ack
  }

  if bib-file != none {
    bibliography(bib-file, title: "参考文献", style: "gb-7714-2015-numeric")
  }

  if appendix-content != none {
    set heading(numbering: "A.1")
    counter(heading).update(0)
    appendix-content
  }

  // 原创性声明与版权使用授权书（盲审模式下自动省略）
  if not blind-trial {
    pagebreak()
    heading(level: 1, numbering: none, outlined: true)[重庆大学学位论文原创性声明和版权使用授权书]
    v(0.8em)
    align(center)[#text(font: cqu-fonts.hei, size: 13pt, weight: "bold")[学位论文原创性声明]]
    v(0.5em)
    [本人郑重声明：所呈交的学位论文，是本人在导师的指导下，独立进行研究所取得的成果。除文中已经注明引用的内容外，本论文不包含任何其他个人或集体已经发表或撰写过的科研成果。对本文的研究作出重要贡献的个人和集体，均已在文中以明确方式标明。本声明的法律责任由本人承担。]
    v(1.2em)
    [论文作者签名：\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_ #h(2em) 日期：\_\_\_\_\_\_年\_\_\_\_月\_\_\_\_日]
    v(2em)
    align(center)[#text(font: cqu-fonts.hei, size: 13pt, weight: "bold")[学位论文版权使用授权书]]
    v(0.5em)
    [本学位论文作者完全了解重庆大学有关保留、使用学位论文的规定，即：学校有权保留并向国家有关部门或机构送交论文的复印件和电子版，允许论文被查阅和借阅。本人授权重庆大学可以将本学位论文的全部或部分内容编入有关数据库进行检索，可以采用影印、缩印或扫描等复制手段保存和汇编本学位论文。]
    v(1.2em)
    [论文作者签名：\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_ #h(2em) 导师签名：\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_]
    v(0.8em)
    [日期：\_\_\_\_\_\_年\_\_\_\_月\_\_\_\_日 #h(4em) 日期：\_\_\_\_\_\_年\_\_\_\_月\_\_\_\_日]
  }
}

// 三线表辅助函数
#let three-line-table(..args) = {
  table(
    stroke: (x, y) => (
      top: if y == 0 { 1.2pt } else if y == 1 { 0.6pt } else { 0pt },
      bottom: 1.2pt,
    ),
    inset: 6pt,
    ..args,
  )
}

// 双语题注辅助函数
#let bilingual-caption(cn, en) = [
  #cn \
  #text(size: 10.5pt)[#en]
]

// 按章编号的定理、定义、证明环境
#let thm-counter = counter("cqu-theorem")
#let def-counter = counter("cqu-definition")
#let alg-counter = counter("cqu-algorithm")

#let theorem(title: none, body) = {
  thm-counter.step()
  block(
    above: 0.8em,
    below: 0.8em,
    breakable: true,
  )[
    #context {
      let ch = counter(heading).get().first()
      let n = thm-counter.get().first()
      let label-text = "定理 " + str(ch) + "." + str(n) + if title != none { "（" + title + "）" } else { "" }
      text(font: cqu-fonts.hei, weight: "bold")[#label-text]
    }
    #h(0.5em)#body
  ]
}

#let definition(title: none, body) = {
  def-counter.step()
  block(
    above: 0.8em,
    below: 0.8em,
    breakable: true,
  )[
    #context {
      let ch = counter(heading).get().first()
      let n = def-counter.get().first()
      let label-text = "定义 " + str(ch) + "." + str(n) + if title != none { "（" + title + "）" } else { "" }
      text(font: cqu-fonts.hei, weight: "bold")[#label-text]
    }
    #h(0.5em)#body
  ]
}

#let proof(body) = {
  block(above: 0.5em, below: 0.8em, breakable: true)[
    #text(font: cqu-fonts.hei, weight: "bold")[证明：]#body #h(1fr) $square$
  ]
}

// 三线伪代码算法框
#let algorithm(title: "算法", input: none, output: none, body) = {
  alg-counter.step()
  block(
    width: 100%,
    above: 1em,
    below: 1em,
    breakable: true,
    stroke: (top: 1.2pt, bottom: 1.2pt),
    inset: (y: 6pt, x: 4pt),
  )[
    #context {
      let ch = counter(heading).get().first()
      let n = alg-counter.get().first()
      text(font: cqu-fonts.hei, weight: "bold")[算法 #ch.#n #h(0.5em) #title]
    }
    #v(2pt)
    #line(length: 100%, stroke: 0.6pt)
    #v(2pt)
    #if input != none [*输入：* #input \ ]
    #if output != none [*输出：* #output \ ]
    #body
  ]
}
