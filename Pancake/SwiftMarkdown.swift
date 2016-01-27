//
//  SwiftMarkdown.swift
//  Pancake
//
//  Created by JPMartha on 2016/01/21.
//  Copyright © 2016 JPMartha. All rights reserved.
//

import Foundation
import SourceKittenFramework

class SwiftMarkdown {
    static let testPath = NSHomeDirectory() + "/Pancake/DemoApp/Documentation"
    static let classTemplate = SwiftMarkdownTemplate(fileName: "Class.md")?.markdownString
    static let methodTemplate = SwiftMarkdownTemplate(fileName: "Method.md")?.markdownString
    static let commentTemplate = SwiftMarkdownTemplate(fileName: "Comment.md")?.markdownString
    static let declarationTemplate = SwiftMarkdownTemplate(fileName: "Declaration.md")?.markdownString
    static let parametersTemplate = SwiftMarkdownTemplate(fileName: "Parameters.md")?.markdownString
    static let returnValueTemplate = SwiftMarkdownTemplate(fileName: "ReturnValue.md")?.markdownString
    static let seeAlsoTemplate = SwiftMarkdownTemplate(fileName: "SeeAlso.md")?.markdownString
    
    static func classMarkdownWithSwiftModule(swiftObject: SwiftObject) -> String? {
        guard var classMarkdownString = classTemplate else {
            return nil
        }
        guard let name = swiftObject.name else {
            return nil
        }
        
        classMarkdownString = classMarkdownString.stringByReplacingOccurrencesOfString("%name%", withString: name)
        
        return classMarkdownString
    }
    
    static func methodMarkdownWithSwiftObject(swiftObject: SwiftObject) -> String {
        guard var methodMarkdownString = methodTemplate else {
            return ""
        }
        guard let name = swiftObject.name else {
            return ""
        }
        
        methodMarkdownString = methodMarkdownString.stringByReplacingOccurrencesOfString("%name%", withString: name)
        
        methodMarkdownString = methodMarkdownString.stringByReplacingOccurrencesOfString("%Comment.md%", withString: commentMarkdown(swiftObject))
        
        methodMarkdownString = methodMarkdownString.stringByReplacingOccurrencesOfString("%Declaration.md%", withString: declarationMarkdown(swiftObject))
        
        methodMarkdownString = methodMarkdownString.stringByReplacingOccurrencesOfString("%Parameters.md%", withString: parametersMarkdown(swiftObject))
        
        methodMarkdownString = methodMarkdownString.stringByReplacingOccurrencesOfString("%ReturnValue.md%", withString: returnValueMarkdown(swiftObject))
        
        methodMarkdownString = methodMarkdownString.stringByReplacingOccurrencesOfString("%SeeAlso.md%", withString: seeAlsoMarkdown(swiftObject))
        
        
        return methodMarkdownString
    }
    
    // MARK: -
    
    static func commentMarkdown(swiftObject: SwiftObject) -> String {
        guard var commentMarkdownString = commentTemplate else {
            return ""
        }
        
        if let doc_comment = swiftObject.doc_comment {
            commentMarkdownString = commentMarkdownString.stringByReplacingOccurrencesOfString("%doc_comment%", withString: doc_comment)
        } else {
            return ""
        }
        
        return commentMarkdownString
    }
    
    static func declarationMarkdown(swiftObject: SwiftObject) -> String {
        guard var declarationMarkdownString = declarationTemplate else {
            return ""
        }
        
        if let parsed_declaration = swiftObject.parsed_declaration {
            declarationMarkdownString = declarationMarkdownString.stringByReplacingOccurrencesOfString("%parsed_declaration%", withString: parsed_declaration)
        } else {
            return ""
        }
        
        return declarationMarkdownString
    }
    
    static func parametersMarkdown(swiftObject: SwiftObject) -> String {
        return ""
    }
    
    static func returnValueMarkdown(swiftObject: SwiftObject) -> String {
        return ""
    }
    
    static func seeAlsoMarkdown(swiftObject: SwiftObject) -> String {
        return ""
    }
    
    // MARK: -
    
    static func outputMarkdown() {
        for swiftFile in SwiftDocsParser.swiftFiles {
            for swiftObject in swiftFile.substructure {
                writeSwiftMarkdownFile(swiftObject)
            }
        }
    }
    
    static func writeSwiftMarkdownFile(swiftObject: SwiftObject) {
        var moduleString = classMarkdownWithSwiftModule(swiftObject)
        let _ = swiftObject.substructure?.map {
            moduleString = moduleString! + methodMarkdownWithSwiftObject($0)
        }

        guard let string = moduleString else {
            return
        }
        guard let name = swiftObject.name else {
            return
        }
        
        let filePath = testPath + "/" + name + ".md"
        do {
            try string.writeToFile(filePath, atomically: true, encoding: NSUTF8StringEncoding)
        } catch let error as NSError {
            print(error.debugDescription)
            return
        }
        
        print(filePath)
    }
}
