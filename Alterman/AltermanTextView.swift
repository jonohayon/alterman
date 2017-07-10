//
//  AltermanTextView.swift
//  Alterman
//
//  Created by Jonathan Ohayon on 09/07/2017.
//  Copyright © 2017 Jonathan Ohayon. All rights reserved.
//

import Cocoa

class AltermanTextView: NSTextView {
  override init (frame frameRect: NSRect, textContainer container: NSTextContainer?) {
    let textStorage = NSTextStorage()
    let layoutManager = AltermanLayoutManager()
    textStorage.addLayoutManager(layoutManager)
    let textContainer = NSTextContainer(size: frameRect.size)
    textContainer.heightTracksTextView = true
    textContainer.widthTracksTextView = true
    layoutManager.addTextContainer(textContainer)
    super.init(frame: frameRect, textContainer: textContainer)
  }
  
  required init? (coder: NSCoder) {
    super.init(coder: coder)
  }

  override func draw (_ dirtyRect: NSRect) {
    super.draw(dirtyRect)
  }

  override func didChangeText () {
    let string = self.string!
    string.enumerateSubstrings(in: string.startIndex..<string.endIndex, options: .byLines) { (substring, substringRange, _, _) in
      let lexed = AlterMarkdown.lex(line: substring!)
      if lexed.count > 0 {
        let firstToken = lexed[0]
        let (range, attrs) = self.lineStart(string, token: firstToken, substringRange: substringRange)
        self.textStorage?.addAttributes(attrs, range: range)
      }
    }
  }

  // Return the NSAttributedString attributes for the current line
  func lineStart (_ string: String, token: AlterToken, substringRange: Range<String.Index>) -> (NSRange, [String: Any]) {
    switch token {
    case .section (let text):
      let range = NSRange.fromString(range: substringRange, text: string, substring: text)
      let attrs = [NSFontAttributeName: FontManager.shared.section()]
      return (range, attrs)
    case .subsection (let text):
      let range = NSRange.fromString(range: substringRange, text: string, substring: text)
      let attrs = [NSFontAttributeName: FontManager.shared.subsection()]
      return (range, attrs)
    case .subsubsection(let text):
      let range = NSRange.fromString(range: substringRange, text: string, substring: text)
      let attrs = [NSFontAttributeName: FontManager.shared.subsubsection()]
      return (range, attrs)
    case .latexLine (let text):
      let range = NSRange.fromString(range: substringRange, text: string, substring: text)
      return self.makeLatexBlock(range, text)
    default:
      return (NSMakeRange(0, 0), [:])
    }
  }

  func makeSection (type: SectionType, range substringRange: Range<String.Index>, text string: String, substring text: String) -> (NSRange, [String: Any]) {
    let range = NSRange.fromString(range: substringRange, text: string, substring: text)
    switch type {
    case .section:
      return (range, [NSFontAttributeName: FontManager.shared.section()])
    case .subsection:
      return (range, [NSFontAttributeName: FontManager.shared.subsection()])
    case .subsubsection:
      return (range, [NSFontAttributeName: FontManager.shared.subsubsection()])
    }
  }

  func makeLatexBlock (_ range: NSRange, _ text: String) -> (NSRange, [String: Any]) {
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.alignment = .center
    paragraphStyle.baseWritingDirection = .leftToRight
    let attrs = [
      NSFontAttributeName: FontManager.shared.latex(),
      NSParagraphStyleAttributeName: paragraphStyle,
      NSForegroundColorAttributeName: ThemeManager.shared.codeText(),
      NSBackgroundColorAttributeName: ThemeManager.shared.codeBackground()
    ]
    return (range, attrs)
  }

  override func setSelectedRange (_ charRange: NSRange, affinity: NSSelectionAffinity, stillSelecting stillSelectingFlag: Bool) {
    let oldRange = self.selectedRange()
    self.layoutManager?.removeTemporaryAttribute(NSBackgroundColorAttributeName, forCharacterRange: oldRange)
    self.layoutManager?.addTemporaryAttribute(NSBackgroundColorAttributeName, value: NSColor.black, forCharacterRange: charRange)
    super.setSelectedRange(charRange, affinity: affinity, stillSelecting: stillSelectingFlag)
  }
}
