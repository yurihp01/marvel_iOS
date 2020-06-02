//
//  desafio_ios_yuri_pedrosoTests.swift
//  desafio-ios-yuri-pedrosoTests
//
//  Created by Yuri on 26/05/20.
//  Copyright © 2020 DevVenture. All rights reserved.
//

import XCTest
@testable import desafio_ios_yuri_pedroso

class desafio_ios_yuri_pedrosoTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAPIError() throws {
        let responseMessage = APIError.responseMessage("Tivemos um problema")
        let statusCode = APIError.invalidStatusCode(115)
        let invalidJson = APIError.invalidJson
        let badResponse = APIError.badResponse
        let badURL = APIError.badURL
        let isEmpty = APIError.isEmpty
        let noData = APIError.noData
        XCTAssertEqual(responseMessage.localizedDescription, "O erro encontrado é: 'Tivemos um problema'")
        XCTAssertEqual(statusCode.localizedDescription, "O status code não é o 200, favor validar o código 115!")
        XCTAssertEqual(invalidJson.localizedDescription, "Houve um erro na decodificação do JSON!")
        XCTAssertEqual(badResponse.localizedDescription, "A response é inválida!")
        XCTAssertEqual(badURL.localizedDescription, "A url é inválida!")
        XCTAssertEqual(isEmpty.localizedDescription, "Não foram encontrados dados relacionados ao personagem escolhido! 😢 \nPor favor, volte e selecione outro personagem!")
        XCTAssertEqual(noData.localizedDescription, "A API não retornou nenhum dado")
    }

    func testPriceFormatter() throws {
       let formatter = NumberFormatter()
       formatter.locale = Locale(identifier: "pt_BR")
       formatter.currencyDecimalSeparator = ","
       formatter.currencyGroupingSeparator = "."
       formatter.numberStyle = .currency
        XCTAssert(formatter.string(from: NSNumber(value: 300.00)) == "R$\u{00a0}300,00")
    }

}
