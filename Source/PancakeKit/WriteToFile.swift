//
//  WriteToFile.swift
//  Pancake
//
//  Created by JPMartha on 2016/01/29.
//  Copyright © 2016 JPMartha. All rights reserved.
//

import Foundation

struct CreateDocumentationDirectory {
    static func createDirectoryAtPath(path: String) {
        do {
            try NSFileManager.defaultManager().createDirectoryAtPath(path, withIntermediateDirectories: true, attributes: nil)
        } catch let error as NSError {
            print(error.debugDescription)
            return
        }
    }
}

struct WriteToFile {
    static func writeToFileWithString(string: String, filePath: String) {
        do {
            try string.writeToFile(filePath, atomically: true, encoding: NSUTF8StringEncoding)
        } catch let error as NSError {
            print(error.debugDescription)
            return
        }
    }
}
