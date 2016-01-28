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

class SwiftDocsParser {
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
                    if let dic = anyObject as? NSDictionary {
                        if let dic1 = dic[filePath] {
                            let swiftObject: SwiftObject? = try? decode(dic1)
                            if let file = swiftObject {
                                self.swiftObjects.append(file)
                            }
                        }
                    }
                }
            }
        }
        SwiftMarkdown.outputMarkdown()
    }
}
