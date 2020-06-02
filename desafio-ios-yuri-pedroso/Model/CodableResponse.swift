//
//  CodableResponse.swift
//  desafio-ios-yuri-pedroso
//
//  Created by Yuri on 29/05/20.
//  Copyright © 2020 DevVenture. All rights reserved.
//

import Foundation

struct MarvelResponse<T: Codable>: Codable {
    let data: MarvelResults<T>
}

struct MarvelResults<T: Codable>: Codable {
    let results: [T]
    let total: Int
}
