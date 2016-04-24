//
//  MarkdownOutput.swift
//  Pancake
//
//  Created by JPMartha on 2016/02/13.
//  Copyright © 2016 JPMartha. All rights reserved.
//

import Foundation
import SourceKittenFramework

struct MarkdownOutput {
    static var swiftGlobalObjects = [SwiftObject]()
    static var globalVariables = ""
    
    static func outputMarkdownWithOutPath(outPath: String) {
        CreateDocumentationDirectory.createDirectoryAtPath(outPath)
        
        SwiftDocsParser.swiftObjects.forEach {
            if let swiftObjects = $0.substructure {
                swiftObjects.forEach {
                    writeMarkdownFile($0, outPath: outPath)
                }
            }
        }
        
        if swiftGlobalObjects.count > 0 {
            var a = TemplateType.GlobalVariables.markdownString()
            a = a.stringByReplacingOccurrencesOfString(ReplaceTarget.Global.variables, withString: globalVariables)
            print("Generating Global.md")
            let filePath = outPath + "/Global.md"
            WriteToFile.writeToFileWithString(a, filePath: filePath)
        }
    }
    
    static func writeMarkdownFile(swiftObject: SwiftObject, outPath: String) {
        guard var name = swiftObject.name,
            let kind = swiftObject.kind,
            swiftDeclarationKind = SwiftDeclarationKind(rawValue: kind) else {
                return
        }
        
        var moduleString = ""
        switch swiftDeclarationKind {
        case .VarGlobal:
            swiftGlobalObjects.append(swiftObject)
            var valGlobal = MarkdownGenerator.memberPropertyMarkdownWithSwiftObject(swiftObject)
            valGlobal = valGlobal.stringByReplacingOccurrencesOfString(ReplaceTarget.Global.variables, withString: valGlobal)
            globalVariables += valGlobal
            return
        case .Class:
            moduleString = MarkdownGenerator.classesMarkdownWithSwiftObject(swiftObject)
        case .Struct:
            moduleString = MarkdownGenerator.structuresMarkdownWithSwiftObject(swiftObject)
        case .Enum:
            moduleString = MarkdownGenerator.globalEnumerationMarkdownStringWithSwiftObject(swiftObject)
        default:
            return
        }
        
        var enumerations = ""
        var properties = ""
        var methods = ""
        swiftObject.substructure?.forEach {
            if swiftObject.kind == SwiftDeclarationKind.Class.rawValue
                || swiftObject.kind == SwiftDeclarationKind.Struct.rawValue {
                    if let kind = $0.kind, swiftDeclarationKind = SwiftDeclarationKind(rawValue: kind) {
                        switch swiftDeclarationKind {
                        case .Enum:
                            enumerations += MarkdownGenerator.memberEnumerationMarkdownWithSwiftObject($0)
                        case .VarInstance:
                            properties += MarkdownGenerator.memberPropertyMarkdownWithSwiftObject($0)
                        case .FunctionMethodClass, .FunctionMethodInstance, .FunctionMethodStatic:
                            methods += MarkdownGenerator.memberMethodMarkdownWithSwiftObject($0)
                        default:
                            break
                        }
                    }
            }
        }
        
        // MARK: -
        
        if enumerations.isEmpty {
            moduleString = moduleString.stringByReplacingOccurrencesOfString(ReplaceTarget.ClassesAndStructures.enumerations, withString: "")
        } else {
            let e = TemplateType.Enumerations.markdownStringWithTargetString(ReplaceTarget.Member.enumerations, withString: enumerations)
            moduleString = moduleString.stringByReplacingOccurrencesOfString(ReplaceTarget.ClassesAndStructures.enumerations, withString: e)
        }
        
        if properties.isEmpty {
            moduleString = moduleString.stringByReplacingOccurrencesOfString(ReplaceTarget.ClassesAndStructures.properties, withString: "")
        } else {
            let p = TemplateType.Properties.markdownStringWithTargetString(ReplaceTarget.Member.properties, withString: properties)
            moduleString = moduleString.stringByReplacingOccurrencesOfString(ReplaceTarget.ClassesAndStructures.properties, withString: p)
        }
        
        if methods.isEmpty {
            moduleString = moduleString.stringByReplacingOccurrencesOfString(ReplaceTarget.ClassesAndStructures.methods, withString: "")
        } else {
            let m = TemplateType.Methods.markdownStringWithTargetString(ReplaceTarget.Member.methods, withString: methods)
            moduleString = moduleString.stringByReplacingOccurrencesOfString(ReplaceTarget.ClassesAndStructures.methods, withString: m)
        }
        
        switch swiftDeclarationKind {
        case .Enum:
            name += "Enumeration"
        case .Class:
            name += "Class"
        case .Struct:
            name += "Structure"
        default:
            return
        }
        
        let filename = name + ".md"
        print("Generating \(filename)")
        let filePath = outPath + "/" + filename
        WriteToFile.writeToFileWithString(moduleString, filePath: filePath)
    }

}