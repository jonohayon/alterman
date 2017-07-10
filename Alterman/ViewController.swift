//
//  ViewController.swift
//  Alterman
//
//  Created by Jonathan Ohayon on 07/07/2017.
//  Copyright © 2017 Jonathan Ohayon. All rights reserved.
//

import Cocoa

class ViewController: NSViewController, NSTextStorageDelegate {
  @IBOutlet var textView: NSTextView!

  override func viewDidLoad() {
    super.viewDidLoad()
    self.textView.isEditable = true
    self.textView.isSelectable = true
    self.textView.baseWritingDirection = .rightToLeft
    self.textView.userInterfaceLayoutDirection = .rightToLeft
    self.textView.textStorage!.delegate = self
  }

  override var representedObject: Any? {
    didSet {
      // Update the view, if already loaded.
    }
  }
}

