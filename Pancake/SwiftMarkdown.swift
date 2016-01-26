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
    static let classTemplate = SwiftMarkdownTemplate(fileName: "Class.md")?.markdownString
    static let methodTemplate = SwiftMarkdownTemplate(fileName: "Method.md")?.markdownString
    static let commentTemplate = SwiftMarkdownTemplate(fileName: "Comment.md")?.markdownString
    static let declarationTemplate = SwiftMarkdownTemplate(fileName: "Declaration.md")?.markdownString
    static let parametersTemplate = SwiftMarkdownTemplate(fileName: "Parameters.md")?.markdownString
    static let returnValueTemplate = SwiftMarkdownTemplate(fileName: "ReturnValue.md")?.markdownString
    static let seeAlsoTemplate = SwiftMarkdownTemplate(fileName: "SeeAlso.md")?.markdownString
    
    static func classMarkdownWithSwiftModule(swiftModule: SwiftModule) -> String? {
        guard var classMarkdownString = classTemplate else {
            return nil
        }
        guard !swiftModule.name.isEmpty else {
            return nil
        }
        
        classMarkdownString = classMarkdownString.stringByReplacingOccurrencesOfString("%name%", withString: swiftModule.name)
        
        if let doc_comment = swiftModule.doc_comment {
            classMarkdownString = classMarkdownString.stringByReplacingOccurrencesOfString("%doc_comment%", withString: doc_comment)
        } else {
            classMarkdownString = classMarkdownString.stringByReplacingOccurrencesOfString("%doc_comment%", withString: "")
        }
        
        if let swiftObject = swiftModule.substructure?.first {
            classMarkdownString = classMarkdownString.stringByReplacingOccurrencesOfString("%methods%", withString: swiftObject.name)
        }
        
        return classMarkdownString
    }
    
    static func methodMarkdownWithSwiftObject(swiftObject: SwiftObject) -> String {
        guard var methodMarkdownString = methodTemplate else {
            return ""
        }
        guard !swiftObject.name.isEmpty else {
            return ""
        }
        
        methodMarkdownString = methodMarkdownString.stringByReplacingOccurrencesOfString("%name%", withString: swiftObject.name)
        
        methodMarkdownString = methodMarkdownString.stringByReplacingOccurrencesOfString("%Comment.md%", withString: commentMarkdown(swiftObject))
        
        methodMarkdownString = methodMarkdownString.stringByReplacingOccurrencesOfString("%Declaration.md%", withString: declarationMarkdown(swiftObject))
        
        return methodMarkdownString
    }
    
    /* 共通化断念
    static func markdownString(target: String, withString replacement: String) -> String {
        guard let markdownString = commentTemplate else {
            return ""
        }
        guard !target.isEmpty else {
            return ""
        }
        
        return markdownString.stringByReplacingOccurrencesOfString(target, withString: replacement)
    }
    */
    
    static func commentMarkdown(swiftObject: SwiftObject) -> String {
        guard var commentMarkdownString = commentTemplate else {
            return ""
        }
        
        if let doc_comment = swiftObject.doc_comment {
            commentMarkdownString = commentMarkdownString.stringByReplacingOccurrencesOfString("%doc_comment%", withString: doc_comment)
        } else {
            commentMarkdownString = commentMarkdownString.stringByReplacingOccurrencesOfString("%doc_comment%", withString: "")
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
            declarationMarkdownString = declarationMarkdownString.stringByReplacingOccurrencesOfString("%parsed_declaration%", withString: "")
        }
        
        return declarationMarkdownString
    }
    
    static func outputMarkdown() {
        for swiftFile in SwiftDocsParser.swiftFiles {
            for swiftModule in swiftFile.substructure {
                
                writeSwiftMarkdownFile(swiftModule)
                
                print(swiftModule.kind)
                print(swiftModule.parsed_declaration)
                print(swiftModule.doc_comment)
                print(swiftModule.name)
                print(swiftModule.accessibility)
                print(swiftModule.substructure?.count)
            }
        }
    }
    
    static func writeSwiftMarkdownFile(swiftModule: SwiftModule) {
        
        var moduleString: String?
        switch swiftModule.kind {
        case "source.lang.swift.decl.class":
            moduleString = classMarkdownWithSwiftModule(swiftModule)
            let _ = swiftModule.substructure?.map {
                moduleString = moduleString! + methodMarkdownWithSwiftObject($0)
            }
        default:
            return
        }
        
        guard let string = moduleString else {
            return
        }
        
        let filePath = testPath + "/" + swiftModule.name + ".md"
        do {
            try string.writeToFile(filePath, atomically: true, encoding: NSUTF8StringEncoding)
        } catch let error as NSError {
            print(error.debugDescription)
            return
        }
        
        print(filePath)
    }
}
