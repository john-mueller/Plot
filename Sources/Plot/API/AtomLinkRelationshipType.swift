/// An enum that defines various values for an Atom `<link>` element's `rel`
/// attribute, which specifies the relationship that the entry or feed has
/// to the URL that it's linking to.
public enum AtomLinkRelationshipType {
    /// An alternate representation of the entry or feed,
    /// for example a permalink to the html version of the entry,
    /// or the front page of the weblog.
    case alternate
    /// A related resource which is potentially large in size and might
    /// require special handling, for example an audio or video recording.
    case enclosure
    /// A document related to the entry or feed.
    case related
    /// The feed itself.
    case `self`
    /// The source of the information provided in the entry.
    case via
    /// A custom URI for extensibility.
    case uri(URLRepresentable)
}

extension AtomLinkRelationshipType: CustomStringConvertible {
    public var description: String {
        switch self {
        case let .uri(uri): return uri.string
        case .alternate: return "alternate"
        case .enclosure: return "enclosure"
        case .related: return "related"
        case .self: return "self"
        case .via: return "via"
        }
    }
}
