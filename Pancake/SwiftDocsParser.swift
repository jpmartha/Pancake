//
//  SwiftDocsParser.swift
//  Pancake
//
//  Created by JPMartha on 2016/01/22.
//  Copyright © 2016 JPMartha. All rights reserved.
//

import Foundation
import SourceKittenFramework

class SwiftDocsParser {
    
    static var swiftFiles = [SwiftFile]()
    
    static func parse(SwiftDocs swiftDocs: [SwiftDocs]) {
        guard swiftDocs.count > 0 else {
            return
        }
        print("swiftDocs.count: \(swiftDocs.count)")

        let _ = swiftDocs.map {
            
            print($0.description)
            
            let xpcDictionary = $0.docsDictionary
            guard let fileSubstructure = xpcDictionary["key.substructure"] as? [SourceKitRepresentable] else {
                print("Failed to convert FileSubstructure.")
                return
            }
            
            if let swiftFile = SwiftFile(fileSubstructure: fileSubstructure) {
                swiftFiles.append(swiftFile)
            }
        }
        SwiftMarkdown.outputMarkdown()
    }
}
