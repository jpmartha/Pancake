//
//  SwiftDocsParser.swift
//  Pancake
//
//  Created by JPMartha on 2016/01/22.
//  Copyright © 2016 JPMartha. All rights reserved.
//

import Foundation
import SourceKittenFramework
import SwiftXPC

class SwiftDocsParser {
    
    static var swiftFiles = [SwiftFile]()
    
    static func parse(SwiftDocs swiftDocs: [SwiftDocs]) {
        guard swiftDocs.count > 0 else {
            return
        }
        
        for swiftDoc in swiftDocs {
            let xpcDictionary = swiftDoc.docsDictionary
            
            guard let xpcSubstructure = xpcDictionary["key.substructure"] as? [XPCRepresentable] else {
                print("Failed to convert.")
                return
            }
            
            if let swiftFile = SwiftFile(substructure: xpcSubstructure) {
                swiftFiles.append(swiftFile)
            }
        }
        
        SwiftMarkdown.outputMarkdown()
    }
}
