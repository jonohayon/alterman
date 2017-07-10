//
//  AltermanTextView.swift
//  Alterman
//
//  Created by Jonathan Ohayon on 09/07/2017.
//  Copyright © 2017 Jonathan Ohayon. All rights reserved.
//

import Cocoa

class AltermanTextView: NSTextView {
  override func draw(_ dirtyRect: NSRect) {
    super.draw(dirtyRect)
    self.usesFontPanel = false
    self.isRichText = false
  }

  override func didChangeText() {
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
      let startIndex = string.distance(from: string.startIndex, to: substringRange.lowerBound)
      let range = NSMakeRange(startIndex, text.characters.count)
      let attrs = [NSFontAttributeName: FontManager.shared.title()]
      return (range, attrs)
    case .subsection (let text):
      let startIndex = string.distance(from: string.startIndex, to: substringRange.lowerBound)
      let range = NSMakeRange(startIndex, text.characters.count)
      let attrs = [NSFontAttributeName: FontManager.shared.subtitle()]
      return (range, attrs)
    case .latex (let text):
      let startIndex = string.distance(from: string.startIndex, to: substringRange.lowerBound)
      let range = NSMakeRange(startIndex, text.characters.count)
      let paragraphStyle = NSMutableParagraphStyle()
      paragraphStyle.alignment = .center
      paragraphStyle.baseWritingDirection = .leftToRight
      let attrs = [NSFontAttributeName: FontManager.shared.latex(), NSParagraphStyleAttributeName: paragraphStyle]
      return (range, attrs)
    default:
      return (NSMakeRange(0, string.characters.count), [NSFontAttributeName: FontManager.shared.body()])
    }
  }
}
