//
//  ComicViewModel.swift
//  desafio-ios-yuri-pedroso
//
//  Created by Yuri on 03/06/20.
//  Copyright © 2020 DevVenture. All rights reserved.
//

import Foundation

class ComicViewModel {
    
    private let char: Char
    
    var name: String {
        char.name
    }
    
    init(char: Char) {
        self.char = char
    }
    
    func getComicCharactersById(onComplete: @escaping (Result<(Comic, String), APIError>) -> Void) {
        
        MarvelAPI.getComic(charId: char.id) { [weak self] (result) in
            guard let _ = self else { return }
            
            switch result {
            case .success(let comics):
                var highestPrice = -1.0
                var priceFormatted = ""
                var marvelComic: Comic?
                
                comics.forEach { (comic) in
                    guard let price = comic.prices.max(by: { (p1, p2) -> Bool in
                        return p1.price < p2.price
                    }) else { return }
                    
                    if highestPrice < price.price {
                        
                        marvelComic = comic
                        highestPrice = price.price
                        priceFormatted = price.priceValue
                    }
                }
                
                onComplete(.success((marvelComic ?? comics[0], priceFormatted)))
            case .failure(let error):
                onComplete(.failure(error))
            }
        }
    }
    
}
