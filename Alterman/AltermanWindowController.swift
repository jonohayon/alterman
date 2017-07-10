//
//  AltermanWindowController.swift
//  Alterman
//
//  Created by Jonathan Ohayon on 10/07/2017.
//  Copyright © 2017 Jonathan Ohayon. All rights reserved.
//

import Cocoa

class AltermanWindowController: NSWindowController {
  override func windowDidLoad() {
    super.windowDidLoad()
    self.window?.titleVisibility = .hidden
  }
}
