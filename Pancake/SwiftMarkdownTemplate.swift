//
//  SwiftMarkdownTemplate.swift
//  Pancake
//
//  Created by JPMartha on 2016/01/25.
//  Copyright © 2016 JPMartha. All rights reserved.
//

import Foundation

struct SwiftMarkdownTemplate {
    let templateFileDirectoryPath = NSHomeDirectory() + "/Pancake/Templates/"
    let markdownString: String!
    
    init?(fileName: String) {
        let markdownPath = templateFileDirectoryPath + fileName
        let markdownString: String?
        do {
            markdownString = try String(contentsOfFile: markdownPath, encoding: NSUTF8StringEncoding)
        } catch let error as NSError {
            print(error.debugDescription)
            return nil
        }
        
        self.markdownString = markdownString
    }
}
