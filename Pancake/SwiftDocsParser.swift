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

        swiftDocs.forEach {
            let string = $0.description
            print(string)
            if let data = string.dataUsingEncoding(NSUTF8StringEncoding) {
                var anyObject: AnyObject
                do {
                    anyObject = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
                } catch let error as NSError {
                    anyObject = error.debugDescription
                }
                
                if let filePath = $0.file.path,
                    dictionary = anyObject as? NSDictionary,
                    filePathValue = dictionary[filePath] {
                    let swiftObject: SwiftObject? = try? decode(filePathValue)
                    if let file = swiftObject {
                        self.swiftObjects.append(file)
                    }
                }
            }
        }
        Markdown.outputMarkdown()
    }
}
