#import "section.typ": section

/// A utility function to get a value from a dictionary or return a default value.
/// 
/// -> bool
#let value-or-default(
  /// -> dictionary
  dict,
  /// -> str
  key,
  /// -> any
  default,
) = {
  if (key in dict) and (dict.at(key) != none) and (dict.at(key) != "") {
    return dict.at(key)
  }
  return default
}

/// The main function to create a resume. 
/// 
/// -> content
#let resume(
  /// -> str
  candidate-name: "",
  /// -> str
  job-title: "",
  /// -> array
  links: (),
  /// -> array
  sections: (),
  /// -> dictionary
  style: (:),
  /// Extra keys (e.g. parked content in the config) are accepted and ignored.
  ..ignored,
) = {
  let header-color = value-or-default(style, "header-color", color.black.to-hex())
  let divider-color = value-or-default(style, "divider-color", color.black.to-hex())
  let link-color = value-or-default(style, "link-color", color.navy.to-hex())
  let font = value-or-default(style, "font", "Nimbus Sans")
  let font-size = eval(value-or-default(style, "font-size", "9pt"))
  let margin = eval(value-or-default(style, "margin", "0.75in"))

  set document(author: candidate-name, title: if job-title == "" [#candidate-name] else [#candidate-name $dash.em$ #job-title])
  set text(font: font, ligatures: false, size: font-size, slashed-zero: true)
  set line(length: 100%, stroke: 1pt + rgb(divider-color))
  set page(paper: "a4", margin: margin)
  show heading: it => [ #set text(fill: rgb(header-color)); #it ]
  show link: it => [ #set text(fill: rgb(link-color)); #underline(it) ]

  align(center)[
    = #candidate-name #if job-title != "" [$dash.em$ #job-title]
    #(
      links
        .map(it => if ("destination" in it) {
          link(it.destination)[#it.display]
        } else {
          it.display
        })
        .join(" | ")
    )
  ]

  for sect in sections {
    section(..sect)
  }
}
