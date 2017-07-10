//
//  ViewController.swift
//  Alterman
//
//  Created by Jonathan Ohayon on 07/07/2017.
//  Copyright © 2017 Jonathan Ohayon. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
  @IBOutlet var textView: NSTextView!

  override func viewDidLoad() {
    super.viewDidLoad()
    self.prepare()
  }

  override var representedObject: Any? {
    didSet {
      // Update the view, if already loaded.
    }
  }

  func prepare () {
    self.prepareTextView()
  }

  func prepareTextView () {
    // Can edit, select, no font panel (in app control), doesn't have rich text support
    self.textView.isEditable = true
    self.textView.isSelectable = true
    self.textView.usesFontPanel = false
    self.textView.isRichText = false
    // Base writing direction - ltr is enabled for LaTeX snippets
    self.textView.baseWritingDirection = .rightToLeft
    self.textView.userInterfaceLayoutDirection = .rightToLeft
    // Font
    self.textView.font = FontManager.shared.body()
    // Inset
    self.textView.textContainerInset = NSSize(width: 50, height: 65)
    // Paragraph style
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.lineSpacing = 1.75
    self.textView.defaultParagraphStyle = paragraphStyle
    // Colors
    let (background, text, _, _) = ThemeManager.shared.getColors()
    self.textView.backgroundColor = background
    self.textView.textColor = text
  }
}

