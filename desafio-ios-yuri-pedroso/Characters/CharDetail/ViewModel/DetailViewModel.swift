//
//  DetailViewModel.swift
//  desafio-ios-yuri-pedroso
//
//  Created by Yuri on 05/06/20.
//  Copyright © 2020 DevVenture. All rights reserved.
//

import Foundation

class DetailViewModel {
    
    
    let char: Char
    
    var url: URL {
        char.url
    }
    
    var description: String {
        guard let description = char.description, !description.isEmpty else {
            return "Este personagem não possui descrição!"
        }
        
        return description
    }
    
    var title: String {
        "Personagem"
    }
    
    var name: String {
        char.name
    }
    
    var thumbnail: Thumbnail {
        char.thumbnail
    }
    
    init(char: Char) {
        self.char = char
        print({"INITIALIZATION -> DETAILVIEWMODEL"})
    }
    
    deinit {
        print({"DEINITIALIZATION -> DETAILVIEWMODEL"})
    }
    
    
}
