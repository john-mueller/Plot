// MARK: - Feed

public extension Node where Context: AtomFeedContext {
    /// Add the Atom namespace to this feed.
    static func xmlns() -> Node {
        .attribute(named: "xmlns", value: "http://www.w3.org/2005/Atom")
    }
}

// MARK: - Common

public extension Node where Context: AtomCommonContext {
    static func xmlBase(_ base: URLRepresentable) -> Node {
        .attribute(named: "xml:base", value: base.string)
    }

    static func xmlLang(_ lang: Language) -> Node {
        .attribute(named: "xml:lang", value: lang.rawValue)
    }
}

public extension Attribute where Context: AtomCommonContext {
    static func xmlBase(_ base: URLRepresentable) -> Attribute {
        .attribute(named: "xml:base", value: base.string)
    }

    static func xmlLang(_ lang: Language) -> Attribute {
        .attribute(named: "xml:lang", value: lang.rawValue)
    }
}

// MARK: - Category

public extension Attribute where Context: AtomCategoryContext {
    /// Identify a category to which the entry to which the entry or feed belongs.
    /// - parameter term: A category for the entry or feed.
    static func term(_ term: String) -> Attribute {
        .attribute(named: "term", value: term)
    }

    /// Identify a categorization scheme using an
    /// [IRI](https://en.wikipedia.org/wiki/Internationalized_Resource_Identifier).
    /// - parameter scheme: The URL of a categorization scheme.
    static func scheme(_ scheme: URLRepresentable) -> Attribute {
        .attribute(named: "scheme", value: scheme.string)
    }

    /// Identify a human-readable label for the category.
    /// - parameter label: The label for the  category, which may be displayed.
    static func label(_ label: String) -> Attribute {
        .attribute(named: "label", value: label)
    }
}

// MARK: - Content

public extension Node where Context: AtomContentContext {
    /// Identify the type of the entry's content.
    /// - parameter type: The type of the entry's content.
    static func type(_ type: AtomContentType) -> Node {
        .attribute(named: "type", value: type.description)
    }

    /// Identify the source of the entry's content. The reference must be a valid
    /// [IRI](https://en.wikipedia.org/wiki/Internationalized_Resource_Identifier).
    /// - parameter src: The URL which is the source of the entry's content.
    static func src(_ src: URLRepresentable) -> Node {
        .attribute(named: "src", value: src.string)
    }
}

// MARK: - Generator

public extension Node where Context: AtomGeneratorContext {
    /// Identify a URL reference relevant to the generating agent.
    /// - parameter uri: The relevant agent reference.
    static func uri(_ uri: URLRepresentable) -> Node {
        .attribute(named: "uri", value: uri.string)
    }

    /// Identify a version of the generating agent.
    /// - parameter label: The generating agent's version.
    static func version(_ version: String) -> Node {
        .attribute(named: "version", value: version)
    }
}

// MARK: - Link

public extension Attribute where Context: AtomLinkContext {
    /// Indicate the reference of the link. The reference must be a valid
    /// [IRI](https://en.wikipedia.org/wiki/Internationalized_Resource_Identifier).
    /// - parameter href: The link's reference.
    static func href(_ href: URLRepresentable) -> Attribute {
        .attribute(named: "href", value: href.string)
    }

    /// Indicate the relationship type of the link.
    /// - parameter rel: The relationship type of the link.
    static func rel(_ rel: AtomLinkRelationshipType) -> Attribute {
        .attribute(named: "rel", value: rel.description)
    }

    /// Indicate the media type of the resource pointed to by the link's href attribute.
    /// The string must conform to the syntax of a MIME media type.
    /// - parameter type: The MIME media type of the link's content.
    static func type(_ type: String) -> Attribute {
        .attribute(named: "type", value: type)
    }

    /// Indicate the language of the resource pointed to by the link's href attribute.
    /// - parameter label: The language of the link's content.
    static func hreflang(_ hreflang: Language) -> Attribute {
        .attribute(named: "hreflang", value: hreflang.rawValue)
    }

    /// Indicate human-readible information about the link.
    /// - parameter title: The title of the link's content.
    static func title(_ title: String) -> Attribute {
        .attribute(named: "title", value: title)
    }

    /// Indicate the length of the linked resource in bytes.
    /// - parameter length: The length of the link's content in bytes.
    static func length(_ length: Int) -> Attribute {
        .attribute(named: "length", value: length.description)
    }
}

// MARK: - Text

public extension Node where Context: AtomTextContext {
    /// Identify the type of the element's text.
    /// - parameter type: The type of the element's text.
    static func type(_ type: AtomTextType) -> Node {
        .attribute(named: "type", value: type.description)
    }
}
