//
//  SwiftEnumerations.swift
//  Pancake
//
//  Created by JPMartha on 2016/01/26.
//  Copyright © 2016 JPMartha. All rights reserved.
//

import Foundation
import SourceKittenFramework

struct SwiftEnumcase {
    let kind = "source.lang.swift.decl.enumcase"
    var substructure: SwiftEnumelement
    
    init(dictionary: [String: SourceKitRepresentable]) throws {
        guard let dicKind = dictionary["key.kind"] as? String else {
            throw ConvertError.ConvertToKindError(dictionary["key.kind"])
        }
        guard kind == dicKind else {
            throw MismatchError.MismatchKindError(dicKind)
        }
        guard let substructure = dictionary["key.substructure"] as? [SourceKitRepresentable] else {
            throw ConvertError.ConvertToSubstructureError(dictionary["key.substructure"])
        }
        guard let dictionary = substructure.first as? [String: SourceKitRepresentable] else {
            throw ConvertError.ConvertToDictionary(substructure.first)
        }
        
        do {
            self.substructure = try SwiftEnumelement(dictionary: dictionary)
        } catch let errorType {
            throw errorType
        }
    }
}

struct SwiftEnumelement {
    let kind = "source.lang.swift.decl.enumelement"
    var parsed_declaration: String
    var name: String
    var accessibility: String
    
    init(dictionary: [String: SourceKitRepresentable]) throws {
        guard let dicKind = dictionary["key.kind"] as? String else {
            throw ConvertError.ConvertToKindError(dictionary["key.kind"])
        }
        guard kind == dicKind else {
            throw MismatchError.MismatchKindError(dicKind)
        }
        guard let parsed_declaration = dictionary["key.parsed_declaration"] as? String else {
            throw ConvertError.ConvertToDeclarationError(dictionary["key.parsed_declaration"])
        }
        guard let name = dictionary["key.name"] as? String else {
            throw ConvertError.ConvertToNameError(dictionary["key.name"])
        }
        guard let accessibility = dictionary["key.accessibility"] as? String else {
            throw ConvertError.ConvertToAccessibilityError(dictionary["key.accessibility"])
        }
        
        self.parsed_declaration = parsed_declaration
        self.name = name
        self.accessibility = accessibility
    }
}
