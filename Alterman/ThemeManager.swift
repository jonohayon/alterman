//
//  ThemeManager.swift
//  Alterman
//
//  Created by Jonathan Ohayon on 10/07/2017.
//  Copyright © 2017 Jonathan Ohayon. All rights reserved.
//

import Cocoa

enum Theme {
  case paper
  case sepia
  case dark
  case other (String)
}

class ThemeManager {
  static let shared: ThemeManager = ThemeManager(chosenTheme: .paper)
  var theme: Theme

  init (chosenTheme: Theme) { self.theme = chosenTheme }

  func getColors () -> (NSColor, NSColor, NSColor, NSColor) {
    switch self.theme {
    case .paper:
      return self.paperTheme()
    default:
      return self.paperTheme()
    }
  }

  private func paperTheme () -> (NSColor, NSColor, NSColor, NSColor) {
    let background: NSColor = NSColor.white
    let text: NSColor = NSColor.black.withAlphaComponent(0.8)
    let codeBackground: NSColor = text
    let codeText: NSColor = background
    return (background, text, codeBackground, codeText)
  }

  func background () -> NSColor {
    let (background, _, _, _) = self.getColors()
    return background
  }

  func text () -> NSColor {
    let (_, text, _, _) = self.getColors()
    return text
  }

  func codeBackground () -> NSColor {
    let (_, _, codeBackground, _) = self.getColors()
    return codeBackground
  }

  func codeText () -> NSColor {
    let (_, _, _, codeText) = self.getColors()
    return codeText
  }
}
