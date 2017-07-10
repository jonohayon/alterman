//
//  AltermanLayoutManager.swift
//  Alterman
//
//  Created by Jonathan Ohayon on 10/07/2017.
//  Copyright © 2017 Jonathan Ohayon. All rights reserved.
//

import Cocoa

class AltermanLayoutManager: NSLayoutManager {
  override func fillBackgroundRectArray(_ rectArray: UnsafePointer<NSRect>, count rectCount: Int, forCharacterRange charRange: NSRange, color: NSColor) {
    super.fillBackgroundRectArray(rectArray, count: rectCount, forCharacterRange: charRange, color: NSColor.black)
  }
}
