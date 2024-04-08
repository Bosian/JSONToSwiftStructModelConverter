//
//  ViewController.swift
//  macOSJsonConverter
//
//  Created by 劉柏賢 on 2018/1/14.
//  Copyright © 2018年 劉柏賢. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var leftTextView: NSTextView!
    @IBOutlet weak var rightTextView: NSTextView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // 避免顏色跑掉
        leftTextView.textColor = NSColor.textColor
        rightTextView.textColor = NSColor.textColor
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    /// Generate Swift model
    @IBAction func onButtonTapped(_ sender: NSButtonCell) {
        let json: String = leftTextView.string
        rightTextView.string = json.jsonDecodableModel
    }
    
    /// Generate Unit test
    @IBAction func onXCUnitTestTapped(_ sender: NSButton) {
        let json: String = leftTextView.string
        rightTextView.string = json.generateUnitTest
    }
}

