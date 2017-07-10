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
  var extraBold: String? { get }
}

struct Fonts {
  struct assistant: Font {
    static var name: String = "Assistant"

    var extraLight: String = "\(Fonts.assistant.name)-ExtraLight"
    var light: String = "\(Fonts.assistant.name)-Light"
    var regular: String = "\(Fonts.assistant.name)-Regular"
    var semiBold: String = "\(Fonts.assistant.name)-SemiBold"
    var bold: String = "\(Fonts.assistant.name)-Bold"
    var extraBold: String? = "\(Fonts.assistant.name)-ExtraBold"
  }

  struct firaCode: Font {
    static var name: String = "FiraCode"

    var extraLight: String = ""
    var light: String = "\(Fonts.firaCode.name)-Light"
    var regular: String = "\(Fonts.firaCode.name)-Regular"
    var semiBold: String = "\(Fonts.firaCode.name)-Medium"
    var bold: String = "\(Fonts.firaCode.name)-Bold"
    var extraBold: String? = nil
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

  func section () -> NSFont {
    return NSFont(name: self.font.extraBold!, size: 22)!
  }

  func subsection () -> NSFont {
    return NSFont(name: self.font.bold, size: 18)!
  }

  func subsubsection () -> NSFont {
    return NSFont(name: self.font.semiBold, size: 16)!
  }

  func body () -> NSFont {
    return NSFont(name: self.font.regular, size: 15)!
  }

  func latex () -> NSFont {
    return NSFont(name: self.monospace.light, size: 15)!
  }

  static func printFonts (of family: String = "") {
    let manager = NSFontManager.shared()
    print(manager.availableMembers(ofFontFamily: family) ?? manager.availableFontFamilies)
  }
}
