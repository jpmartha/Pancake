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
    
    private static func pathMethodMarkdown() -> String? {
        guard let methodMarkdownPath = NSBundle.mainBundle().pathForResource("Methods", ofType: "md") else {
            return nil
        }
        
        let methodMarkdownString: String?
        do {
            methodMarkdownString = try String(contentsOfFile: methodMarkdownPath, encoding: NSUTF8StringEncoding)
        } catch let error as NSError {
            print(error.debugDescription)
            return nil
        }
        
        return methodMarkdownString
    }
    
    static func replaceMethodMarkdown(swiftObject: SwiftObject) -> String? {
        guard let methodMarkdownString = pathMethodMarkdown() else {
            return nil
        }
        
        return methodMarkdownString.stringByReplacingOccurrencesOfString("%name%", withString: swiftObject.name)
    }
    
    static func outputMarkdown() {
        for swiftFile in SwiftDocsParser.swiftFiles {
            for swiftObject in swiftFile.substructure {
                
                writeSwiftMarkdownFile(swiftObject)
                
                print(swiftObject.kind)
                print(swiftObject.parsed_declaration)
                print(swiftObject.doc_comment)
                print(swiftObject.name)
                print(swiftObject.accessibility)
            }
        }
    }
    
    static func writeSwiftMarkdownFile(swiftObject: SwiftObject) {
        let name = "# " + swiftObject.name + "\n\n"
        let doc_comment = swiftObject.doc_comment ?? ""
        let parsed_declaration = "\n\n" + "##### Declaration\n\n```swift\n" + swiftObject.parsed_declaration + "\n```"
        
        let fileObject = name + doc_comment + parsed_declaration + "\n"
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
