//
//  FontManager.swift
//  Alterman
//
//  Created by Jonathan Ohayon on 07/07/2017.
//  Copyright © 2017 Jonathan Ohayon. All rights reserved.
//

import Cocoa

protocol Font {
  static var name: String { get }
  var extraLight: String { get }
  var light: String { get }
  var regular: String { get }
  var semiBold: String { get }
  var bold: String { get }
}

struct Fonts {
  struct assistant: Font {
    static var name: String = "Assistant"

    var extraLight = "\(Fonts.assistant.name)-ExtraLight"
    var light = "\(Fonts.assistant.name)-Light"
    var regular = "\(Fonts.assistant.name)-Regular"
    var semiBold = "\(Fonts.assistant.name)-SemiBold"
    var bold = "\(Fonts.assistant.name)-Bold"
  }

  struct firaCode: Font {
    static var name: String = "FiraCode"

    var extraLight: String = ""
    var light: String = "\(Fonts.firaCode.name)-Light"
    var regular: String = "\(Fonts.firaCode.name)-Regular"
    var semiBold: String = "\(Fonts.firaCode.name)-Medium"
    var bold: String = "\(Fonts.firaCode.name)-Bold"
  }
}

class FontManager {
  static let shared: FontManager = FontManager(font: Fonts.assistant(), monospace: Fonts.firaCode())
  let font: Font
  let monospace: Font

  init (font: Font, monospace: Font) {
    self.font = font
    self.monospace = monospace
  }

  func title () -> NSFont {
    return NSFont(name: self.font.bold, size: 18)!
  }

  func subtitle () -> NSFont {
    return NSFont(name: self.font.semiBold, size: 15)!
  }

  func body () -> NSFont {
    return NSFont(name: self.font.regular, size: 14)!
  }

  func latex () -> NSFont {
    return NSFont(name: self.monospace.regular, size: 14)!
  }

  static func printFonts (of family: String = "") {
    let manager = NSFontManager.shared()
    print(manager.availableMembers(ofFontFamily: family) ?? manager.availableFontFamilies)
  }
}
