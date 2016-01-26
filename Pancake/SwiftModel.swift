//
//  SwiftModel.swift
//  Pancake
//
//  Created by JPMartha on 2016/01/21.
//  Copyright © 2016 JPMartha. All rights reserved.
//

import Foundation
import SourceKittenFramework

struct SwiftFile {
    let substructure: [SwiftModule]
    
    init?(fileSubstructure: [SourceKitRepresentable]) {
        var swiftModules = [SwiftModule]()
        for substructure in fileSubstructure {
            guard let dictionary = substructure as? [String: SourceKitRepresentable] else {
                print("Failed to convert Dictionary.")
                continue
            }
            
            if let swiftModule = SwiftModule(moduleDictionary: dictionary) {
                swiftModules.append(swiftModule)
            }
        }
        self.substructure = swiftModules
    }
}

struct SwiftModule {
    var kind: String
    var parsed_declaration: String
    var doc_comment: String?
    var name: String
    var accessibility: String
    var substructure: [SwiftObject]?
    
    init?(moduleDictionary: [String: SourceKitRepresentable]) {
        var swiftObjects = [SwiftObject]()
        guard let kind = moduleDictionary["key.kind"] as? String else {
            print("Failed to convert to kind.")
            return nil
        }
        guard let parsed_declaration = moduleDictionary["key.parsed_declaration"] as? String else {
            print("Failed to convert to parsed_declaration.")
            return nil
        }
        guard let name = moduleDictionary["key.name"] as? String else {
            print("Failed to convert to name.")
            return nil
        }
        guard let accessibility = moduleDictionary["key.accessibility"] as? String else {
            print("Failed to convert to accessibility.")
            return nil
        }
        
        self.kind = kind
        self.parsed_declaration = parsed_declaration
        
        if let doc_comment = moduleDictionary["key.doc.comment"] as? String {
            self.doc_comment = doc_comment
        } else {
            self.doc_comment = nil
        }
        
        self.name = name
        self.accessibility = accessibility
        
        if let substructure = moduleDictionary["key.substructure"] as? [SourceKitRepresentable] {
            for objectSubstructure in substructure {
                guard let dictionary = objectSubstructure as? [String: SourceKitRepresentable] else {
                    print("Failed to convert Dictionary.")
                    continue
                }
                if let swiftObject = SwiftObject(objectDictionary: dictionary) {
                    swiftObjects.append(swiftObject)
                }
            }
        }
        self.substructure = swiftObjects
    }
}

struct SwiftObject {
    var kind: String
    var parsed_declaration: String?  // enumには存在しない
    var doc_comment: String?
    var name: String
    var accessibility: String
    var substructure: [SwiftObject]?
    
    init?(objectDictionary: [String: SourceKitRepresentable]) {
        var swiftObjects = [SwiftObject]()
        guard let kind = objectDictionary["key.kind"] as? String else {
            print("Failed to convert to kind.")
            return nil
        }
        guard let name = objectDictionary["key.name"] as? String else {
            print("Failed to convert to name.")
            return nil
        }
        guard let accessibility = objectDictionary["key.accessibility"] as? String else {
            print("Failed to convert to accessibility.")
            return nil
        }
        
        self.kind = kind
        
        if let parsed_declaration = objectDictionary["key.parsed_declaration"] as? String {
            self.parsed_declaration = parsed_declaration
        } else {
            self.parsed_declaration = nil
        }
        
        if let doc_comment = objectDictionary["key.doc.comment"] as? String {
            self.doc_comment = doc_comment
        } else {
            self.doc_comment = nil
        }
        
        self.name = name
        self.accessibility = accessibility
        
        if let substructure = objectDictionary["key.substructure"] as? [SourceKitRepresentable] {
            for objectSubstructure in substructure {
                guard let dictionary = objectSubstructure as? [String: SourceKitRepresentable] else {
                    print("Failed to convert Dictionary.")
                    continue
                }
                
                if let swiftObject = SwiftObject(objectDictionary: dictionary) {
                    swiftObjects.append(swiftObject)
                }
            }
        }
        self.substructure = swiftObjects
    }
}
