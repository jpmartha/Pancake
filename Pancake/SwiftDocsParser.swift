//
//  SwiftDocsParser.swift
//  Pancake
//
//  Created by JPMartha on 2016/01/22.
//  Copyright © 2016 JPMartha. All rights reserved.
//

import Foundation
import SourceKittenFramework
import Himotoki

final class SwiftDocsParser {
    static var swiftObjects = [SwiftObject]()
    
    static func parse(SwiftDocs swiftDocs: [SwiftDocs]) {
        guard swiftDocs.count > 0 else {
            return
        }

        for swiftDoc in swiftDocs {
            let string = swiftDoc.description
            print(string)
            if let data = string.dataUsingEncoding(NSUTF8StringEncoding) {
                var anyObject: AnyObject
                do {
                    anyObject = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
                } catch let error as NSError {
                    anyObject = error.debugDescription
                }
                
                if let filePath = swiftDoc.file.path {
                    if let dictionary = anyObject as? NSDictionary {
                        if let filePathValue = dictionary[filePath] {
                            let swiftObject: SwiftObject? = try? decode(filePathValue)
                            if let file = swiftObject {
                                self.swiftObjects.append(file)
                            }
                        }
                    }
                }
            }
        }
        Markdown.outputMarkdown()
    }
}
