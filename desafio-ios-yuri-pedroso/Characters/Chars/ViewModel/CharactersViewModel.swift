//
//  CharactersViewModel.swift
//  desafio-ios-yuri-pedroso
//
//  Created by Yuri on 07/06/20.
//  Copyright © 2020 DevVenture. All rights reserved.
//

import Foundation

class CharactersViewModel {
    
    lazy var chars: [Char] = []
    
    init() {
        print("INITIALIZATION - CharacterViewModel")
    }
    
    deinit {
        print("DEINITIALIZATION - CharacterViewModel")
    }
    
    func getMarvelCharacters(offset: Int, onComplete: @escaping (Result<Bool, APIError>, Int?) -> Void) {
        MarvelAPI.getChars(offset: offset) { [weak self] (result, totalCharacters) in
            guard let self = self else { return }
                switch result {
                case .success(let characters):
                    guard let total = totalCharacters else { return }
                    self.chars = characters
                    onComplete(.success(true), total)
                    
                case .failure(let error):
                    onComplete(.failure(error), nil)
                }
        }
    }
}
