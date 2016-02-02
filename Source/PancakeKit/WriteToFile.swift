//
//  WriteToFile.swift
//  Pancake
//
//  Created by JPMartha on 2016/01/29.
//  Copyright © 2016 JPMartha. All rights reserved.
//

import Foundation

struct WriteToFile {
    static func writeToFileWithString(string: String, filePath: String) {
        do {
            try string.writeToFile(filePath, atomically: true, encoding: NSUTF8StringEncoding)
        } catch let error as NSError {
            print(error.debugDescription)
            return
        }
        print(filePath)
    }
}
