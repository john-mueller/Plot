/// An enum that defines how the text wrapped in an element is encoded.
public enum AtomTextType: String {
    /// The element contains plain text with no entity escaped html.
    ///
    /// Example of `text`
    /// ```
    /// <title type="text">AT&amp;T bought by SBC!</title>
    /// ```
    case text
    /// The element contains entity escaped html.
    ///
    /// Example of `html`
    /// ```
    /// <title type="html">
    ///   AT&amp;amp;T bought &amp;lt;b&amp;gt;by SBC&amp;lt;/b&amp;gt;!
    /// </title>
    /// ```
    case html
    /// The element contains inline xhtml, wrapped in a div element.
    ///
    /// Example of `xhtml`
    /// ```
    /// <title type="xhtml">
    ///   <div xmlns="http://www.w3.org/1999/xhtml">
    ///     AT&amp;T bought <b>by SBC</b>!
    ///   </div>
    /// </title>
    /// ```
    case xhtml
}

extension AtomTextType: CustomStringConvertible {
    public var description: String {
        rawValue
    }
}
