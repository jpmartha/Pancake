//
//  ViewController.swift
//  DemoApp
//
//  Created by JPMartha on 2016/01/20.
//  Copyright © 2016 JPMartha. All rights reserved.
//

import Cocoa
import Pancake

enum TestEnumerationType {
    case Enumeration0
    case Enumeration1
}

class ViewController: NSViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    @IBAction func buttonPushed(sender: NSButton) {
        pancake()
    }
    
    func pancake() {
        Pancake.docs()
    }
}
