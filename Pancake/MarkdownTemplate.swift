//
//  MarkdownTemplate.swift
//  Pancake
//
//  Created by JPMartha on 2016/01/25.
//  Copyright © 2016 JPMartha. All rights reserved.
//

import Foundation

struct MarkdownTemplate {
    let fileDirectory = NSHomeDirectory() + "/Pancake/Templates"
    let markdownString: String
    
    init?(fileName: String) {
        let filePath = fileDirectory + "/" + fileName
        do {
            self.markdownString = try String(contentsOfFile: filePath, encoding: NSUTF8StringEncoding)
        } catch let error as NSError {
            print(error.debugDescription)
            return nil
        }
    }
}
