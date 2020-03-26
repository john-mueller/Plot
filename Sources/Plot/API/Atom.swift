import Foundation

/// Protocol adopted by all document formats that are based on Atom.
public protocol AtomBasedDocumentFormat: DocumentFormat where RootContext: AtomRootContext {
    /// The context of the document's feed
    associatedtype FeedContext: AtomFeedContext
}

/// A representation of an Atom feed. Create an instance of this type
/// to build an Atom feed using Plot's type-safe DSL, and then call the
/// `render()` method to turn it into an Atom string.
public struct Atom: AtomBasedDocumentFormat {
    private let document: Document<Atom>

    /// Create an Atom feed with a collection of nodes that make up the
    /// entries in the feed. Each entry can be created using the `.entry()`
    /// API.
    /// - parameter nodes: The nodes that make up the feed's entries.
    ///   Will be placed within a `<feed>` element.
    public init(_ nodes: Node<FeedContext>...) {
        document = .feed(.group(nodes))
    }
}

extension Atom: Renderable {
    public func render(indentedBy indentationKind: Indentation.Kind?) -> String {
        document.render(indentedBy: indentationKind)
    }
}

public extension Atom {
    /// The root context of an Atom feed. Plot automatically creates
    /// all required elements within this context for you.
    enum RootContext: AtomRootContext {}
    /// The context within the top level of an Atom feed, within the
    /// `<feed>` element, in which entries can be defined.
    enum FeedContext: AtomFeedContext {
        public typealias EntryContext = Atom.EntryContext
    }
    /// The context within an Atom feed's `<entry>` elements.
    enum EntryContext: AtomEntryContext {}
    /// The context within an Atom feed's `<category>` elements.
    enum CategoryContext: AtomCategoryContext {}
    /// The context within an Atom feed's `<content>` elements.
    enum ContentContext: AtomContentContext {}
    /// The context within an Atom feed's `<generator>` elements.
    enum GeneratorContext: AtomGeneratorContext {}
    /// The context within an Atom feed's `<link>` elements.
    enum LinkContext: AtomLinkContext {}
    /// The context within an Atom feed's `<person>` elements.
    enum PersonContext: AtomPersonContext {}
    /// The context within an Atom feed's `<title>`, `<subtitle>`,
    /// `<summary>`, and `<rights>` elements.
    enum TextContext: AtomTextContext {}
}

/// Protocol adopted by all contexts that are at the root level of
/// an Atom-based document format.
public protocol AtomRootContext: XMLRootContext {}
/// Protocol adopted by all contexts that define an Atom element.
public protocol AtomCommonContext {}
/// Protocol adopted by all contexts that are shared between Atom feeds and entries.
public protocol AtomContainerContext: AtomCommonContext {}
/// Protocol adopted by all contexts that define an Atom feed.
public protocol AtomFeedContext: AtomContainerContext {
    /// The feed's entry context.
    associatedtype EntryContext: AtomEntryContext
}
/// Protocol adopted by all contexts that define an Atom entry.
public protocol AtomEntryContext: AtomContainerContext {}
/// Protocol adopted by all contexts that define an Atom category.
public protocol AtomCategoryContext: AtomCommonContext {}
/// Protocol adopted by all contexts that define Atom content.
public protocol AtomContentContext: AtomCommonContext {}
/// Protocol adopted by all contexts that define an Atom generator.
public protocol AtomGeneratorContext: AtomCommonContext {}
/// Protocol adopted by all contexts that define an Atom link.
public protocol AtomLinkContext: AtomCommonContext {}
/// Protocol adopted by all contexts that define an Atom person.
public protocol AtomPersonContext: AtomCommonContext {}
/// Protocol adopted by all contexts that define Atom text.
public protocol AtomTextContext: AtomCommonContext {}

internal extension Atom {
    static let dateFormatter: AnyDateFormatter = {
        if #available(OSX 10.12, *) {
            let formatter = ISO8601DateFormatter()
            return formatter
        } else {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssXXXXX"
            formatter.calendar = Calendar(identifier: .iso8601)
            formatter.locale = Locale(identifier: "en_US_POSIX")
            return formatter
        }
    }()
}

internal extension Document where Format: AtomBasedDocumentFormat {
    static func feed(_ nodes: Node<Format.FeedContext>...) -> Document {
        Document(elements: [
            .xml(.version(1.0), .encoding(.utf8)),
            .feed(
                .xmlns(),
                .group(nodes)
            )
        ])
    }
}
