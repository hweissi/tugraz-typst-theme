// This theme is inspired by https://github.com/matze/mtheme
// The polylux-port was performed by https://github.com/Enivex

// Consider using:
// #set text(font: "Fira Sans", weight: "light", size: 20pt)
// #show math.equation: set text(font: "Fira Math")
// #set strong(delta: 100)
// #set par(justify: true)

#import "@preview/polylux:0.3.1": *
#import "@preview/showybox:2.0.1": showybox
#let m-dark-teal = rgb("#1A1A1A")
#let m-light-brown = rgb("#F70146")
#let m-lighter-brown = rgb("#e0c0c5")
#let m-extra-light-gray = white.darken(2%)
#let m-footer-background = rgb("#dfdfdf")

#let m-footer = state("m-footer", [])
#let m-page-progress-bar = state("m-page-progress-bar", [])

#let m-cell = block.with(
  width: 100%,
  height: 100%,
  above: 0pt,
  below: 0pt,
  breakable: false
)

#let m-progress-bar = utils.polylux-progress( ratio => {
  grid(
    columns: (ratio * 100%, 1fr),
    m-cell(fill: m-light-brown),
    m-cell(fill: m-lighter-brown)
  )
})

#let tugraz-theme(
  aspect-ratio: "16-9",
  footer: [],
  progress-bar: true,
  body
) = {
  set page(
    paper: "presentation-" + aspect-ratio,
    fill: m-extra-light-gray,
    margin: 0em,
    header: none,
    footer: none,
  )
  set list(marker: (text(size: 1.7em, "•"), text(size: 1.5em, "•"), text(size: 1.3em, "•")))
  m-footer.update(footer)
  if progress-bar {
    m-page-progress-bar.update(m-progress-bar)

  }

  body
}

#let title-slide(
  title: [],
  subtitle: none,
  author: none,
  date: none,
  extra: none,
) = {
  let content = {
    set text(fill: m-dark-teal)
    set align(horizon)
    place(top + right, pad(30%, image("./TU_Graz.svg", format: "svg", width: 20%)))
    block(width: 100%, inset: 2em, {
      text(size: 1.8em, strong(title), weight: "regular", fill: m-light-brown)
      if subtitle != none {
        linebreak()
        linebreak()
        text(size: 0.8em, subtitle)
      }
      line(length: 100%, stroke: .05em + m-light-brown)
      set text(size: .8em)
      if author != none {
        block(spacing: 1em, text(weight: "medium", author))
      }
      if date != none {
        block(spacing: 1em, date)
      }
      set text(size: .8em)
      if extra != none {
        block(spacing: 1em, extra)
      }
    
    })
  }

  logic.polylux-slide(content)
}

#let slide(title: none, body) = {
  let header = {
    set align(top)
    if title != none {
      show: m-cell.with(fill: m-dark-teal, inset: 1em)
      set align(horizon)
      set text(fill: m-extra-light-gray, size: 1.2em)
      strong(title)
      h(1fr)
      box(pad(bottom: .75em, text(size: .5em, "www.tugraz.at", weight: "medium")))
      box(pad(left: .2em, bottom: .75em, square(fill: m-light-brown, size: .3em)))
    } else { 
      h(1fr)
      box(pad(bottom: .75em, text(size: .5em, "www.tugraz.at", weight: "medium")))
      box(pad(left: .2em, bottom: .75em, square(fill: m-light-brown, size: .3em)))
    }
  }

  let footer = {
    set text(size: 0.7em)
    show: m-cell.with(fill: m-footer-background)
    set align(horizon)

    box(align(left+top, square(height: 100%, fill: m-light-brown, align(horizon+center, text(fill: m-extra-light-gray, weight: "regular", size: .9em, logic.logical-slide.display())))))
    

    h(1fr)
    box(height: 100%, pad(1.5em, text(fill: m-dark-teal, size: .9em, m-footer.display())))
    place(bottom, block(height: 2pt, width: 100%, m-page-progress-bar.display()))
    


  }

  set page(
    header: header,
    footer: footer,
    margin: (top: 3em, bottom: 2em),
    fill: m-extra-light-gray,
  )

  let content = {
    show: align.with(horizon)
    show: pad.with(left: 2em, 1em)
    set text(fill: m-dark-teal)
    body 
  }

  logic.polylux-slide(content)
}

#let new-section-slide(name) = {
  let content = {
    utils.register-section(name)
    set align(horizon)
    show: pad.with(20%)
    set text(size: 1.5em)
    name
    block(height: 2pt, width: 100%, spacing: 0pt, m-progress-bar)
  }
  logic.polylux-slide(content)
}

#let focus-slide(body) = {
  set page(fill: m-dark-teal, margin: 2em)
  set text(fill: m-extra-light-gray, size: 1.5em)
  logic.polylux-slide(align(horizon + center, body))
}

#let alert = text.with(fill: m-light-brown)
#let numbering-func(..nums) = {
      box(
        square(fill: m-light-brown, height: 1.2em,
          align(center, text(fill: m-extra-light-gray, weight: "medium",  
          nums.pos().map(str).join(".")))
      ))
    }
#let metropolis-outline = utils.polylux-outline(enum-args: (tight: false, numbering: numbering-func))
#let quotebox = showybox.with(frame: (
      border-color: m-dark-teal,
      footer-color: m-light-brown.darken(25%).desaturate(10%),
      body-color: m-light-brown.lighten(80%),
      radius: 0pt
    ),
    footer-style: (
      color: m-extra-light-gray,
      weight: "light",

      align: right
    ),
    shadow: (
      offset: 5pt
    )
  )

#let defbox = showybox.with(frame: (
      border-color: m-dark-teal.lighten(20%),
      title-color: m-extra-light-gray.darken(30%),
      body-color: m-extra-light-gray.darken(10%),
      radius: 0pt
    ),
    title-style: (
      color: m-light-brown.darken(10%),
      weight: "medium",

      align: left
    ),
    shadow: (
      offset: 4pt
    )
  )