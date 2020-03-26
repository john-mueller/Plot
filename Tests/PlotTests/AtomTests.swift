/**
*  Plot
*  Copyright (c) John Sundell 2019
*  MIT license, see LICENSE file for details
*/

import XCTest
import Plot

final class AtomTests: XCTestCase {
    func testEmptyAtomFeed() {
        let feed = Atom()
        assertEqualAtomFeedContent(feed, "")
    }

    func testAtomXMLAttributes() {
        let feed = Atom(
            .category(
                .xmlLang(.english),
                .xmlBase("https://example.com/")
            ),
            .entry(
                .content(
                    .xmlLang(.english),
                    .xmlBase("https://example.com/")
                )
            )
        )
        assertEqualAtomFeedContent(feed, """
        <category xml:lang="en" xml:base="https://example.com/"/>\
        <entry><content xml:lang="en" xml:base="https://example.com/"></content></entry>
        """)
    }

    func testAtomAuthor() {
        let feed = Atom(
            .author(
                .name("John Sundell"),
                .uri("https://example.com"),
                .email("fake@example.com")
            ),
            .entry(
                .author(
                    .name("John Sundell"),
                    .uri("https://example.com"),
                    .email("fake@example.com")
                )
            )
        )
        assertEqualAtomFeedContent(feed, """
        <author><name>John Sundell</name>\
        <uri>https://example.com</uri>\
        <email>fake@example.com</email></author>\
        <entry><author><name>John Sundell</name>\
        <uri>https://example.com</uri>\
        <email>fake@example.com</email></author></entry>
        """)
    }

    func testAtomCategory() {
        let feed = Atom(
            .category(
                .term("swift"),
                .scheme("https://example.com/schemes/swift"),
                .label("Swift")
            ),
            .entry(
                .category(
                    .term("swift"),
                    .scheme("https://example.com/schemes/swift"),
                    .label("Swift")
                )
            )
        )
        assertEqualAtomFeedContent(feed, """
        <category term="swift" \
        scheme="https://example.com/schemes/swift" \
        label="Swift"/>\
        <entry><category term="swift" \
        scheme="https://example.com/schemes/swift" \
        label="Swift"/></entry>
        """)
    }
// TODO: Test DSL and normal text.
    func testAtomContentWithText() {
        let feed = Atom(
            .entry(
                .content(
                    .type(.text),
                    "The text of my post"
                )
            ),
            .entry(
                .content(
                    .type(.media(type: "audio/mpeg")),
                    .src("https://example.com/audio/my-audio.mp3")
                )
            )
        )
        assertEqualAtomFeedContent(feed, """
        <entry><content type="text">The text of my post</content></entry>\
        <entry><content type="audio/mpeg" \
        src="https://example.com/audio/my-audio.mp3"></content></entry>
        """)
    }

    func testAtomContentWithDSL() {
        let feed = Atom(
            .entry(
                .content(
                    .h1("Heading"),
                    .p(
                        .em("Emphasized"),
                        .text(" & "),
                        .strong("strong"),
                        .text(" text")
                    )
                )
            )
        )
        assertEqualAtomFeedContent(feed, """
        <entry><content type="html">&lt;h1&gt;Heading&lt;/h1&gt;&lt;p&gt;&lt;em&gt;Emphasized&lt;/em&gt; &amp; &lt;strong&gt;strong&lt;/strong&gt; text&lt;/p&gt;</content></entry>
        """)
    }

    func testAtomContributor() {
        let feed = Atom(
            .contributor(
                .name("John Sundell"),
                .uri("https://example.com"),
                .email("fake@example.com")
            ),
            .entry(
                .contributor(
                    .name("John Sundell"),
                    .uri("https://example.com"),
                    .email("fake@example.com")
                )
            )
        )
        assertEqualAtomFeedContent(feed, """
        <contributor><name>John Sundell</name>\
        <uri>https://example.com</uri>\
        <email>fake@example.com</email></contributor>\
        <entry><contributor><name>John Sundell</name>\
        <uri>https://example.com</uri>\
        <email>fake@example.com</email></contributor></entry>
        """)
    }

    func testAtomGenerator() {
        let feed = Atom(
            .generator(
                .uri("https://github.com/johnsundell/publish"),
                .version("1.0"),
                "Plot by John Sundell"
            )
        )
        assertEqualAtomFeedContent(feed, """
        <generator uri="https://github.com/johnsundell/publish" \
        version="1.0">Plot by John Sundell</generator>
        """)
    }

    func testAtomIcon() {
        let feed = Atom(.icon("/img/icon.png"))
        assertEqualAtomFeedContent(feed, """
        <icon>/img/icon.png</icon>
        """)
    }

