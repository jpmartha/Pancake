//
//  SwiftMarkdown.swift
//  Pancake
//
//  Created by JPMartha on 2016/01/21.
//  Copyright © 2016 JPMartha. All rights reserved.
//

import Foundation

class SwiftMarkdown {
    static let testPath = NSHomeDirectory() + "/Pancake/DemoApp/Documentation"

    static func outputMarkdown() {
        for swiftFile in SwiftDocsParser.swiftFiles {
            for swiftObject in swiftFile.substructure {
                
                writeSwiftMarkdownFile(swiftObject)
                
                print(swiftObject.kind)
                print(swiftObject.parsed_declaration)
                print(swiftObject.name)
                print(swiftObject.accessibility)
            }
        }
    }
    
    static func writeSwiftMarkdownFile(swiftObject: SwiftObject) {
        let name = "# " + swiftObject.name
        let parsed_declaration = "##### Declaration\n\n```swift\n" + swiftObject.parsed_declaration + "\n```"
        let fileObject = name + "\n\n" + parsed_declaration + "\n"
        let filePath = testPath + "/" + swiftObject.name + ".md"
        
        do {
            try fileObject.writeToFile(filePath, atomically: true, encoding: NSUTF8StringEncoding)
        } catch let error as NSError {
            print(error.debugDescription)
            return
        }
        
        print(filePath)
    }
}
