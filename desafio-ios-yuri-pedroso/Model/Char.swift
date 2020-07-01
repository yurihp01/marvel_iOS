//
//  MarvelChar.swift
//  desafio-ios-yuri-pedroso
//
//  Created by Yuri on 26/05/20.
//  Copyright © 2020 DevVenture. All rights reserved.
//

import Foundation

struct Char: Codable {
    let id: Int
    let name: String
    let thumbnail: Thumbnail
    let description: String?
    
    var image: String {
        return "\(thumbnail.path).\(thumbnail.extensionType)"
    }
    var url: URL {
        URL(string: image) ?? URL(fileURLWithPath: "")
    }
}

struct Thumbnail: Codable {
   let path: String
   let extensionType: String
    
    private enum CodingKeys : String, CodingKey {
        case extensionType = "extension"
        case path = "path"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        extensionType = try container.decode(String.self, forKey: .extensionType)
        path = try container.decode(String.self, forKey: .path)
    }
}