    func testAtomId() {
        let feed = Atom(
            .id("https://example.com/"),
            .entry(.id("https://example.com/posts/my-post/"))
        )
        assertEqualAtomFeedContent(feed, """
        <id>https://example.com/</id>\
        <entry><id>https://example.com/posts/my-post/</id></entry>
        """)
    }

    func testAtomLink() {
        let feed = Atom(
            .link(
                .href("https://example.com/"),
                .rel(.alternate),
                .hreflang(.english)
            ),
            .link(
                .href("https://example.com/feed.atom"),
                .rel(.`self`)
            ),
            .link(
                .href("https://example.com/address/1"),
                .rel(.uri("https://example.com/rels/address"))
            ),
            .entry(
                .link(
                    .href("https://example.com/img/dog.jpeg"),
                    .rel(.related),
                    .title("A picture of my dog."),
                    .type("image/jpeg"),
                    .length(16777216)
                )
            )
        )
        assertEqualAtomFeedContent(feed, """
        <link href="https://example.com/" rel="alternate" hreflang="en"/>\
        <link href="https://example.com/feed.atom" rel="self"/>\
        <link href="https://example.com/address/1" rel="https://example.com/rels/address"/>\
        <entry><link href="https://example.com/img/dog.jpeg" rel="related" \
        title="A picture of my dog." type="image/jpeg" length="16777216"/></entry>
        """)
    }

    func testAtomLogo() {
        let feed = Atom(.logo("/img/logo.png"))
        assertEqualAtomFeedContent(feed, """
        <logo>/img/logo.png</logo>
        """)
    }

    func testAtomPublished() throws {
        let stubs = try Date.makeStubs(withFormattingStyle: .atom)
        let feed = Atom(
            .entry(.published(stubs.date, timeZone: stubs.timeZone))
        )
        assertEqualAtomFeedContent(feed, """
        <entry><published>\(stubs.expectedString)</published></entry>
        """)
    }

    func testAtomRights() {
        let feed = Atom(
            .rights("© John Sundell 2020"),
            .entry(.rights("© John Sundell 2020"))
        )
        assertEqualAtomFeedContent(feed, """
        <rights>© John Sundell 2020</rights>\
        <entry><rights>© John Sundell 2020</rights></entry>
        """)
    }

    func testAtomSource() {
        let feed = Atom(
            .entry(
                .source(
                    .author(.name("John Sundell")),
                    .rights("© John Sundell 2020")
                )
            )
        )
        assertEqualAtomFeedContent(feed, """
        <entry><source><author><name>John Sundell</name></author>\
        <rights>© John Sundell 2020</rights></source></entry>
        """)
    }

    func testAtomSubtitle() {
        let feed = Atom(.subtitle("A website about stuff"))
        assertEqualAtomFeedContent(feed, """
        <subtitle>A website about stuff</subtitle>
        """)
    }

    func testAtomSummary() {
        let feed = Atom(.entry(.summary("A post about stuff")))
        assertEqualAtomFeedContent(feed, """
        <entry><summary>A post about stuff</summary></entry>
        """)
    }

    func testAtomTitle() {
        let feed = Atom(
            .title(.type(.text), "My Website"),
            .entry(.title("My Post"))
        )
        assertEqualAtomFeedContent(feed, """
        <title type="text">My Website</title>\
        <entry><title>My Post</title></entry>
        """)
    }

    func testAtomUpdated() throws {
        let stubs = try Date.makeStubs(withFormattingStyle: .atom)
        let feed = Atom(
            .updated(stubs.date, timeZone: stubs.timeZone),
            .entry(.updated(stubs.date, timeZone: stubs.timeZone))
        )
        assertEqualAtomFeedContent(feed, """
        <updated>\(stubs.expectedString)</updated>\
        <entry><updated>\(stubs.expectedString)</updated></entry>
        """)
    }
}

extension AtomTests {
    static var allTests: Linux.TestList<AtomTests> {
        [
            ("testEmptyAtomFeed", testEmptyAtomFeed),
            ("testAtomXMLAttributes", testAtomXMLAttributes),
            ("testAtomAuthor", testAtomAuthor),
            ("testAtomCategory", testAtomCategory),
            ("testAtomContentWithText", testAtomContentWithText),
            ("testAtomContentWithDSL", testAtomContentWithDSL),
            ("testAtomContributor", testAtomContributor),
            ("testAtomGenerator", testAtomGenerator),
            ("testAtomIcon", testAtomIcon),
            ("testAtomId", testAtomId),
            ("testAtomLink", testAtomLink),
            ("testAtomLogo", testAtomLogo),
            ("testAtomPublished", testAtomPublished),
            ("testAtomRights", testAtomRights),
            ("testAtomSource", testAtomSource),
            ("testAtomSubtitle", testAtomSubtitle),
            ("testAtomSummary", testAtomSummary),
            ("testAtomTitle", testAtomTitle),
            ("testAtomUpdated", testAtomUpdated),
        ]
    }
}
