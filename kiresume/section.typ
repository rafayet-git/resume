#import "subsection.typ": subsection

/// Creates a generic section with a title, some text content, and some subsections.
/// 
/// -> content
#let section(
  /// -> str | none
  title: none,
  /// -> array
  subsections: (),
  /// Applies the one-line title/subtitle layout to every subsection.
  /// -> bool
  inline: false
) = {
  if title != none {
    [== #title]
  }

  line()
  subsections.map(x => subsection(inline: inline, ..x)).join()
}
