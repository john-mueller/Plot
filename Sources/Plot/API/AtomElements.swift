import Foundation

// MARK: - Top-level

public extension Element where Context: AtomRootContext {
    /// Add a `<feed>` element within the current context.
    /// - parameter nodes: The element's attributes and child elements.
    static func feed<C: AtomFeedContext>(_ nodes: Node<C>...) -> Element {
        Element(name: "feed", closingMode: .standard, nodes: nodes)
    }
}

// MARK: - Common

public extension Node where Context: AtomContainerContext {
    /// Add a `<author>` element within the current feed or entry context.
    /// This element indicates the author of the entry or feed.
    /// - parameter nodes: The element's attributes and child elements.
    static func author(_ nodes: Node<Atom.PersonContext>...) -> Node {
        .element(named: "author", nodes: nodes)
    }

    /// Add a `<category>` element within the current feed or entry context.
    /// This element conveys information about a category associated with an entry or feed.
    /// - parameter attributes: The element's attributes.
    static func category(_ attributes: Attribute<Atom.CategoryContext>...) -> Node {
        .selfClosedElement(named: "category", attributes: attributes)
    }

    /// Add a `<contributor>` element within the current feed or entry context.
    /// This element indicates a person or other entity who contributed to the entry or feed.
    /// - parameter nodes: The element's attributes and child elements.
    static func contributor(_ nodes: Node<Atom.PersonContext>...) -> Node {
        .element(named: "contributor", nodes: nodes)
    }

    /// Add an `<id>` element within the current feed or entry context.
    /// This element conveys a permanent, universally unique identifier for an entry or feed.
    /// The id must be a valid
    /// [IRI](https://en.wikipedia.org/wiki/Internationalized_Resource_Identifier).
    /// - parameter id: The string which identifies the entry or feed.
    static func id(_ id: URLRepresentable) -> Node {
        .element(named: "id", text: id.string)
    }

    /// Add a `<link>` element within the current feed or entry context.
    /// This element defines a reference from an entry or feed to a Web resource.
    /// - parameter attributes: The element's attributes.
    static func link(_ attributes: Attribute<Atom.LinkContext>...) -> Node {
        .selfClosedElement(named: "link", attributes: attributes)
    }

    /// Add a `<rights>` element within the current feed or entry context.
    /// This element conveys information about rights held in and over an entry or feed.
    /// - parameter nodes: The element's attributes and child elements.
    static func rights(_ nodes: Node<Atom.TextContext>...) -> Node {
        .element(named: "rights", nodes: nodes)
    }

    /// Add a `<title>` element within the current feed or entry context.
    /// This element conveys a human-readable title for an entry or feed.
    /// - parameter nodes: The element's attributes and child elements.
    static func title(_ nodes: Node<Atom.TextContext>...) -> Node {
        .element(named: "title", nodes: nodes)
    }

    /// Add an `<updated>` element within the current feed or entry context.
    /// This element indicates the most recent instant in time when an entry or feed was modified.
    /// - parameter date: The date the entry or feed was modified.
    /// - parameter timeZone: The time zone of the given `Date` (default: `.current`).
    static func updated(_ date: Date, timeZone: TimeZone = .current) -> Node {
        let formatter = Atom.dateFormatter
        formatter.timeZone = timeZone
        let dateString = formatter.string(from: date)
        return .element(named: "updated", text: dateString)
    }
}

// MARK: - Feed

public extension Node where Context: AtomFeedContext {
    /// Add an `<entry>` element within the current feed context.
    /// This element represents an individual entry within the feed.
    /// - parameter nodes: The element's attributes and child elements.
    static func entry(_ nodes: Node<Atom.EntryContext>...) -> Node {
        .element(named: "entry", nodes: nodes)
    }

    /// Add a `<generator>` element within the current feed context.
    /// This element identifies the agent used to generate a feed.
    /// - parameter nodes: The element's attributes and child elements.
    static func generator(_ nodes: Node<Atom.GeneratorContext>...) -> Node {
        .element(named: "generator", nodes: nodes)
    }

