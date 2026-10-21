#import "date.typ" : date, range

/// Creates a generic subsection, rendering only the provided fields.
/// 
/// -> content
#let subsection(
  /// -> str | none
  title: none,
  /// -> str | none
  subtitle: none,
  /// -> date | none
  from: none,
  /// -> date | none
  to: none,
  /// -> str | none
  location: none,
  /// -> str | none
  dates: none,
  /// -> str | none
  link: none,
  /// Puts the title and subtitle on one line ("Title | Subtitle"), with the
  /// dates/location (or link) on the right of that same line.
  /// -> bool
  inline: false,
  /// -> str | none
  text: none,
  /// -> array | dictionary
  items: ()
) = {
  if (type(text) == str) {
    eval(text, mode: "markup")
  }

  let cells = ()
  let subtitle-cell = true

  if (inline and title != none and subtitle != none) {
    subtitle-cell = false
    cells.push(grid.cell(align: left)[#strong(title) | #emph(subtitle)])
    if (location != none) {
      cells.push(grid.cell(align: right)[#if link != none { std.link(link)[#emph(location)] } else { emph(location) }])
    }
  } else if (title != none) {
    cells.push(
      // If we have a title and no date range, we allow the title to take the full width
      grid.cell(align: left, colspan: if from == none and dates == none { 2 } else { 1 })[#strong(title)]
    )
  }

  if (inline and not subtitle-cell) {
  } else if (dates != none) {
    cells.push(grid.cell(align: right)[#dates])
  } else if (from != none) {
    cells.push(
      grid.cell(align: right)[#range(from: date(..from), to: date(..to))]
    )
  }

  if (subtitle != none and subtitle-cell) {
    cells.push(
      // Similarly, if we have a subtitle and no location, we allow the subtitle to take the full width
      grid.cell(align: left, colspan: if location == none { 2 } else { 1 })[#emph(subtitle)]
    )
  }

  if (location != none and subtitle-cell) {
    cells.push(
      grid.cell(align: right)[#if link != none { std.link(link)[#emph(location)] } else { emph(location) }]
    )
  }

  if (cells.len() != 0) {
    grid(columns: (1fr, auto), row-gutter: 4pt, ..cells)
  }

  if (type(items) == array) {
    for item in items {
      [- #item]
    }
  }

  if (type(items) == dictionary) {
    for (key, value) in items {
      [- *#key:* #value]
    }
  }
}
