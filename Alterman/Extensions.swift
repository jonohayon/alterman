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
}
