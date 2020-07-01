//
//  MarvelAlert.swift
//  desafio-ios-yuri-pedroso
//
//  Created by Yuri on 31/05/20.
//  Copyright © 2020 DevVenture. All rights reserved.
//

import UIKit

final class MarvelAlert {
    
    private init() {}
    
    static func showAlertDialog(title: String, message: String) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        return alert
    }
}
