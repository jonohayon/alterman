//
//  Tokens.swift
//  Alterman
//
//  Created by Jonathan Ohayon on 09/07/2017.
//  Copyright © 2017 Jonathan Ohayon. All rights reserved.
//

import Foundation

enum AlterToken {
  case section (String)
  case subsection (String)
  case subsubsection (String)
  case bold (String)
  case italic (String)
  case latex (String)
  case comment (String)
  case char (String) // All the other characters
  case newline
}
