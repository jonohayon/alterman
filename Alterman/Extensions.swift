//
//  Extensions.swift
//  Alterman
//
//  Created by Jonathan Ohayon on 07/07/2017.
//  Copyright © 2017 Jonathan Ohayon. All rights reserved.
//

import Foundation

extension String {
  static var newline = NSAttributedString(string: "\n")

  static func - (lhs: String, rhs: String) -> String {
    let range = lhs.range(of: rhs)
    if range != nil {
      return lhs.replacingCharacters(in: range!, with: "")
    } else {
      return lhs
    }
  }

  func createRange (range: NSRange) -> Range<String.Index> {
    let startIndex = self.index(self.startIndex, offsetBy: range.location)
    let endIndex = self.index(startIndex, offsetBy: range.length)
    return startIndex..<endIndex
  }
}

extension NSRange {
  static func fromString (range: Range<String.Index>, text string: String, substring: String) -> NSRange {
    let startIndex = string.distance(from: string.startIndex, to: range.lowerBound)
    return NSMakeRange(startIndex, substring.utf16.count)
  }

  static func from (string: String) -> NSRange {
    return NSMakeRange(0, string.utf16.count)
  }
}
