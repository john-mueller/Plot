/// An enum that defines how the content of an entry is encoded.
public enum AtomContentType {
    /// The content is plain text with no entity escaped html.
    ///
    /// Example of `text`
    /// ```
    /// <title type="text">AT&amp;T bought by SBC!</title>
    /// ```
    case text
    /// The content is entity escaped html.
    ///
    /// Example of `html`
    /// ```
    /// <title type="html">
    ///   AT&amp;amp;T bought &amp;lt;b&amp;gt;by SBC&amp;lt;/b&amp;gt;!
    /// </title>
    /// ```
    case html
    /// The content is inline xhtml, wrapped in a div element.
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
    /// The <content> tag is empty, and the `src` attribute points to a
    /// resource of the specified type. The string must conform to the
    /// syntax of a MIME media type.
    case media(type: String)
}

extension AtomContentType: CustomStringConvertible {
    public var description: String {
        switch self {
        case .text: return "text"
        case .html: return "html"
        case .xhtml: return "xhtml"
        case let .media(mediaType): return mediaType
        }
    }
}
