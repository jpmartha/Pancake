//
//  Model.swift
//  Pancake
//
//  Created by JPMartha on 2016/01/21.
//  Copyright © 2016 JPMartha. All rights reserved.
//

import Foundation
import SwiftXPC

struct SwiftFile {
    let substructure: [SwiftObject]
    
    init?(substructure: [XPCRepresentable]) {
        var swiftObjects = [SwiftObject]()
        for sub in substructure {
            if let swiftObject = SwiftObject(substructure: sub) {
                swiftObjects.append(swiftObject)
            }
        }
        self.substructure = swiftObjects
    }
}

struct SwiftObject {
    var kind: String
    var parsed_declaration: String
    var name: String
    var accessibility: String
    var substructure: [SwiftObject]?
    
    init?(substructure: XPCRepresentable) {
        var swiftObjects = [SwiftObject]()
        
        guard let dictionary = substructure as? [String: XPCRepresentable] else {
            print("Failed to convert to dictionary.")
            return nil
        }
        guard let kind = dictionary["key.kind"] as? String else {
            print("Failed to convert to kind.")
            return nil
        }
        guard let parsed_declaration = dictionary["key.parsed_declaration"] as? String else {
            print("Failed to convert to parsed_declaration.")
            return nil
        }
        guard let name = dictionary["key.name"] as? String else {
            print("Failed to convert to name.")
            return nil
        }
        guard let accessibility = dictionary["key.accessibility"] as? String else {
            print("Failed to convert to accessibility.")
            return nil
        }
        
        self.kind = kind
        self.parsed_declaration = parsed_declaration

        self.name = name
        self.accessibility = accessibility

        if let substructures = dictionary["key.substructure"] as? [XPCRepresentable] {
            for substructure in substructures {
                if let swiftObject = SwiftObject(substructure: substructure) {
                    swiftObjects.append(swiftObject)
                }
            }
            self.substructure = swiftObjects
        } else {
            self.substructure = nil
        }
    }
}