    /// Add an `<icon>` element within the current feed context.
    /// This element's content is an
    /// [IRI](https://en.wikipedia.org/wiki/Internationalized_Resource_Identifier)
    /// reference that identifies an image that provides iconic visual identification for a feed.
    /// The image should have a 1:1 aspect ratio.
    /// - parameter icon: The URL of the icon.
    static func icon(_ icon: URLRepresentable) -> Node {
        .element(named: "icon", text: icon.string)
    }

    /// Add a `<logo>` element within the current feed context.
    /// This element's content is an
    /// [IRI](https://en.wikipedia.org/wiki/Internationalized_Resource_Identifier)
    /// reference that identifies an image that provides visual identification for a feed.
    /// The image should have a 2:1 aspect ratio.
    /// - parameter logo: The URL of the logo.
    static func logo(_ logo: URLRepresentable) -> Node {
        .element(named: "logo", text: logo.string)
    }

    /// Add a `<subtitle>` element within the current feed context.
    /// This element conveys a human-readable description or subtitle for a feed.
    /// - parameter nodes: The element's attributes and child elements.
    static func subtitle(_ nodes: Node<Atom.TextContext>...) -> Node {
        .element(named: "subtitle", nodes: nodes)
    }
}

// MARK: - Entry
// TODO: Should any of these use parameters rather than variadic Nodes?
public extension Node where Context: AtomEntryContext {
    /// Add a `<content>` element within the current entry context.
    /// This element either contains or links to the content of the entry.
    /// - parameter nodes: The element's attributes and child elements.
    static func content(_ nodes: Node<Atom.ContentContext>...) -> Node {
        .element(named: "content", nodes: nodes)
    }

    /// Add a `<content>` element within the current entry context,
    /// and assign its HTML content using Plot's DSL.
    /// The `type="html"` attribute will be generated automatically.
    /// - parameter nodes: The HTML nodes to assign. Will be rendered
    ///   into a string without any indentation.
    static func content(_ nodes: Node<HTML.BodyContext>...) -> Node {
        .content(
            .type(.html),
            .text(nodes.render())
        )
    }

    /// Add a `<published>` element within the current entry context.
    /// This element indicates the an instant in time when an entry was published.
    /// - parameter date: The date the entry was published.
    /// - parameter timeZone: The time zone of the given `Date` (default: `.current`).
    static func published(_ date: Date, timeZone: TimeZone = .current) -> Node {
        let formatter = Atom.dateFormatter
        formatter.timeZone = timeZone
        let dateString = formatter.string(from: date)
        return .element(named: "published", text: dateString)
    }

    /// Add a `<source>` element within the current entry context.
    /// This element allows the preservation of a feed's metadata
    /// when one of its entries is copied into the current feed.
    /// - parameter nodes: The element's attributes and child elements.
    static func source(_ nodes: Node<Atom.FeedContext>...) -> Node {
        .element(named: "source", nodes: nodes)
    }

    /// Add a `<summary>` element within the current entry context.
    /// This element conveys a short summary, abstract, or excerpt of an entry.
    /// - parameter nodes: The element's attributes and child elements.
    static func summary(_ nodes: Node<Atom.TextContext>...) -> Node {
        .element(named: "summary", nodes: nodes)
    }
}

// MARK: - Person

public extension Node where Context: AtomPersonContext {
    /// Add a `<name>` element within the current author or contributor context.
    /// This element conveys a human-readable name for the person.
    /// - parameter name: The person's name.
    static func name(_ name: String) -> Node {
        .element(named: "name", text: name)
    }

    /// Add a `<uri>` element within the current author or contributor context.
    /// This element conveys an
    /// [IRI](https://en.wikipedia.org/wiki/Internationalized_Resource_Identifier)
    /// associated with the person.
    /// - parameter uri: The person's homepage.
    static func uri(_ uri: URLRepresentable) -> Node {
        .element(named: "uri", text: uri.string)
    }

    /// Add an `<email>` element within the current author or contributor context.
    /// This element conveys an email address associated with the person.
    /// - parameter email: The person's email address.
    static func email(_ email: String) -> Node {
        .element(named: "email", text: email)
    }
}
