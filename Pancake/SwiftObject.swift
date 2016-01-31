//
//  SwiftObject.swift
//  Pancake
//
//  Created by JPMartha on 2016/01/26.
//  Copyright © 2016 JPMartha. All rights reserved.
//

import Foundation
import SourceKittenFramework
import Himotoki

struct SwiftObject: Decodable {
    let accessibility: String?
    let kind: String?
    let name: String?
    let parsed_declaration: String?
    let doc_comment: String?
    let parameters: [DocParameters]?
    let result_discussion: [Discussion]?
    let substructure: [SwiftObject]?
    
    static func decode(e: Extractor) throws -> SwiftObject {
        return try SwiftObject(
            accessibility: e <|? "key.accessibility",
            kind: e <|? "key.kind",
            name: e <|? "key.name",
            parsed_declaration: e <|? "key.parsed_declaration",
            doc_comment: e <|? "key.doc.comment",
            parameters: e <||? "key.doc.parameters",
            result_discussion: e <||? "key.doc.result_discussion",
            substructure: e <||? "key.substructure"
        )
    }
}

struct DocParameters: Decodable {
    let name: String?
    let discussion: [Discussion]?
    
    static func decode(e: Extractor) throws -> DocParameters {
        return try DocParameters(
            name: e <|? "name",
            discussion: e <||? "discussion"
        )
    }
}

struct Discussion: Decodable {
    let para: String?
    
    static func decode(e: Extractor) throws -> Discussion {
        return try Discussion(
            para: e <|? "Para"
        )
    }
}
