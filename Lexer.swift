//
//  Lexer.swift
//  Alterman
//
//  Created by Jonathan Ohayon on 09/07/2017.
//  Copyright © 2017 Jonathan Ohayon. All rights reserved.
//

import Foundation

typealias TokenGenerator = (String) -> AlterToken?

class AlterMarkdown {
  fileprivate static let tokenList: [(String, TokenGenerator)] = [
    ("^\n$", { _ in .newline }),
    ("^###( |)(.*)$", { .subsubsection($0) }),
    ("^##( |)(.*)$", { .subsection($0) }),
    ("^#( |)(.*)$", { .section($0) }),
    ("^\\$\\$([^$]*)\\$\\$", { .latex($0) }),
    ("\\*(?![\n\t ])[^*](?![\n\t ])\\*", { .bold($0) }),
    ("_([^_]*)_", { .italic($0) })
  ]

  static func lex (line: String) -> [AlterToken] {
    var tokens: [AlterToken] = []
    var content = line

    while content.utf16.count > 0 {
      var matched = false

      for (pattern, generator) in AlterMarkdown.tokenList {
        if let lexed = lexToken(content: content, pattern: pattern, tokenGen: generator) {
          let (token, index) = lexed
          if let t = token { tokens.append(t) }
          content = content.substring(from: index)
          matched = true
          break
        }
      }

      if !matched {
        let index = content.index(after: content.startIndex)
        tokens.append(.char(content.substring(to: index)))
        content = content.substring(from: index)
      }
    }

    return tokens
  }

  fileprivate static func lexToken (content: String, pattern: String, tokenGen: TokenGenerator) -> (AlterToken?, String.Index)? {
    let expression = try! NSRegularExpression(pattern: "\(pattern)", options: [])
    let range = NSMakeRange(0, content.utf16.count)
    if let m = expression.firstMatch(in: content, options: [], range: range) {
      let startIndex = content.index(content.startIndex, offsetBy: m.range.location)
      let endIndex = content.index(startIndex, offsetBy: m.range.length)
      let matched = content[startIndex..<endIndex]
      return (token: tokenGen(matched), index: endIndex)
    } else {
      return nil
    }
  }
}
