//
//  RichTextViewComponent+FontSizeTests.swift
//  RichTextKitTests
//
//  Created by Daniel Saidi on 2022-12-06.
//  Copyright © 2022-2023 Daniel Saidi. All rights reserved.
//

#if canImport(UIKit)
import UIKit
#endif

#if os(macOS)
import AppKit
#endif

#if os(iOS) || os(macOS) || os(tvOS)
import RichTextKit
import XCTest

class RichTextViewComponent_FontSizeTests: XCTestCase {

    var textView: RichTextViewComponent!

    let size: CGFloat = 666
    let font = FontRepresentable.systemFont(ofSize: 666)
    let allRange = NSRange(location: 0, length: 11)
    let noRange = NSRange(location: 0, length: 0)
    let selectedRange = NSRange(location: 4, length: 3)

    override func setUp() {
        textView = RichTextView()
        textView.setup(
            with: NSAttributedString(string: "foo bar baz"),
            format: .rtf
        )
    }

    func assertEqualFont(_ attr: Any?) {
        XCTAssertEqual(attr as? FontRepresentable, font)
    }

    func assertEqualFontSize(_ attr: Any?) {
        XCTAssertEqual((attr as? FontRepresentable)?.pointSize, size)
    }

    func assertNonEqualFont(_ attr: Any?) {
        XCTAssertNotEqual(attr as? FontRepresentable, font)
    }

    func assertNonEqualFontSize(_ attr: Any?) {
        XCTAssertNotEqual((attr as? FontRepresentable)?.pointSize, size)
    }


    func testCurrentFontWorksForSelectedRange() {
        textView.setSelectedRange(selectedRange)
        textView.setCurrentFont(to: font)
        XCTAssertEqual(textView.currentFont, font)
        XCTAssertEqual(textView.currentFontName, font.fontName)
        assertEqualFont(textView.currentRichTextAttribute(.font))
        assertEqualFont(textView.richTextAttributes(at: selectedRange)[.font])
        assertEqualFont(textView.typingAttributes[.font])
    }

    func testCurrentFontWorksForNoSelectedRange() {
        textView.setSelectedRange(noRange)
        textView.setCurrentFont(to: font)
        #if os(iOS) || os(tvOS)
        XCTAssertEqual(textView.currentFont, font)
        XCTAssertEqual(textView.currentFontName, font.fontName)
        assertEqualFont(textView.currentRichTextAttribute(.font))
        #endif
        assertNonEqualFont(textView.richTextAttributes(at: selectedRange)[.font])
        assertEqualFont(textView.typingAttributes[.font])
    }


    func testCurrentFontSizeWorksForSelectedRange() {
        textView.setSelectedRange(selectedRange)
        textView.setCurrentFontSize(to: size)
        XCTAssertEqual(textView.currentFontSize, size)
        assertEqualFontSize(textView.currentRichTextAttribute(.font))
        assertEqualFontSize(textView.richTextAttributes(at: selectedRange)[.font])
        assertEqualFontSize(textView.typingAttributes[.font])
    }

    func testCurrentFontSizeWorksForNoSelectedRange() {
        textView.setSelectedRange(noRange)
        textView.setCurrentFontSize(to: size)
        #if os(iOS) || os(tvOS)
        XCTAssertEqual(textView.currentFontSize, size)
        assertEqualFontSize(textView.currentRichTextAttribute(.font))
        #endif
        assertNonEqualFontSize(textView.richTextAttributes(at: selectedRange)[.font])
        assertEqualFontSize(textView.typingAttributes[.font])
    }


    func testDecrementFontSizeWorksForSelectedRange() {
        textView.setSelectedRange(allRange)
        textView.setCurrentFontSize(to: size)
        textView.setSelectedRange(selectedRange)
        textView.decrementCurrentFontSize()
        XCTAssertEqual(textView.currentFontSize, size - 1)
        textView.setSelectedRange(allRange)
        XCTAssertEqual(textView.currentFontSize, size)
    }

    func testDecrementFontSizeWorksForNoSelectedRange() {
        textView.setSelectedRange(allRange)
        textView.setCurrentFontSize(to: size)
        textView.setSelectedRange(noRange)
        textView.decrementCurrentFontSize(points: 2)
        #if os(iOS) || os(tvOS)
        XCTAssertEqual(textView.currentFontSize, size - 2)
        #endif
        textView.setSelectedRange(allRange)
        XCTAssertEqual(textView.currentFontSize, size)
    }


    func testIncrementFontSizeWorksForSelectedRange() {
        textView.setSelectedRange(allRange)
        textView.setCurrentFontSize(to: size)
        textView.setSelectedRange(selectedRange)
        textView.incrementCurrentFontSize()
        XCTAssertEqual(textView.currentFontSize, size + 1)
        textView.setSelectedRange(allRange)
        XCTAssertEqual(textView.currentFontSize, size)
    }

    func testIncrementFontSizeWorksForNoSelectedRange() {
        textView.setSelectedRange(allRange)
        textView.setCurrentFontSize(to: size)
        textView.setSelectedRange(noRange)
        textView.incrementCurrentFontSize(points: 2)
        #if os(iOS) || os(tvOS)
        XCTAssertEqual(textView.currentFontSize, size + 2)
        #endif
        textView.setSelectedRange(allRange)
        XCTAssertEqual(textView.currentFontSize, size)
    }
}
#endif
