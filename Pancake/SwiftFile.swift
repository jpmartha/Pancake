//
//  SwiftFile.swift
//  Pancake
//
//  Created by JPMartha on 2016/01/26.
//  Copyright © 2016 JPMartha. All rights reserved.
//

import Foundation
import SourceKittenFramework
import Himotoki

protocol SwiftObjectType {}

struct SwiftFile: Decodable {
    let substructure: [SwiftObject]
    
    static func decode(e: Extractor) throws -> SwiftFile {
        return try SwiftFile(
            substructure: e <|| "key.substructure"
        )
    }
}

struct SwiftObject: Decodable, SwiftObjectType {
    let accessibility: String?
    let kind: String?
    let name: String?
    let parsed_declaration: String?
    let doc_comment: String?
    let substructure: [SwiftObject]?
    
    static func decode(e: Extractor) throws -> SwiftObject {
        return try SwiftObject(
            accessibility: e <|? "key.accessibility",
            kind: e <|? "key.kind",
            name: e <|? "key.name",
            parsed_declaration: e <|? "key.parsed_declaration",
            doc_comment: e <|? "key.doc_comment",
            substructure: e <||? "key.substructure"
        )
    }
}
