//
//  MarvelComics.swift
//  desafio-ios-yuri-pedroso
//
//  Created by Yuri on 30/05/20.
//  Copyright © 2020 DevVenture. All rights reserved.
//

import Foundation

struct Comic: Codable {
    let title: String
    var description: String?
    let thumbnail: Thumbnail
    let prices: [Price]
    var id: Int
    
    var image: String {
        return "\(thumbnail.path).\(thumbnail.extensionType)"
    }
}

struct Price: Codable {
    let type: String
    let price: Double
    var priceValue: String {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "pt_BR")
        formatter.currencyDecimalSeparator = ","
        formatter.currencyGroupingSeparator = "."
        formatter.numberStyle = .currency
        return formatter.string(from: NSNumber(value: price)) ?? "\(price)"
    }
    
     private enum CodingKeys : String, CodingKey {
        case type = "type"
        case price = "price"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        type = try container.decode(String.self, forKey: .type)
        price = try container.decode(Double.self, forKey: .price)
    }
}
