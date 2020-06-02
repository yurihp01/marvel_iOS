//
//  APIError.swift
//  desafio-ios-yuri-pedroso
//
//  Created by Yuri on 01/06/20.
//  Copyright © 2020 DevVenture. All rights reserved.
//

import Foundation

enum APIError: Error {
    case isEmpty
    case invalidJson
    case badURL
    case badResponse
    case invalidStatusCode(_ statusCode: Int)
    case noData
    case responseMessage(_ message: String)
}

extension APIError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .responseMessage(let message):
            return "O erro encontrado é: '\(message)'"
        case .badResponse:
            return "A response é inválida!"
        case .badURL:
            return "A url é inválida!"
        case .invalidJson:
            return "Houve um erro na decodificação do JSON!"
        case .invalidStatusCode(let statusCode):
            return "O status code não é o 200, favor validar o código \(statusCode)!"
        case .isEmpty:
            return "Não foram encontrados dados relacionados ao personagem escolhido! 😢 \nPor favor, volte e selecione outro personagem!"
        case .noData:
            return "A API não retornou nenhum dado"
        }
    }
}
